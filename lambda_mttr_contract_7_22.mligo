
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

  (* raw # with decimals *)
  (* let mttr_target_1yr_wk_5 =   3037500n * mttr_decimals in *)


  (* raw # with decimals *)
  (* .063419583967 *)
(*   let mttr_target_sec = mttr_target_1yr_wk_5 / 365n / 24n / 60n / 60n in

  let mttr_pct_17 = (mttr_target_sec *   170_000n) / 1_000_000n in
  
  let mttr_pct_10 = (mttr_target_sec *   100_000n) / 1_000_000n in

  let mttr_pct_5 =  (mttr_target_sec *    50_000n) / 1_000_000n in

  let one_third_mttr_pct_17 = (mttr_pct_17 *   333_333n) / 1_000_000n in
  let two_third_mttr_pct_17 = (mttr_pct_17 *   666_666n) / 1_000_000n in *)

  let mttr_decimals = 1_000_000_000_000n in
                                              (* day   min   sec *)
  let current_cut_90  = (141n * mttr_decimals) / 24n / 60n / 60n in
  let current_cut_70  = (424n * mttr_decimals) / 24n / 60n / 60n in
  let current_cut_50  = (707n * mttr_decimals) / 24n / 60n / 60n in

  let current_double  = 2830n * mttr_decimals / 24n / 60n / 60n in

  let current_mttrwtz = 1248n * mttr_decimals / 24n / 60n / 60n in
  let current_mttr    =  624n * mttr_decimals / 24n / 60n / 60n in

  let pct_5_fee =         50000000000000000n in

  let pct_0_point_5_fee =  5000000000000000n in

  (* 5 of these *)
  let cut_90 : farm_params = {
    claimable = true;
    fee = pct_5_fee;
    reward_per_sec = current_cut_90;
    total_out =  (None : nat option);
  } in

  let cut_70 : farm_params = {
    claimable = true;
    fee = pct_5_fee;
    reward_per_sec = current_cut_70;
    total_out =  (None : nat option);
  } in

  let cut_50 : farm_params = {
    claimable = true;
    fee = pct_5_fee;
    reward_per_sec = current_cut_50;
    total_out =  (None : nat option);
  } in

  let uusd : farm_params = {
    claimable = true;
    fee = pct_5_fee;
    reward_per_sec = current_double;
    total_out =  (None : nat option);
  } in

  let mttrwtz : farm_params = {
    claimable = true;
    fee = pct_0_point_5_fee;
    reward_per_sec = current_mttrwtz;
    total_out =  (None : nat option);
  } in

  let mttr : farm_params = {
    claimable = true;
    fee = pct_0_point_5_fee;
    reward_per_sec = current_mttr;
    total_out =  (None : nat option);
  } in

  let new_farm_config_1 : (fa2_currency, farm_params) map = Map.literal [
    usdce_lp_token, cut_90;
    wethe_lp_token, cut_90;
    wbtce_lp_token, cut_90;

    tzbtc_lp_token, cut_90;
    usdtz_lp_token, cut_90;
    kusd_lp_token,  cut_90;
    btctz_lp_token, cut_90;

    uusd_lp_token,  uusd;
    
    mttr_lp_token,  mttrwtz;
    mttr_token,     mttr;
  ] in

  let new_farm_config_2 : (fa2_currency, farm_params) map = Map.literal [
    usdce_lp_token, cut_70;
    wethe_lp_token, cut_70;
    wbtce_lp_token, cut_70;

    tzbtc_lp_token, cut_70;
    usdtz_lp_token, cut_70;
    kusd_lp_token,  cut_70;
    
    btctz_lp_token, cut_90;

    uusd_lp_token,  uusd;
    
    mttr_lp_token,  mttrwtz;
    mttr_token,     mttr;
  ] in

  let new_farm_config_3 : (fa2_currency, farm_params) map = Map.literal [
    usdce_lp_token, cut_50;
    wethe_lp_token, cut_50;
    wbtce_lp_token, cut_50;

    tzbtc_lp_token, cut_50;
    usdtz_lp_token, cut_50;
    kusd_lp_token,  cut_50;

    btctz_lp_token, cut_90;

    uusd_lp_token,  uusd;
    
    mttr_lp_token,  mttrwtz;
    mttr_token,     mttr;
  ] in

  let change_mttr_1 : operation = get_mttr_op(("2022-07-08T08:00:00Z" : timestamp), new_farm_config_1) in
  let change_mttr_2 : operation = get_mttr_op(("2022-07-15T08:00:00Z" : timestamp), new_farm_config_2) in
  let change_mttr_3 : operation = get_mttr_op(("2022-07-22T08:00:00Z" : timestamp), new_farm_config_3) in

  change_mttr_1::change_mttr_2::[change_mttr_3]
end

let get_lambda : raw_lambda = run_c

(*
ligo compile expression cameligo get_lambda --init-file 'lambda_mttr_contract_7_22.mligo'

{ PUSH (lambda          (pair timestamp (map (pair address nat) (pair bool nat nat (option nat))))          operation)       { UNPAIR ;         PUSH address "KT1K4jn23GonEmZot3pMGth7unnzZ6EaMVjY" ;         CONTRACT %addConfig           (pair (timestamp %active_time)                 (map %farm_configs                    (pair (address %fa2_address) (nat %token_id))                    (pair (bool %claimable) (nat %fee) (nat %reward_per_sec) (option %total_out nat)))                 (option %allow_list_id nat)) ;         IF_NONE { PUSH string "FATAL3" ; FAILWITH } {} ;         PUSH mutez 0 ;         NONE nat ;         DIG 4 ;         DIG 4 ;         PAIR 3 ;         TRANSFER_TOKENS } ;  PAIR ;  { CAR ;    PUSH nat 0 ;    PUSH address "KT1FHewqgFXCjTJbYvLMhWL335ZV1qupN1c2" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1KgNVokovu4dSBFZXmFXgUni5TypwMBbRS" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1M234AC3kz9uQ9vse8caidhKUMrZ3S2YjN" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1NN1NgmKFTW5FUWiyxVjUt3kH9bCiqgxLW" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1UefQz7nP8BuuDk5Dd5LWo22N1ZPB7JB5o" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1VAbfwhE9DaZWdja4hg6CF77YPc1Ne9qvK" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1WiDfeeRVpY2ao4ps4oJUgXi1wMWtD6sFa" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1GeH12st1t3sVnvUDxR8UKm6ouXxai1vnp" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1QQvdg7TGZAH85HtgNvQuoekNRegvQPk8R" ;    PAIR ;    PUSH nat 0 ;    PUSH address "KT1K4jn23GonEmZot3pMGth7unnzZ6EaMVjY" ;    PAIR ;    PUSH nat 1000000000000 ;    PUSH nat 60 ;    PUSH nat 60 ;    PUSH nat 24 ;    DUP 4 ;    PUSH nat 141 ;    MUL ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    PUSH nat 60 ;    PUSH nat 60 ;    PUSH nat 24 ;    DUP 5 ;    PUSH nat 424 ;    MUL ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    PUSH nat 60 ;    PUSH nat 60 ;    PUSH nat 24 ;    DUP 6 ;    PUSH nat 707 ;    MUL ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    PUSH nat 60 ;    PUSH nat 60 ;    PUSH nat 24 ;    DUP 7 ;    PUSH nat 2830 ;    MUL ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    PUSH nat 60 ;    PUSH nat 60 ;    PUSH nat 24 ;    DUP 8 ;    PUSH nat 1248 ;    MUL ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    PUSH nat 60 ;    PUSH nat 60 ;    PUSH nat 24 ;    DIG 8 ;    PUSH nat 624 ;    MUL ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    EDIV ;    IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;    CAR ;    PUSH nat 50000000000000000 ;    PUSH nat 5000000000000000 ;    NONE nat ;    DIG 8 ;    DUP 4 ;    PUSH bool True ;    PAIR 4 ;    NONE nat ;    DIG 8 ;    DUP 5 ;    PUSH bool True ;    PAIR 4 ;    NONE nat ;    DIG 8 ;    DUP 6 ;    PUSH bool True ;    PAIR 4 ;    NONE nat ;    DIG 8 ;    DIG 6 ;    PUSH bool True ;    PAIR 4 ;    NONE nat ;    DIG 7 ;    DUP 7 ;    PUSH bool True ;    PAIR 4 ;    NONE nat ;    DIG 7 ;    DIG 7 ;    PUSH bool True ;    PAIR 4 ;    EMPTY_MAP (pair address nat) (pair bool nat nat (option nat)) ;    DUP 7 ;    DUP 12 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 7 ;    DUP 11 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 4 ;    DUP 14 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 7 ;    DUP 17 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 7 ;    DUP 13 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 7 ;    DUP 18 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    SWAP ;    DUP ;    DUG 2 ;    DUP 9 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 3 ;    DUP 10 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 7 ;    DUP 15 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 7 ;    DUP 16 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    PUSH timestamp "2022-07-08T08:00:00Z" ;    PAIR ;    DUP 18 ;    SWAP ;    EXEC ;    EMPTY_MAP (pair address nat) (pair bool nat nat (option nat)) ;    DUP 7 ;    DUP 13 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 7 ;    DUP 12 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 5 ;    DUP 15 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 7 ;    DUP 18 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 7 ;    DUP 14 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 7 ;    DUP 19 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 3 ;    DUP 10 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 4 ;    DUP 11 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DIG 6 ;    DUP 15 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 7 ;    DUP 16 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    PUSH timestamp "2022-07-15T08:00:00Z" ;    PAIR ;    DUP 18 ;    SWAP ;    EXEC ;    EMPTY_MAP (pair address nat) (pair bool nat nat (option nat)) ;    DUP 7 ;    DIG 12 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 7 ;    DIG 11 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DIG 5 ;    DIG 11 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 6 ;    DIG 13 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 6 ;    DIG 10 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DUP 6 ;    DIG 12 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DIG 3 ;    DIG 7 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DIG 3 ;    DIG 6 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DIG 3 ;    DIG 5 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    DIG 3 ;    DIG 4 ;    SWAP ;    SOME ;    SWAP ;    UPDATE ;    PUSH timestamp "2022-07-22T08:00:00Z" ;    PAIR ;    DIG 3 ;    SWAP ;    EXEC ;    NIL operation ;    SWAP ;    CONS ;    SWAP ;    CONS ;    SWAP ;    CONS } }
*)
