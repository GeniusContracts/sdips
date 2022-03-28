
#include "./matter_core.mligo"

type rescue_FA2 = [@layout:comb] {
  tokenContractAddress : address;
  tokenId : nat;
  amount : nat;
  destination : address;
}

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

type farm_params = [@layout:comb] {
  claimable: bool;
  fee: nat; (* 18 decimal places!! *)
  reward_per_sec: nat; (* 12 decimal places!! *)
  total_out: nat option;
}

type fa2_currency = [@layout:comb] {
  fa2_address : address;
  token_id : token_id;
}

type matter_config = [@layout:comb] {
  active_time: timestamp; (* 4 decimal places!! *)
  farm_configs: (fa2_currency, farm_params) map;
  allow_list_id: nat option;


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
    percentageForSuperMajority = 67;
    quorumCap = {
      lower = 5750000;
      upper = 51750000;
    };
  } in

  let set_params_dao_contract : setParameters contract = 
  match (Tezos.get_entrypoint_opt "%setParameters" dao : setParameters contract option) with
      None -> (failwith "FATAL" : setParameters contract)
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
      None -> (failwith "FATAL" : unit contract)
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
  let mttr_pct_17 = (mttr_target_sec *   170_000n) / 1_000_000 in
  
(*                
                                       1_000_000     1_000_000
                                       1.000_000     1.000_000
                                       
                                       0.100_000   / 1.000_000    *)
  let mttr_pct_10 = (mttr_target_sec *   100_000n) / 1_000_000 in

      (*                
                                       1_000_000     1_000_000
                                       1.000_000     1.000_000
                                       
                                       0.050_000   / 1.000_000    *)
  let mttr_pct_5 =  (mttr_target_sec *    50_000n) / 1_000_000 in

  let pct_5_fee =         50000000000000000n in

  let pct_0_point_5_fee =  5000000000000000n in

  (* 5 of these *)
  let pct_17_total : farm_params = {
    claimable = true;
    fee = pct_5_fee;
    reward_per_sec = mttr_pct_17;
    total_out =  (None : nat option);
  }; in

  (* 1 of these *)
  let pct_10_total : farm_params = {
    claimable = true;
    fee = pct_0_point_5_fee;
    reward_per_sec = mttr_pct_10;
    total_out =  (None : nat option);
  }; in

  (* 1 of these *)
  let pct_5_total : farm_params = {
    claimable = true;
    fee = pct_0_point_5_fee;
    reward_per_sec = mttr_pct_5;
    total_out =  (None : nat option);
  }; in

  (* ended farm, no rewards no fee *)
  (* keep these so ppl can unstake *)
  let pct_0_total : farm_params = {
    claimable = true;
    fee = 0n;
    reward_per_sec = 0n;
    total_out =  (None : nat option);
  }; in

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
      None -> (failwith "FATAL" : matter_config contract)
    | Some c ->  c
  in

  let change_mttr_config : operation = Tezos.transaction new_mttr_config zero_tz mttr_add_config_contract in

  set_params_dao::accept_mttr_admin::[change_mttr_config]
end

let run_lambda (_u : unit) : operation list = ([] : operation list)


let get_lambda : raw_lambda = run_lambda

(* 

ligo compile expression cameligo run_lambda --init-file 'lambda_mttr_10x.mligo'



*)