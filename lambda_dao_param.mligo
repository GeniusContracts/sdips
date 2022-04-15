

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

  [set_params_dao]
end

let get_lambda : raw_lambda = run_lambda

(* 

ligo compile expression cameligo run_lambda --init-file 'lambda_dao_param.mligo'

{ DROP ;  PUSH address "KT1JAPZhM6auQZLbv7dyAC2gVyVeJCu63kcw" ;  CONTRACT %setParameters    (pair (nat %escrowAmount)          (pair (nat %voteDelayBlocks)                (pair (nat %voteLengthBlocks)                      (pair (nat %minYayVotesPercentForEscrowReturn)                            (pair (nat %blocksInTimelockForExecution)                                  (pair (nat %blocksInTimelockForCancellation)                                        (pair (nat %percentageForSuperMajority) (pair %quorumCap (nat %lower) (nat %upper))))))))) ;  IF_NONE { PUSH string "FATAL1" ; FAILWITH } {} ;  PUSH mutez 0 ;  PUSH nat 300000 ;  PUSH nat 4320 ;  PUSH nat 5760 ;  PUSH nat 20 ;  PUSH nat 2880 ;  PUSH nat 5760 ;  PUSH nat 67 ;  PUSH nat 5750000 ;  PUSH nat 51750000 ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  SWAP ;  PAIR ;  TRANSFER_TOKENS ;  NIL operation ;  SWAP ;  CONS }

*)