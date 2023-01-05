
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
  let mttr_core : address = ("KT1K4jn23GonEmZot3pMGth7unnzZ6EaMVjY" : address) in

  (* CONFIRM MTTR ADMIN *)
  let mttr_confirm_admin_contract : unit contract = 
  match (Tezos.get_entrypoint_opt "%confirm_admin" mttr_core : unit contract option) with
      None -> (failwith "FATAL2" : unit contract)
    | Some c ->  c
  in

  let accept_mttr_admin : operation = Tezos.transaction unit zero_tz mttr_confirm_admin_contract in
  (* CONFIRM MTTR ADMIN *)

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
  let sdao_lp_token : fa2_currency = {
    fa2_address = ("KT1TGzfW1ME3QzfiHWgTUnTyJubv5mk2ZuHK" : address);
    token_id = 0n;
  } in

  (* main *)
  let stable_lp_token : fa2_currency = {
    fa2_address = ("KT1DrmeTCcWa3ffXMYHp3QsqVF5D4sgBfisM" : address);
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
  let up_lp_token : fa2_currency = {
    fa2_address = ("KT1HbXV1HZrmuwbbiVAyRCkRjMV8xbqjavMU" : address);
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

  let mu_mttr_decimals = 1_000_000n in


  (* ALL NOTATIONS IN muMTTR/sec to match the front *)

  (* btctz + wbtc.e + usdtz + kusd + usdc.e *)
  let  mu_mttr_40   = (40n * mu_mttr_decimals) in

  (* wethe + tzBTC *)
  let  mu_mttr_405  = (405n * mu_mttr_decimals) in

  (* uusd + usdt *)
  let  mu_mttr_2894 = (2894n * mu_mttr_decimals) in

  (* MTTR & UP LP ) *)
  let  mu_mttr_359  = (359n * mu_mttr_decimals) in

  (* MTTR LP & SDAO LP ) *)
  let  mu_mttr_718  = (718n * mu_mttr_decimals) in

  let  mu_mttr_stable  = (1447n * mu_mttr_decimals) in

  let pct_5_fee =         50000000000000000n in

  let pct_2_point_5_fee = 25000000000000000n in

  let pct_1_point_0_fee = 10000000000000000n in

  let pct_0_point_5_fee =  5000000000000000n in

  (* Standard farms & fees *)
  let farm_40 : farm_params = {
    claimable = true;
    fee = pct_5_fee;
    reward_per_sec = mu_mttr_40;
    total_out =  (None : nat option);
  } in

  let farm_405 : farm_params = {
    claimable = true;
    fee = pct_5_fee;
    reward_per_sec = mu_mttr_405;
    total_out =  (None : nat option);
  } in

  let farm_2894 : farm_params = {
    claimable = true;
    fee = pct_5_fee;
    reward_per_sec = mu_mttr_2894;
    total_out =  (None : nat option);
  } in

  (* Weird Fees *)
  let mttr : farm_params = {
    claimable = true;
    fee = pct_0_point_5_fee;
    reward_per_sec = mu_mttr_359;
    total_out =  (None : nat option);
  } in

  let mttr_lp : farm_params = {
    claimable = true;
    fee = pct_0_point_5_fee;
    reward_per_sec = mu_mttr_718;
    total_out =  (None : nat option);
  } in

  (* New farms *)
  let stable_lp : farm_params = {
    claimable = true;
    fee = pct_1_point_0_fee;
    reward_per_sec = mu_mttr_stable;
    total_out =  (None : nat option);
  } in

  let sdao_lp : farm_params = {
    claimable = true;
    fee = pct_1_point_0_fee;
    reward_per_sec = mu_mttr_718;
    total_out =  (None : nat option);
  } in

  let up_lp : farm_params = {
    claimable = true;
    fee = pct_2_point_5_fee;
    reward_per_sec = mu_mttr_359;
    total_out =  (None : nat option);
  } in

  let new_farm_config_1 : (fa2_currency, farm_params) map = Map.literal [
    
    btctz_lp_token, farm_40;
    wbtce_lp_token, farm_40;
    usdtz_lp_token, farm_40;
    kusd_lp_token,  farm_40;
    usdce_lp_token, farm_40;

    wethe_lp_token, farm_405;
    tzbtc_lp_token, farm_405;
    
    uusd_lp_token,  farm_2894;
    usdt_lp_token,  farm_2894;

    mttr_token,     mttr;
    mttr_lp_token,  mttr_lp;

    stable_lp_token,stable_lp;
    sdao_lp_token,  sdao_lp;
    up_lp_token,    up_lp;

  ] in

  (* Reset fee to 0 as rewards are 0'd *)
  let up_lp_sunset : farm_params = {
    claimable = true;
    fee = 0n;
    reward_per_sec = 0n;
    total_out =  (None : nat option);
  } in

  let new_farm_config_2 : (fa2_currency, farm_params) map = Map.literal [
    
    btctz_lp_token, farm_40;
    wbtce_lp_token, farm_40;
    usdtz_lp_token, farm_40;
    kusd_lp_token,  farm_40;
    usdce_lp_token, farm_40;

    wethe_lp_token, farm_405;
    tzbtc_lp_token, farm_405;
    
    uusd_lp_token,  farm_2894;
    usdt_lp_token,  farm_2894;

    mttr_token,     mttr;
    mttr_lp_token,  mttr_lp;

    stable_lp_token,stable_lp;
    sdao_lp_token,  sdao_lp;
    up_lp_token,    up_lp_sunset;

  ] in

  let change_mttr_1 : operation = get_mttr_op(("2023-01-18T23:00:00Z" : timestamp), new_farm_config_1) in

  (* 4 weeks later. this can be removed *)
  let sunset_up : operation = get_mttr_op(("2023-02-15T23:00:00Z" : timestamp), new_farm_config_2) in

  accept_mttr_admin::change_mttr_1::[sunset_up]
end

let get_lambda : raw_lambda = run_c

(*
ligo compile expression cameligo get_lambda --init-file 'lambda_mttr_2023.mligo'

{ PUSH (lambda          (pair timestamp (map (pair address nat) (pair bool nat nat (option nat))))          operation)       { UNPAIR ;         PUSH address "KT1K4jn23GonEmZot3pMGth7unnzZ6EaMVjY" ;         CONTRACT %addConfig           (pair (timestamp %active_time)                 (map %farm_configs                    (pair (address %fa2_address) (nat %token_id))                    (pair (bool %claimable) (nat %fee) (nat %reward_per_sec) (option %total_out nat)))                 (option %allow_list_id nat)) ;         IF_NONE { PUSH string "FATAL3" ; FAILWITH } {} ;         PUSH mutez 0 ;         NONE nat ;         DIG 4 ;         DIG 4 ;         PAIR 3 ;         TRANSFER_TOKENS } ;  PAIR ;  { CAR ;    PUSH address "KT1K4jn23GonEmZot3pMGth7unnzZ6EaMVjY" ;    CONTRACT %confirm_admin unit ;    IF_NONE { PUSH string "FATAL2" ; FAILWITH } {} ;    PUSH mutez 0 ;    UNIT ;    TRANSFER_TOKENS ;    PUSH nat 0 ;    PUSH address "KT1FHewqgFXCjTJbYvLMhWL335ZV1qupN1c2" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1KgNVokovu4dSBFZXmFXgUni5TypwMBbRS" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1M234AC3kz9uQ9vse8caidhKUMrZ3S2YjN" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1NN1NgmKFTW5FUWiyxVjUt3kH9bCiqgxLW" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1UefQz7nP8BuuDk5Dd5LWo22N1ZPB7JB5o" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1VAbfwhE9DaZWdja4hg6CF77YPc1Ne9qvK" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1WiDfeeRVpY2ao4ps4oJUgXi1wMWtD6sFa" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1GeH12st1t3sVnvUDxR8UKm6ouXxai1vnp" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1WWZKv8sHrfRyjKVwsjugBEs3XoAZ4eWgB" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1TGzfW1ME3QzfiHWgTUnTyJubv5mk2ZuHK" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1DrmeTCcWa3ffXMYHp3QsqVF5D4sgBfisM" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1QQvdg7TGZAH85HtgNvQuoekNRegvQPk8R" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1K4jn23GonEmZot3pMGth7unnzZ6EaMVjY" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1HbXV1HZrmuwbbiVAyRCkRjMV8xbqjavMU" ;    PAIR ;    PUSH nat 1000000 ;    DUP ;    PUSH nat 40 ;    MUL ;    DUP 2 ;    PUSH nat 405 ;    MUL ;    DUP 3 ;    PUSH nat 2894 ;    MUL ;    DUP 4 ;    PUSH nat 359 ;    MUL ;    DUP 5 ;    PUSH nat 718 ;    MUL ;    DIG 5 ;    PUSH nat 1447 ;    MUL ;    PUSH nat 50000000000000000 ;    PUSH nat 10000000000000000 ;    PUSH nat 5000000000000000 ;    NONE nat ;    DIG 9 ;    DUP 5 ;    PUSH bool True ;    PAIR 4 ;    NONE nat ;    DIG 9 ;    DUP 6 ;    PUSH bool True ;    PAIR 4 ;    NONE nat ;    DIG 9 ;    DIG 6 ;    PUSH bool True ;    PAIR 4 ;    NONE nat ;    DUP 9 ;    DUP 6 ;    PUSH bool True ;    PAIR 4 ;    NONE nat ;    DUP 9 ;    DIG 6 ;    PUSH bool True ;    PAIR 4 ;    NONE nat ;    DIG 7 ;    DUP 8 ;    PUSH bool True ;    PAIR 4 ;    NONE nat ;    DIG 8 ;    DIG 8 ;    PUSH bool True ;    PAIR 4 ;    EMPTY_MAP (pair address nat) (pair bool nat nat (option nat)) ;    NONE nat ;    DIG 9 ;    PUSH nat 25000000000000000 ;    PUSH bool True ;    PAIR 4 ;    DUP 10 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 2 ;    DUP 14 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 3 ;    DUP 13 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 4 ;    DUP 12 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 5 ;    DUP 11 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 6 ;    DUP 15 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 6 ;    DUP 19 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 7 ;    DUP 23 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 7 ;    DUP 17 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 8 ;    DUP 18 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 8 ;    DUP 20 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 8 ;    DUP 22 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 8 ;    DUP 16 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 8 ;    DUP 21 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    PUSH timestamp "2023-01-18T23:00:00Z" ;    PAIR ;    DUP 24 ;    SWAP ;    EXEC ;    EMPTY_MAP (pair address nat) (pair bool nat nat (option nat)) ;    NONE nat ;    PUSH nat 0 ;    PUSH nat 0 ;    PUSH bool True ;    PAIR 4 ;    DIG 10 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DIG 2 ;    DIG 12 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DIG 2 ;    DIG 10 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DIG 2 ;    DIG 8 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DIG 2 ;    DIG 6 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 3 ;    DIG 6 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DIG 2 ;    DIG 8 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 3 ;    DIG 11 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DIG 2 ;    DIG 5 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 3 ;    DIG 5 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 3 ;    DIG 5 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 3 ;    DIG 6 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 3 ;    DIG 4 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DIG 2 ;    DIG 3 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    PUSH timestamp "2023-02-15T23:00:00Z" ;    PAIR ;    DIG 3 ;    SWAP ;    EXEC ;    NIL operation ;    SWAP ;    CONS ;    SWAP ;    CONS ;    SWAP ;    CONS } }
*)
