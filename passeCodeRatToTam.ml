(* Module de la passe de génération de code Tam *)
(* Doit être conforme à l'interface passe *)
open Tds
open Type
open Tam 
open Code
open Ast
open AstPlacement


type t1 = Ast.AstPlacement.programme
type t2 = string

(* analyser_code_affectable : bool -> AstTds.affectable -> string * typ *)
(* Paramètre action : un booléen indiquant si la fonction est appelée depuis une affectation ou non *)
(* Paramètre a : l'affectable à analyser *)
(* Gère la génération de code pour les affectables *)
let rec analyser_code_affectable action a =
    match a with
        |AstTds.Ident iast ->
            begin
                match (info_ast_to_info iast) with
                    |InfoConst (_,i) ->
                        (* Chargement de la constante *)
                        loadl_int i, Int
                    |InfoVar (_,t,d,r) ->
                        if action then
                            (* Dans le cas où on réalise une affectation sur une variable 
                               on enregistre la valeur dans la variable *)
                            store (getTaille t) d r, t
                        else
                            (* Dans le cas où on se situe du côté droit de l'affectation ou si on
                               rencontre une variable dans un contexte autre que l'affectation, on charge
                               la valeur de la variable *)
                            load (getTaille t) d r, t
                    |_ -> 
                        (* Cas impossible  sauf erreur interne *)
                        failwith "erreur interne"
            end
        |AstTds.Deref a1 ->
            (* Analyse de l'affectable faisant l'objet du déréférencement et obtention de son type *)
            let na, ta = analyser_code_affectable false a1 in 
                begin
                    match ta with
                    | Pointeur t -> 
                        if action then
                            (* Dans le cas où on cherche à affecter une nouvelle valeur au pointeur on
                            génète le code menant à l'enregistrement de la valeur souhaitée *)
                            na
                            ^ storei (getTaille t), ta
                        else
                            (* Dans le cas où on cherche à affecter la valeur du pointeur on génère
                            le code menant au chargement de la valeur du pointeur *)
                            na
                            ^ loadi (getTaille t), ta
                    | _ -> 
                        (* Cas impossible sauf erreur interne *)
                        failwith "erreur interne"
                end


(* analyser_code_expression : expression -> string *)
(* Paramètre e : l'expression à analyser *)
(* Gère la génération de code d'une expression *)
let rec analyser_code_expression e = 
      begin
        match e with
            |AstType.Ternaire (e1,e2,e3) ->
                (* Génération de l'étiquette de fin de l'opération *)
                let ef = getEtiquette() in 
                (* Génération de l'étiquette de du else de l'opération *)
                let ee = getEtiquette() in 
                    (* Génération du code de l'expression 1 (la condition) *)
                    analyser_code_expression e1
                    (* Evaluation de la condition envoie dans le else si elle n'est pas respectée *)
                    ^ (jumpif 0 ee)
                    (* Génération du code de l'expression 2 si la condition est respectée *)
                    ^ (analyser_code_expression e2)
                    (* Sortie de l'opérateur *)
                    ^ (jump ef)
                    ^ ee ^ "\n" 
                    (* Génération du code de l'expression 3 si la condition n'a pas été respectée *)
                    ^ (analyser_code_expression e3)
                    ^ ef ^ "\n" 
            |AstType.AppelFonction (iast, e) ->
                begin
                    match (info_ast_to_info iast) with
                        (* Accès à l'info de la fonction pour obtenir son identifiant *)
                        |InfoFun (n,_,_) -> 
                            (* Analyse de chaque expression associée à chaque paramètre
                               pour générer le code tam associé *)
                            String.concat "" (List.map analyser_code_expression e)
                            (* Appel de la fonction concernée dans le registre SB *)
                            ^ (call "SB" n)
                        (* Erreur si on fait un appel sur autre chose qu'une fonction
                           cas impossible sauf erreur interne *)
                        |_ -> failwith "erreur interne"
                end
            |AstType.Affectable a -> 
                (* Génération du code de l'affectable *)
                let na, _ = analyser_code_affectable false a in
                    na
            |AstType.Null ->
                loadl_int (-1)
            |AstType.New t ->
                (* Dans le cas où on instancie un pointeur on charge la taille du type du pointeur
                   puis on alloue la mémoire nécessaire grâce à la fonction malloc de tam *)
                loadl_int (getTaille t)
                ^ (subr "MAlloc")
            |AstType.Adresse iast ->
                begin
                    match (info_ast_to_info iast) with
                        |InfoVar(_,_,d,r) ->
                            (* Chargement de l'adresse de la variable suivant le token @ *)
                            loada d r
                        |_ -> 
                            (* Cas impossible sauf erreur interne *)
                            "erreur interne"
                end
            |AstType.Booleen b -> 
                (* Chargement de la valeur du booléen selon l'association true -> 1 ; false -> 0 *)
                if b then 
                    (loadl_int 1) 
                else 
                    (loadl_int 0)
            |AstType.Entier i -> 
                (* Chargement de l'entier i *)
                loadl_int i
            |AstType.Unaire (u, e) -> 
                (* Génération du code de l'expression lié à l'opération unaire *)
                let ne = analyser_code_expression e in
                begin
                    match u with
                        |AstType.Numerateur -> 
                            ne ^ (pop 0 1)
                        |AstType.Denominateur -> 
                            ne ^ (pop 1 1)
                end
            |AstType.Binaire (b, e1, e2) -> 
                (* Génération du code de la première expression de l'opération
                   binaire *)
                let ne1 = analyser_code_expression e1 in
                (* Génération du code de la seconde expression de l'opération
                   binaire *)
                let ne2 = analyser_code_expression e2 in 
                    begin
                        match b with
                            |AstType.Fraction -> 
                                (* Génération du code associé à
                                 l'opérateur norm dans le registre SB *)
                                ne1 ^ ne2 ^ (call "SB" "norm")
                            |AstType.PlusInt ->
                                (* Génération du code associé
                                   à l'opérateur IAdd *)
                                ne1 ^ ne2 ^ (subr "IAdd")
                            |AstType.PlusRat ->
                                (* Génération du code associé à
                                   l'opérateur RAdd dans le registre SB *)
                                ne1 ^ ne2 ^ (call "SB" "RAdd")
                            |AstType.MultInt ->
                                (* Génération du code associé à
                                   l'opération IMul *)
                                ne1 ^ ne2 ^ (subr "IMul")
                            |AstType.MultRat ->
                                (* Génération du code associé à
                                   l'opération RMul dans le registre SB *)
                                ne1 ^ ne2 ^ (call "SB" "RMul")
                            |AstType.EquInt ->
                                (* Génération du code associé à
                                   l'opération IEq *)
                                ne1 ^ ne2 ^ (subr "IEq")
                            |AstType.EquBool ->
                                (* Génération du code associé à
                                   l'opération IEq *)
                                ne1 ^ ne2 ^ (subr "IEq")
                            |AstType.Inf ->
                                (* Génération du code associé à
                                   l'opération ILss *)
                                ne1 ^ ne2 ^ (subr "ILss")
                    end
      end

(* analyser_code_bloc : bloc -> string *)
(* Paramètre li : la liste des instruction à analyser *)
(* Paramètre tailleb : la taille du bloc à analyser *)
(* Gère la génération de code d'un bloc *)
let rec analyser_code_bloc (li, tailleb) =
    (* Concaténation du code associé à chaque instruction après analyse *)
    String.concat "" (List.map analyser_code_instruction li)
    (* Déplacement de la position tailleb fois dans le registre *)
    ^ (pop 0 tailleb)
and analyser_code_instruction i =
    begin
        match i with
            
            |AstPlacement.Declaration (iast, e) -> 
                begin
                    match (info_ast_to_info iast) with
                        (* Accès à la taille, la valeur et le registre de la variable
                           grâce à son InfoVar *)
                        |InfoVar (_, t, d, r) ->
                            (* Génération du code de déplacement 
                               de la position dans le registre r *)
                            (push (getTaille t)) 
                            (* Génération du code lié à la déclaration *)
                            ^ (analyser_code_expression e) 
                            (* Code du stockage de la variable et de ses informations *)
                            ^ (store (getTaille t) d r)
                        (* Autre type d'info impossible sauf erreur interne *)
                        |_ -> failwith "erreur"
                end
            |AstPlacement.Affectation (a,e) ->
                (* Génération du code de l'affectable (on précise que l'affectable fait l'objet de l'affectation
                   paramètre true de la fonction analyser_code_affectable) *)
                let na, _ = analyser_code_affectable true a in 
                (* Génération du code de l'expression affectée *)
                let ne = analyser_code_expression e in 
                ne
                ^ "\n" 
                ^ na
            |AstPlacement.AffichageInt e ->
                (* Génération du code lié à l'affichage d'un entier *)
                (analyser_code_expression e )
                ^ (subr "IOut")
            |AstPlacement.AffichageBool e -> 
                (* Génération du code lié à l'affichage d'un booléen *)
                (analyser_code_expression e)
                ^ (subr "BOut")
            |AstPlacement.AffichageRat e -> 
                (* Génération du code lié à l'affichage d'un Rat, appel
                   de l'opération Rout depuis le registre SB car
                   opération sur les Rats non natives *)
                (analyser_code_expression e)
                ^ (call "SB" "ROut")
            |AstPlacement.Conditionnelle (e, bt, be) -> 
                begin
                        (* Dissociation des cas où on a un bloc else et le cas où on en a pas be = [] *)
                        match be with
                            |[],0 -> 
                                    (* Un bloc if unique *)
                                    (* Génération de l'étiquette de fin *)
                                    let ef = (getEtiquette()) in 
                                    (*Génération du code de la condition *)
                                    analyser_code_expression e
                                    (* Si la condition n'est pas respectée saut à l'etiquette de fin *)
                                    ^ (jumpif 0 ef)
                                    (* Génération du code du bloc dans lequel on passe si la condition est respectée *)
                                    ^ (analyser_code_bloc bt)
                                    ^ ef
                                    ^ "\n"
                                    
                                |_,_ ->
                                    (* Etiquette du else *)
                                    let ee = (getEtiquette ()) in
                                    (* Etiquette de fin *)
                                    let ef = (getEtiquette ()) in
                                    (* Génération du code lié à la conditionnelle *)
                                    (* Génération du code de l'expresse de la conditionnelle *)
                                    (analyser_code_expression e)
                                    (* Si condition non respectée saut à l'etiquette else *) 
                                    ^ (jumpif 0 ee)
                                    (* Génération du code du bloc true *) 
                                    ^ (analyser_code_bloc bt) 
                                    (* Saut à l'etiquette de fin pour sortir de la conditionnelle *)
                                    ^ (jump ef) 
                                    (* Etiquette du else *)
                                    ^ ee 
                                    ^ "\n"  
                                    (* Génération du code du bloc else *)
                                    ^ (analyser_code_bloc be) 
                                    (* Etiquette de fin *)
                                    ^ ef 
                                    ^ "\n"
                                    
                end
            |AstPlacement.TantQue (e, b) -> 
                (* Etiquette de début nécessaire pour marquer un retour dans la boucle *)
                let ed = (getEtiquette ()) in
                (* Etiquette de fin pour sortir de la boucle *)
                let ef = (getEtiquette ()) in 
                    (* Etiquette de début *)
                    ed 
                    ^ "\n" 
                    (* Génération du code de l'expression associé à
                       la boucle *)
                    ^ (analyser_code_expression e) 
                    (* Saut à l'etiquette de fin si la condtion n'est plus
                       respectée *)
                    ^ (jumpif 0 ef) 
                    (* Génération du code du bloc de la boucle *)
                    ^ (analyser_code_bloc b)
                    (* Saut à l'etiquette de debut où la condition sera réévaluée pour
                       déterminer un nouveau passage dans la boucle ou non *)
                    ^ (jump ed) 
                    (* Etiquette de fin pour sortir de la boucle *)
                    ^ ef 
                    ^ "\n"
            |AstPlacement.Retour (e, tr, tp) -> 
                (* Génération du code lié au retour *)
                (* Génération du code de l'expression associé au retour *)
                (analyser_code_expression e) 
                ^ (return tr tp)
            |AstPlacement.Empty -> 
                (* Code vide pour un AstPlacement.Empty *)
                " "
            |AstPlacement.Loop (ia, b) ->
                (* Génération de l'étiquette de début de la boucle *)
                let db = (getEtiquette ()) in
                (* Génération de l'étiquette de fin de la boucle *)
                let fb = (getEtiquette ()) in
                    (* Modification de l'infoLoop pour y ajouter les étiquettes de fin et de début *)
                    ajouter_etiquette db fb ia;
                    (* Début de la boucle *)
                    db
                    ^ "\n"
                    (* Génération du code du bloc de la boucle *)
                    ^ (analyser_code_bloc b)
                    (* Saut au début de la boucle pour recommencer une itération *)
                    ^ (jump db)
                    (* Sortie de la boucle *)
                    ^ fb
                    ^ "\n"
            |AstPlacement.Break ia ->
                begin
                    match info_ast_to_info ia with
                        |InfoLoop (_,_,fb,_) ->
                            (* Récupération de l'étiquette de fin de la boucle qui fait l'objet du break et sortie
                            de cette dernière *)
                            jump fb
                        | _ ->
                            (* Cas impossible sauf erreur interne dans l'association du break *)
                            failwith "error"
                end
            |AstPlacement.Continue ia ->
                begin
                    match info_ast_to_info ia with
                        |InfoLoop (_,db,_,_) ->
                            (* Récupération de l'étiquette de début de la boucle qui fait l'objet du continue et retour
                               au début de cette dernière *)
                            jump db
                        | _ ->
                            (* Cas impossible sauf erreur interne dans l'association du continue *)
                            failwith "error"
                end
    end 

  (* analyser_code_fonction : fonction -> string *)
  (* Paramètre : la fonction à analyser *)
  (* Gère la génération du code d'une fonction *)
  let analyser_code_fonction (AstPlacement.Fonction (iast, _, (li,_))) =
      match (info_ast_to_info iast) with
          (* Accès au nom de la fonction grâce à l'InfoFun *)
          |InfoFun (n,_,_) ->
              (* Génération du bloc de la fonction *)
              n 
              ^ "\n" 
              (* Concaténation du code de chaque intruction constituant
                le bloc de la fonction *)
              ^ String.concat "" (List.map analyser_code_instruction li) 
              (* Code marquant la fin de la fonction *)
              ^ halt
          (* Dans le cas d'une info autre qu'une InfoFun on a un cas impossible
          indiquant une erreur interne *)
          |_ -> 
            failwith "erreur interne"
  (* analyser : AstPlacement.programme -> string *)
  (* Paramètre : le programme à analyser *)
  (* Gère la génération du code d'un programme *)
  let analyser (Programme (fonctions, b)) =
    (* Code de l'entete du programme *)
    getEntete()
    (* Concaténation du code de chaque fonction *) 
    ^  String.concat "" (List.map analyser_code_fonction fonctions) 
    (* Marque du début du bloc principal *)
    ^ "main\n" 
    (* Génération du code du bloc principal de la fonction *)
    ^ (analyser_code_bloc b) 
    (* Fin du programme *)
    ^ halt