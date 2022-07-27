
#include "./matter_core.mligo"

type raw_lambda = (unit) -> (operation list)

let get_mttr_op (ts, cfg : timestamp * (fa2_currency, farm_params) map) : operation = begin

  let zero_tz : tez = 0mutez in
  let mttr_core : address = ("KT1K4jn23GonEmZot3pMGth7unnzZ6EaMVjY" : address) in

  let new_mttr_config : matter_config = {
    active_time = ts;
    allow_list_id = (None : nat option);
    farm_configs = cfg;
  } in

  let mttr_add_config : matter_config contract = 
  match (Tezos.get_entrypoint_opt "%addConfig" mttr_core : matter_config contract option) with
      None -> (failwith "FATAL3" : matter_config contract)
    | Some c ->  c
  in

  Tezos.transaction new_mttr_config zero_tz mttr_add_config
end

let run_c (_u : unit) : operation list = begin


  let zero_tz : tez = 0mutez in
  (* NEW MTTR CONFIGS *)

  (* main *)
  let tzbtc_lp_token : fa2_currency = {
    fa2_address = ("KT1FHewqgFXCjTJbYvLMhWL335ZV1qupN1c2" : address);
    token_id = 0n;
  } in

  (* main *)
  let usdtz_lp_token : fa2_currency = {
    fa2_address = ("KT1KgNVokovu4dSBFZXmFXgUni5TypwMBbRS" : address);
    token_id = 0n;
  } in

  (* main *)
  let btctz_lp_token : fa2_currency = {
    fa2_address = ("KT1M234AC3kz9uQ9vse8caidhKUMrZ3S2YjN" : address);
    token_id = 0n;
  } in

  (* main *)
  let kusd_lp_token : fa2_currency = {
    fa2_address = ("KT1NN1NgmKFTW5FUWiyxVjUt3kH9bCiqgxLW" : address);
    token_id = 0n;
  } in

  (* main *)
  let uusd_lp_token : fa2_currency = {
    fa2_address = ("KT1UefQz7nP8BuuDk5Dd5LWo22N1ZPB7JB5o" : address);
    token_id = 0n;
  } in

  (* main *)
  let usdce_lp_token : fa2_currency = {
    fa2_address = ("KT1VAbfwhE9DaZWdja4hg6CF77YPc1Ne9qvK" : address);
    token_id = 0n;
  } in

  (* main *)
  let wethe_lp_token : fa2_currency = {
    fa2_address = ("KT1WiDfeeRVpY2ao4ps4oJUgXi1wMWtD6sFa" : address);
    token_id = 0n;
  } in

  (* main *)
  let wbtce_lp_token : fa2_currency = {
    fa2_address = ("KT1GeH12st1t3sVnvUDxR8UKm6ouXxai1vnp" : address);
    token_id = 0n;
  } in

  (* main *)
  let usdt_lp_token : fa2_currency = {
    fa2_address = ("KT1WWZKv8sHrfRyjKVwsjugBEs3XoAZ4eWgB" : address);
    token_id = 0n;
  } in

  (* main *)
  let mttr_lp_token : fa2_currency = {
    fa2_address = ("KT1QQvdg7TGZAH85HtgNvQuoekNRegvQPk8R" : address);
    token_id = 0n;
  } in

  (* main *)
  let mttr_token : fa2_currency = {
    fa2_address = ("KT1K4jn23GonEmZot3pMGth7unnzZ6EaMVjY" : address);
    token_id = 0n;
  } in

  (* guest *)
  let mtria_lp_token : fa2_currency = {
    fa2_address = ("KT1RBLbqbdej7xy1bbqb4pG7YQJxFxQhc42Z" : address);
    token_id = 0n;
  } in

  (* bait *)
  let wtz_token : fa2_currency = {
    fa2_address = ("KT1PnUZCp3u2KzWr93pn4DD7HAJnm3rWVrgn" : address);
    token_id = 0n;
  } in

  let mttr_decimals = 1_000_000_000_000n in

  (* Current is 141  for BTCtz    pool *)
  (* Current is 2830 for uUSD     pool *)
  (* Current is 707  for other 6 pools *)
  (* Current is 1248 for MTTR/WTZ pool *)
  (* Current is 624  for MTTR     pool *)

  (* 9085 Total *)

                                             (* day   min   sec *)
  (* Current is 141  for BTCtz    pool *)
  let  btctz_cut_50  = (70n *  mttr_decimals) / 24n / 60n / 60n in

  (* Current is 2830 for uUSD     pool *)
  let   uusd_cut_50  = (1415n * mttr_decimals) / 24n / 60n / 60n in

  (* Current is 1248 for MTTR/WTZ pool *)
  let mttrLP_cut_50  = (624n * mttr_decimals) / 24n / 60n / 60n in

  (* Current is 624  for MTTR     pool *)
  let   mttr_cut_50  = (312n * mttr_decimals) / 24n / 60n / 60n in

  (* Current is 707  for other 6 pools *)
  let others_cut_50  = (353n * mttr_decimals) / 24n / 60n / 60n in


  (* 4542 to USDT LP *)
  let add_to_tether  = (4542n * mttr_decimals) / 24n / 60n / 60n in

  let pct_5_fee =         50000000000000000n in

  let pct_0_point_5_fee =  5000000000000000n in

  let btctz : farm_params = {
    claimable = true;
    fee = pct_5_fee;
    reward_per_sec = btctz_cut_50;
    total_out =  (None : nat option);
  } in

  let uusd : farm_params = {
    claimable = true;
    fee = pct_5_fee;
    reward_per_sec = uusd_cut_50;
    total_out =  (None : nat option);
  } in

  let mttrwtz : farm_params = {
    claimable = true;
    fee = pct_0_point_5_fee;
    reward_per_sec = mttrLP_cut_50;
    total_out =  (None : nat option);
  } in

  let mttr : farm_params = {
    claimable = true;
    fee = pct_0_point_5_fee;
    reward_per_sec = mttr_cut_50;
    total_out =  (None : nat option);
  } in

  let cut_50 : farm_params = {
    claimable = true;
    fee = pct_5_fee;
    reward_per_sec = others_cut_50;
    total_out =  (None : nat option);
  } in

  let tether : farm_params = {
    claimable = true;
    fee = pct_5_fee;
    reward_per_sec = add_to_tether;
    total_out =  (None : nat option);
  } in

  let new_farm_config_1 : (fa2_currency, farm_params) map = Map.literal [
    
    btctz_lp_token, btctz;

    uusd_lp_token,  uusd;
    
    mttr_lp_token,  mttrwtz;
    mttr_token,     mttr;

    usdce_lp_token, cut_50;
    wethe_lp_token, cut_50;
    wbtce_lp_token, cut_50;

    tzbtc_lp_token, cut_50;
    usdtz_lp_token, cut_50;
    kusd_lp_token,  cut_50;

    usdt_lp_token,  tether;
  ] in

  let change_mttr_1 : operation = get_mttr_op(("2022-08-06T20:00:00Z" : timestamp), new_farm_config_1) in

  [change_mttr_1]
end

let get_lambda : raw_lambda = run_c

(*
ligo compile expression cameligo get_lambda --init-file 'lambda_mttr_tether.mligo'
*)
