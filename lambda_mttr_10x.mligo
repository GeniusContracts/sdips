
#include "./matter_core.mligo"

type quorumCap = [@layout:comb] {
  lower: nat;
  upper: nat;
}

type setParameters = [@layout:comb] {
  escrowAmount : nat;
  voteDelayBlocks : nat;
  voteLengthBlocks : nat;
  minYayVotesPercentForEscrowReturn : nat;
  blocksInTimelockForExecution : nat;
  blocksInTimelockForCancellation : nat;
  percentageForSuperMajority : nat;
  quorumCap : quorumCap;
}

type raw_lambda = (unit) -> (operation list)

let run_lambda (_u : unit) : operation list = begin

  let zero_tz : tez = 0mutez in

  (* SET DAO PARAMS *)
  let dao : address = ("KT1JAPZhM6auQZLbv7dyAC2gVyVeJCu63kcw" : address) in
  
  let new_dao_params : setParameters = {
    escrowAmount = 300000n;
    voteDelayBlocks = 4320n; (* change to 1.5day *)
    voteLengthBlocks = 5760n; (* change to 2day *)
    minYayVotesPercentForEscrowReturn = 20n;
    blocksInTimelockForExecution = 2880n; (* change to 1day *)
    blocksInTimelockForCancellation = 5760n; (* change to 2day *)
    percentageForSuperMajority = 67n;
    quorumCap = {
      lower = 5750000n;
      upper = 51750000n;
    };
  } in

  let set_params_dao_contract : setParameters contract = 
  match (Tezos.get_entrypoint_opt "%setParameters" dao : setParameters contract option) with
      None -> (failwith "FATAL1" : setParameters contract)
    | Some c ->  c
  in

  let set_params_dao : operation = Tezos.transaction new_dao_params zero_tz set_params_dao_contract in
  


  (* MATTER *)
  (* MATTER *)
  (* MATTER *)
  (* MATTER *)
  (* MATTER *)
  (* MATTER *)
  


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

  (* raw # with decimals *)
  let mttr_target_1yr = 2_000_000n * mttr_decimals in

  (* raw # with decimals *)
  (* .063419583967 *)
  let mttr_target_sec = mttr_target_1yr / 365n / 24n / 60n / 60n in


(*                
                                       1_000_000     1_000_000
                                       1.000_000     1.000_000

                                       0.170_000   / 1.000_000    *)
  let mttr_pct_17 = (mttr_target_sec *   170_000n) / 1_000_000n in
  
(*                
                                       1_000_000     1_000_000
                                       1.000_000     1.000_000
                                       
                                       0.100_000   / 1.000_000    *)
  let mttr_pct_10 = (mttr_target_sec *   100_000n) / 1_000_000n in

      (*                
                                       1_000_000     1_000_000
                                       1.000_000     1.000_000
                                       
                                       0.050_000   / 1.000_000    *)
  let mttr_pct_5 =  (mttr_target_sec *    50_000n) / 1_000_000n in

  let pct_5_fee =         50000000000000000n in

  let pct_0_point_5_fee =  5000000000000000n in

  (* 5 of these *)
  let pct_17_total : farm_params = {
    claimable = true;
    fee = pct_5_fee;
    reward_per_sec = mttr_pct_17;
    total_out =  (None : nat option);
  } in

  (* 1 of these *)
  let pct_10_total : farm_params = {
    claimable = true;
    fee = pct_0_point_5_fee;
    reward_per_sec = mttr_pct_10;
    total_out =  (None : nat option);
  } in

  (* 1 of these *)
  let pct_5_total : farm_params = {
    claimable = true;
    fee = pct_0_point_5_fee;
    reward_per_sec = mttr_pct_5;
    total_out =  (None : nat option);
  } in

  (* ended farm, no rewards no fee *)
  (* keep these so ppl can unstake *)
  let pct_0_total : farm_params = {
    claimable = true;
    fee = 0n;
    reward_per_sec = 0n;
    total_out =  (None : nat option);
  } in

  (* (17 * 5) + 10 + 5 = 100 *)
  (* targeted emissions: 2_000_000 * 1_000_000_000_000*)

  let new_farm_config : (fa2_currency, farm_params) map = Map.literal [
    tzbtc_lp_token, pct_17_total;
    usdtz_lp_token, pct_17_total;
    btctz_lp_token, pct_17_total;
    kusd_lp_token, pct_17_total;
    uusd_lp_token, pct_17_total;
    
    mttr_lp_token, pct_10_total;
    mttr_token, pct_5_total;

    mtria_lp_token, pct_0_total;
    wtz_token, pct_0_total;
  ] in

  let new_mttr_config : matter_config = {
    active_time = ("2022-04-12T00:00:00Z" : timestamp);
    allow_list_id = (None : nat option);
    farm_configs =  new_farm_config;
  } in

  let mttr_add_config_contract : matter_config contract = 
  match (Tezos.get_entrypoint_opt "%addConfig" mttr_core : matter_config contract option) with
      None -> (failwith "FATAL3" : matter_config contract)
    | Some c ->  c
  in

  let change_mttr_config : operation = Tezos.transaction new_mttr_config zero_tz mttr_add_config_contract in

  set_params_dao::accept_mttr_admin::[change_mttr_config]
end

let get_lambda : raw_lambda = run_lambda

(* 

ligo compile expression cameligo run_lambda --init-file 'lambda_mttr_10x.mligo'

{ DROP ;  PUSH mutez 0 ;  PUSH address "KT1JAPZhM6auQZLbv7dyAC2gVyVeJCu63kcw" ;  CONTRACT %setParameters    (pair (nat %escrowAmount)          (pair (nat %voteDelayBlocks)                (pair (nat %voteLengthBlocks)                      (pair (nat %minYayVotesPercentForEscrowReturn)                            (pair (nat %blocksInTimelockForExecution)                                  (pair (nat %blocksInTimelockForCancellation)                                        (pair (nat %percentageForSuperMajority) (pair %quorumCap (nat %lower) (nat %upper))))))))) ;  IF_NONE { PUSH string "FATAL1" ; FAILWITH } {} ;  SWAP ;  DUP ;  DUG 2 ;  PUSH nat 300000 ;  PUSH nat 4320 ;  PUSH nat 5760 ;  PUSH nat 20 ;  PUSH nat 2880 ;  PUSH nat 5760 ;  PUSH nat 67 ;  PUSH nat 5750000 ;  PUSH nat 51750000 ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  TRANSFER_TOKENS ;  PUSH address "KT1K4jn23GonEmZot3pMGth7unnzZ6EaMVjY" ;  DUP ;  CONTRACT %confirm_admin unit ;  IF_NONE { PUSH string "FATAL2" ; FAILWITH } {} ;  DUP 4 ;  UNIT ;  TRANSFER_TOKENS ;  PUSH nat 1000000000000 ;  PUSH nat 2000000 ;  MUL ;  PUSH nat 60 ;  PUSH nat 60 ;  PUSH nat 24 ;  PUSH nat 365 ;  DIG 4 ;  EDIV ;  IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;  CAR ;  EDIV ;  IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;  CAR ;  EDIV ;  IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;  CAR ;  EDIV ;  IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;  CAR ;  PUSH nat 1000000 ;  PUSH nat 170000 ;  DUP 3 ;  MUL ;  EDIV ;  IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;  CAR ;  PUSH nat 1000000 ;  PUSH nat 100000 ;  DUP 4 ;  MUL ;  EDIV ;  IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;  CAR ;  PUSH nat 1000000 ;  PUSH nat 50000 ;  DIG 4 ;  MUL ;  EDIV ;  IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ;  CAR ;  PUSH nat 5000000000000000 ;  PUSH bool True ;  PUSH nat 50000000000000000 ;  DIG 5 ;  NONE nat ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  PUSH bool True ;  PUSH nat 0 ;  PUSH nat 0 ;  NONE nat ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  DIG 6 ;  CONTRACT %addConfig    (pair (timestamp %active_time)          (pair (map %farm_configs                   (pair (address %fa2_address) (nat %token_id))                   (pair (bool %claimable)                         (pair (nat %fee) (pair (nat %reward_per_sec) (option %total_out nat)))))                (option %allow_list_id nat))) ;  IF_NONE { PUSH string "FATAL3" ; FAILWITH } {} ;  DIG 8 ;  PUSH timestamp "2022-04-12T00:00:00Z" ;  EMPTY_MAP (pair address nat) (pair bool (pair nat (pair nat (option nat)))) ;  DUP 5 ;  PUSH address "KT1PnUZCp3u2KzWr93pn4DD7HAJnm3rWVrgn" ;  PUSH nat 0 ;  SWAP ;  PAIR ;  SWAP ;  SOME ;  SWAP ;  UPDATE ;  DUP 6 ;  PUSH address "KT1UefQz7nP8BuuDk5Dd5LWo22N1ZPB7JB5o" ;  PUSH nat 0 ;  SWAP ;  PAIR ;  SWAP ;  SOME ;  SWAP ;  UPDATE ;  DUP 6 ;  PUSH address "KT1KgNVokovu4dSBFZXmFXgUni5TypwMBbRS" ;  PUSH nat 0 ;  SWAP ;  PAIR ;  SWAP ;  SOME ;  SWAP ;  UPDATE ;  DUP 6 ;  PUSH address "KT1FHewqgFXCjTJbYvLMhWL335ZV1qupN1c2" ;  PUSH nat 0 ;  SWAP ;  PAIR ;  SWAP ;  SOME ;  SWAP ;  UPDATE ;  PUSH bool True ;  DUP 8 ;  DIG 9 ;  NONE nat ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  PUSH address "KT1K4jn23GonEmZot3pMGth7unnzZ6EaMVjY" ;  PUSH nat 0 ;  SWAP ;  PAIR ;  SWAP ;  SOME ;  SWAP ;  UPDATE ;  PUSH bool True ;  DIG 7 ;  DIG 8 ;  NONE nat ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  PUSH address "KT1QQvdg7TGZAH85HtgNvQuoekNRegvQPk8R" ;  PUSH nat 0 ;  SWAP ;  PAIR ;  SWAP ;  SOME ;  SWAP ;  UPDATE ;  DIG 4 ;  PUSH address "KT1RBLbqbdej7xy1bbqb4pG7YQJxFxQhc42Z" ;  PUSH nat 0 ;  SWAP ;  PAIR ;  SWAP ;  SOME ;  SWAP ;  UPDATE ;  DUP 5 ;  PUSH address "KT1NN1NgmKFTW5FUWiyxVjUt3kH9bCiqgxLW" ;  PUSH nat 0 ;  SWAP ;  PAIR ;  SWAP ;  SOME ;  SWAP ;  UPDATE ;  DIG 4 ;  PUSH address "KT1M234AC3kz9uQ9vse8caidhKUMrZ3S2YjN" ;  PUSH nat 0 ;  SWAP ;  PAIR ;  SWAP ;  SOME ;  SWAP ;  UPDATE ;  NONE nat ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  TRANSFER_TOKENS ;  NIL operation ;  SWAP ;  CONS ;  SWAP ;  CONS ;  SWAP ;  CONS }

*)
