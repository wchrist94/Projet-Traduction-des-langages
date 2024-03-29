type typ = Bool | Int | Rat | Pointeur of typ |Undefined (* Ajout du type Pointeur *)

let rec string_of_type t = 
  match t with
  | Bool ->  "Bool"
  | Int  ->  "Int"
  | Rat  ->  "Rat"
  | Pointeur t -> (string_of_type t)^ " *"
  | Undefined -> "Undefined"


let rec est_compatible t1 t2 =
  match t1, t2 with
  | Bool, Bool -> true
  | Int, Int -> true
  | Rat, Rat -> true
  (* Adaptation de la fonction pour traiter les pointeurs *)
  | (Pointeur tp1), (Pointeur tp2) -> est_compatible tp1 tp2
  | Undefined, Undefined -> true
  | _ -> false 

let%test _ = est_compatible Bool Bool
let%test _ = est_compatible Int Int
let%test _ = est_compatible Rat Rat
let%test _ = not (est_compatible Int Bool)
let%test _ = not (est_compatible Bool Int)
let%test _ = not (est_compatible Int Rat)
let%test _ = not (est_compatible Rat Int)
let%test _ = not (est_compatible Bool Rat)
let%test _ = not (est_compatible Rat Bool)
let%test _ = not (est_compatible Undefined Int)
let%test _ = not (est_compatible Int Undefined)
let%test _ = not (est_compatible Rat Undefined)
let%test _ = not (est_compatible Bool Undefined)
let%test _ = not (est_compatible Undefined Int)
let%test _ = not (est_compatible Undefined Rat)
let%test _ = not (est_compatible Undefined Bool)

let est_compatible_list lt1 lt2 =
  try
    List.for_all2 est_compatible lt1 lt2
  with Invalid_argument _ -> false

let%test _ = est_compatible_list [] []
let%test _ = est_compatible_list [Int ; Rat] [Int ; Rat]
let%test _ = est_compatible_list [Bool ; Rat ; Bool] [Bool ; Rat ; Bool]
let%test _ = not (est_compatible_list [Int] [Int ; Rat])
let%test _ = not (est_compatible_list [Int] [Rat ; Int])
let%test _ = not (est_compatible_list [Int ; Rat] [Rat ; Int])
let%test _ = not (est_compatible_list [Bool ; Rat ; Bool] [Bool ; Rat ; Bool ; Int])

let getTaille t =
  match t with
  | Int -> 1
  | Bool -> 1
  | Rat -> 2
  | Pointeur _ -> 1
  | Undefined -> 0
  
let%test _ = getTaille Int = 1
let%test _ = getTaille Bool = 1
let%test _ = getTaille Rat = 2
(* Adaptation *)
let%test _ = getTaille Undefined = 0
let%test _ = getTaille (Pointeur (Pointeur Int)) = 1

let detection_non_Pointeur t =
  if (est_compatible t Int || est_compatible t Rat || est_compatible t Bool) then
      true
  else
    false

let%test _ = detection_non_Pointeur Int = true
let%test _ = detection_non_Pointeur Rat = true
let%test _ = detection_non_Pointeur Bool = true
let%test _ = detection_non_Pointeur (Pointeur (Pointeur Int)) = false
let%test _ = detection_non_Pointeur (Pointeur Rat) = false

