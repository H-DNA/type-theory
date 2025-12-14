type term =
    TmTrue of info
  | TmFalse of info
  | TmIf of info * term * term * term
  | TmZero of info
  | TmSucc of info * term
  | TmPred of info * term
  | TmIsZero of info * term

let rec isnumericval t = match t with
    TmZero(_) -> true
  | TmSucc(_, t1) -> isnumericval t1
  | _ -> false

let rec isval t = match t with
  | TmTrue(_) -> true
  | TmFalse(_) -> true
  | t when isnumericval t -> true
  | _ -> false

exception NoRuleApplies

let rec eval1 t = match t with
    TmIf(_, TmTrue(_), t2, t3) -> t2
  | TmIf(_, TmFalse(_), t2, t3) -> t3
  | TmIf(info, t1, t2, t3) -> 
    let t1' = eval1 t1 in
      TmIf(info, t1', t2, t3)
  | TmSucc(info, t1) ->
    let t1' = eval1 t1' in
      TmSucc(info, t1')
  | TmPred(_, TmZero(_)) -> TmZero(dummyinfo)
  | TmPred(_, TmSucc(_, nv1)) when isnumericval nv1 -> nv1
  | TmPred(info, t1) ->
    let t1' = eval1 t1 in
      TmPred(info, t1')
  | TmIsZero(_, TmZero(_)) -> TmTrue(dummyinfo)
  | TmIsZero(_, TmSucc(_, nv1)) when isnumericval nv1 -> TmFalse(dummyinfo)
  | TmIsZero(info, t1) ->
    let t1' = eval1 t1 in
      TmIsZero(info, t1')
  | _ -> raise NoRuleApplies
