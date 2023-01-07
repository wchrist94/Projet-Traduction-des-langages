(* Module de la passe de gestion du placement en mémoire *)
(* Doit être conforme à l'interface passe *)
open Type
open Tds
open Exceptions
open Ast

type t1 = Ast.AstType.programme
type t2 = Ast.AstPlacement.programme

(* analyser_placement_bloc : AstType.bloc -> string -> int -> AstPlacement.bloc *)
(* Paramètre li : la liste des instruction à analyser *)
(* Paramètre reg : le registre de travail *)
(* Paramètre depl :  l'indice de départ dans le registre *)
(* Gère le placement en mémoire du bloc et transforme le bloc en un bloc de type AstPlacement.bloc *)
  let rec analyser_placement_bloc li reg depl =
      match li with
          |[] -> ([], 0)
          |i::q ->                
                (* Analyse de l'instruction en tête *)
                let (ni, taille) = analyser_placement_instruction i reg depl in
                (* Analyse des autres instructions de la liste *)
                let (nq, taille_q) = analyser_placement_bloc q reg (depl + taille) in
                (* Renvoie le nouveau bloc ainsi que sa taille dans le registre *)
                (ni::nq), taille + taille_q
  
  (* analyser_placement_instruction : AstType.instruction -> string -> int -> AstPlacement.instruction * int *)
  (* Paramètre i : l'instruction à analyser *)
  (* Paramètre reg : le registre de travail *)
  (* Paramètre depl : l'indice de départ dans le registre *)
  (* Gère le placement en mémoire d'une instruction, la transforme en AstPlacement.instruction et donne sa taille en mémoire *)
  (* Erreur si Retour utilisé dans le main *)
  and analyser_placement_instruction i reg depl =
      begin
        match i with
            
            |AstType.Declaration(iast, exp) ->
                (* Placement en mémoire de la déclaration dans le registre reg *)
                modifier_adresse_variable depl reg iast;
                (* Renvoi la nouvelle déclaration avec la taille du type associé *)
                (AstPlacement.Declaration (iast, exp), getTaille (getType iast))
            |AstType.Affectation (a, exp) ->
                (* Renvoie la nouvelle affectation avec taille nulle (pas d'impact sur l'occupation du registre) *)
                (AstPlacement.Affectation (a, exp), 0)
            |AstType.AffichageInt (exp) ->
                (* Renvoie le nouvel AffichageInt avec une taille nulle *)
                (AstPlacement.AffichageInt (exp),0)
            |AstType.AffichageBool (exp) ->
                (* Renvoie le nouvel AffichageBool avec une taille nulle *)
                (AstPlacement.AffichageBool (exp),0)
            |AstType.AffichageRat (exp) ->
                (* Renvoie le nouvel AffichageRat avec une taille nulle *)
                (AstPlacement.AffichageRat (exp),0)
            |AstType.Conditionnelle (exp, bt, be) ->
                let nbt = analyser_placement_bloc bt reg depl in
                let nbe = analyser_placement_bloc be reg depl in
                    (* Renvoie la nouvelle Conditionnelle avec une taille nulle *)
                    (AstPlacement.Conditionnelle (exp, nbt, nbe), 0)
            |AstType.TantQue (exp, b) ->
                let nb = analyser_placement_bloc b reg depl in
                    (* Renvoie la nouvelle boucle avec une taille nulle *)
                    (AstPlacement.TantQue (exp, nb), 0)
            |AstType.Empty ->
                    (* Renvoie du nouveau vide *)
                    AstPlacement.Empty, 0
            |AstType.Retour (exp, iast) -> 
                begin
                    match (info_ast_to_info iast) with
                        |InfoFun (_,t,tp) -> 
                            (* Taille du type de retour de la fonction *)
                            let taille_ret = getTaille t in
                            (* Taille totale de la liste de paramètres de la fonction*)
                            let taille_param = List.fold_right (fun t acc -> acc + getTaille t) tp 0 in
                                (* Renvoie le nouveau retour avec l'expression la taille du type de retour et la taille des paramètre *)
                                (* La taille du Retour en elle même est nulle car on n'affecte pas le registre *)
                                AstPlacement.Retour (exp, taille_ret, taille_param), 0
                        (* Erreur si retour non appelé depuis une fonction *)
                        |_ -> raise RetourDansMain  
                end
            |AstType.Loop (ia, b) ->
                (* Analyse du placement du bloc de la boucle *)
                let nb = analyser_placement_bloc b reg depl in
                    (* Renvoie un AstPlacement.Loop avec le bloc analysé *)
                    AstPlacement.Loop(ia, nb), 0
            |AstType.Break ia ->
                AstPlacement.Break ia, 0
            |AstType.Continue ia ->
                AstPlacement.Continue ia, 0

      end
(* analyser_placement_fonction : AstType.fonction -> AstPlacement.fonction *)
(* Paramètre : la fonction à analyser *)
(* Gère le placement en mémoire d'une fonction et la transforme en AstPlacement.fonction *)
let analyser_placement_fonction (AstType.Fonction(n,lp,b)) =

  (* analyse_paramètre : info_ast list -> int -> unit *)
  (* Paramètre p : le paramètre à analyser *)
  (* Paramètre depl : le décalage d'indice dans le registre de travail *)
  (* Gère le placement en mémoire d'une liste de paramètre *)
  let rec analyse_parametre p depl =
    match p with
      |[] -> ()
      |t::q ->
        let ty = getType t in
          (* Modifie l'adresse du paramètre en tête dans l'info *)
          modifier_adresse_variable (depl - getTaille ty) "LB" t;
          (* Analyse du reste de la liste de paramètres *)
          analyse_parametre q (depl - getTaille ty)
  in 
      (* Placement en mémoire des paramètre de la fonction analysée *)
      analyse_parametre (List.rev lp) 0;
  (* Analyse du bloc de la fonction *)
  let nb = analyser_placement_bloc b "LB" 3 in
      AstPlacement.Fonction(n,lp,nb)

(* analyser : AstType.programme -> AstPlacement.programme *)
(* Paramètre : le programme à analyser *)
(* Gère le placement en mémoire du programme et le transforme en AstPlacement.programme *)
let analyser (AstType.Programme(fonctions, prog)) =
    (* Analyse de la liste des fonctions du programme *)
    let nlf = List.map (analyser_placement_fonction) fonctions in
    (* Analyse du bloc du programme *)
    let nb = (analyser_placement_bloc prog "SB" 0) in
        AstPlacement.Programme(nlf,nb)
  




