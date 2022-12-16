(* Module de la passe de gestion des identifiants *)
(* doit être conforme à l'interface Passe *)
open Tds
open Exceptions
open Ast

type t1 = Ast.AstSyntax.programme
type t2 = Ast.AstTds.programme

(* analyse_tds_expression : tds -> AstSyntax.expression -> AstTds.expression *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre e : l'expression à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'expression
en une expression de type AstTds.expression *)
(* Erreur si mauvaise utilisation des identifiants *)
let rec analyse_tds_expression tds e =
      match e with
        |AstSyntax.Null ->
            AstTds.Null
        |AstSyntax.New t ->
            AstSyntax.New t
        |AstSyntax.Affectable a ->
            let na = analyser_tds_affectable a in
                AstTds.Affectable na
        |AstSyntax.Adresse str ->
            match chercherGlobalement str with
                |None ->
                    raise IdentifiantNonDeclare str
                |Some t ->
                    begin
                        match t with
                            |InfoVar info ->
                                AstTds.Adresse info
                            |_ ->
                                raise MauvaiseUtilisationIdentifiant str
                    end
            end
        |AstSyntax.Booleen b ->
            (* Transformation de l'AstSyntaxe.Booleen en AstTds.Booleen directement car non
               géré par la tds *)
            AstTds.Booleen b
        |AstSyntax.Entier i ->
            (* Transformation de l'AstSyntaxe.Entier en AstTds.Entier directement car non
               géré par la tds *)
            AstTds.Entier i
        |AstSyntax.Unaire (u, e1) ->
            (* Transformation de l'expression liée à l'opération unaire pour obtenir une
               nouvelle expression de type AstTds.expression *)
            let ne = analyse_tds_expression tds e1 in
                (* Renvoie un AstTds.Unaire contenant l'operateur unaire et la nouvelle expression *)
                AstTds.Unaire (u, ne)
        |AstSyntax.Binaire (b, e1, e2) ->
            (* Transformation de la première expression de l'opération binaire pour obtenir une
               nouvelle expression de type AstTds.expression *)
            let ne1 = analyse_tds_expression tds e1 in
            (* Transformation de la seconde expression de l'opération binaire pour obtenir une
               nouvelle expression de type AstTds.expression *)
            let ne2 = analyse_tds_expression tds e2 in
                (* Renvoie un AstTds.Binaire contenant l'opératueur binaire et les deux nouvelles expressions *)
                AstTds.Binaire (b, ne1, ne2)
        |AstSyntax.AppelFonction (s, el) ->
            begin
                match chercherGlobalement tds s with
                    (* L'identifiant associé à la fonction n'a pas été trouvé dans la tds, elle n'a donc
                       pas été déclaré on renvoie une erreur avec l'identifiant de la fonction *)
                    |None ->
                        raise (IdentifiantNonDeclare s)
                    (* La fonction a été retrouvé dans la tds *)
                    |Some info_ast ->
                        (match (info_ast_to_info info_ast) with
                            (* Vérification que l'info associée coresspond bel et bien à une InfoFun *)
                            |InfoFun (_,_,_) -> 
                                (* Renvoie un AstTds.AppelFonction avec l'info et la liste des expression après
                                   analyse *)
                                AstTds.AppelFonction (info_ast, (List.map (analyse_tds_expression tds) el))
                            (* Renvoie une erreur si call utilisé sur autre chose qu'une fonction indiquant
                               une mauvaise utilisation d'identifiant *)
                            |_ -> 
                                raise (MauvaiseUtilisationIdentifiant s))
            end

let analyser_tds_affectable tds m a =
    match a with
        |AstSyntax.Ident n ->
            begin
                match chercherGlobalement n with
                    |None -> 
                        raise IdentifiantNonDeclare n
                    |Some i ->
                        begin 
                            match i with
                                |InfoFun (n, _, _) -> 
                                    raise MauvaiseUtilisationIdentifiant n
                                |InfoConst (_, v) ->
                                    if modif then
                                        raise ModificationNonPermise na
                                    else
                                        AstTds.Entier v
                                |InfoVar _ ->
                                    Ast.Ident i
                        end
            end
        |AstSyntax.Deref ai ->
            AstTds.Deref(analyser_tds_affectable tds ? ai)



(* analyse_tds_instruction : tds -> info_ast option -> AstSyntax.instruction -> AstTds.instruction *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre oia : None si l'instruction i est dans le bloc principal,
                   Some ia où ia est l'information associée à la fonction dans laquelle est l'instruction i sinon *)
(* Paramètre i : l'instruction à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'instruction
en une instruction de type AstTds.instruction *)
(* Erreur si mauvaise utilisation des identifiants *)
let rec analyse_tds_instruction tds oia i =
  match i with
  | AstSyntax.Declaration (t, n, e) ->
      begin
        match chercherLocalement tds n with
        | None ->
            (* L'identifiant n'est pas trouvé dans la tds locale,
            il n'a donc pas été déclaré dans le bloc courant *)
            (* Vérification de la bonne utilisation des identifiants dans l'expression *)
            (* et obtention de l'expression transformée *)
            let ne = analyse_tds_expression tds e in
            (* Création de l'information associée à l'identfiant *)
            let info = InfoVar (n,Undefined, 0, "") in
            (* Création du pointeur sur l'information *)
            let ia = info_to_info_ast info in
            (* Ajout de l'information (pointeur) dans la tds *)
            ajouter tds n ia;
            (* Renvoie de la nouvelle déclaration où le nom a été remplacé par l'information
            et l'expression remplacée par l'expression issue de l'analyse *)
            AstTds.Declaration (t, ia, ne)
        | Some _ ->
            (* L'identifiant est trouvé dans la tds locale,
            il a donc déjà été déclaré dans le bloc courant *)
            raise (DoubleDeclaration n)
      end
  | AstSyntax.Affectation (a,e) ->
        let na = analyser_tds_affectable tds a in
        let ne = analyse_tds_expression tds e in
            AstTds.Affectation(na, ne)
  | AstSyntax.Constante (n,v) ->
      begin
        match chercherLocalement tds n with
        | None ->
          (* L'identifiant n'est pas trouvé dans la tds locale,
             il n'a donc pas été déclaré dans le bloc courant *)
          (* Ajout dans la tds de la constante *)
          ajouter tds n (info_to_info_ast (InfoConst (n,v)));
          (* Suppression du noeud de déclaration des constantes devenu inutile *)
          AstTds.Empty
        | Some _ ->
          (* L'identifiant est trouvé dans la tds locale,
          il a donc déjà été déclaré dans le bloc courant *)
          raise (DoubleDeclaration n)
      end
  | AstSyntax.Affichage e ->
      (* Vérification de la bonne utilisation des identifiants dans l'expression *)
      (* et obtention de l'expression transformée *)
      let ne = analyse_tds_expression tds e in
      (* Renvoie du nouvel affichage où l'expression remplacée par l'expression issue de l'analyse *)
      AstTds.Affichage (ne)
  | AstSyntax.Conditionnelle (c,t,e) ->
      (* Analyse de la condition *)
      let nc = analyse_tds_expression tds c in
      (* Analyse du bloc then *)
      let tast = analyse_tds_bloc tds oia t in
      (* Analyse du bloc else *)
      let east = analyse_tds_bloc tds oia e in
      (* Renvoie la nouvelle structure de la conditionnelle *)
      AstTds.Conditionnelle (nc, tast, east)
  | AstSyntax.TantQue (c,b) ->
      (* Analyse de la condition *)
      let nc = analyse_tds_expression tds c in
      (* Analyse du bloc *)
      let bast = analyse_tds_bloc tds oia b in
      (* Renvoie la nouvelle structure de la boucle *)
      AstTds.TantQue (nc, bast)
  | AstSyntax.Retour (e) ->
      begin
      (* On récupère l'information associée à la fonction à laquelle le return est associée *)
      match oia with
        (* Il n'y a pas d'information -> l'instruction est dans le bloc principal : erreur *)
      | None -> raise RetourDansMain
        (* Il y a une information -> l'instruction est dans une fonction *)
      | Some ia ->
        (* Analyse de l'expression *)
        let ne = analyse_tds_expression tds e in
        AstTds.Retour (ne,ia)
      end


(* analyse_tds_bloc : tds -> info_ast option -> AstSyntax.bloc -> AstTds.bloc *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre oia : None si le bloc li est dans le programme principal,
                   Some ia où ia est l'information associée à la fonction dans laquelle est le bloc li sinon *)
(* Paramètre li : liste d'instructions à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme le bloc en un bloc de type AstTds.bloc *)
(* Erreur si mauvaise utilisation des identifiants *)
and analyse_tds_bloc tds oia li =
  (* Entrée dans un nouveau bloc, donc création d'une nouvelle tds locale
  pointant sur la table du bloc parent *)
  let tdsbloc = creerTDSFille tds in
  (* Analyse des instructions du bloc avec la tds du nouveau bloc.
     Cette tds est modifiée par effet de bord *)
   let nli = List.map (analyse_tds_instruction tdsbloc oia) li in
   (* afficher_locale tdsbloc ; *) (* décommenter pour afficher la table locale *)
   nli


(* analyse_tds_fonction : tds -> AstSyntax.fonction -> AstTds.fonction *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre : la fonction à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme la fonction
en une fonction de type AstTds.fonction *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyse_tds_fonction maintds (AstSyntax.Fonction(t,n,lp,li))  =
    match (chercherLocalement maintds n) with
        (* La fonction n'a pas été trouvé dans la tds locale, on peut donc effectuer
           sa déclaration *)
        | None -> 
            (* Création de l'info associée à la fonction à partir de son identifiant
               uniquement pour l'instant *)
            let info = InfoFun(n,Undefined,[]) in
            (* Création de l'info ast associé à l'info *)
            let info_fun = (info_to_info_ast info) in
                (* Ajout de l'info ast dans la tds principale *)
                ajouter maintds n info_fun;
            (* Création d'une tds fille à partir de la tds principale *)
            let tdsfille = creerTDSFille maintds in
            (* Création de la nouvelle liste de paramètres contenant l'info associée à chaque
               paramètre *)
            let nlp = List.map (fun (x,y) -> 
                      (* Création d'une InfoVar pour chaque paramètre avec uniquement son identifiant
                         pour l'instant *)
                      let infovar = InfoVar(y,Undefined,0,"") in 
                      begin
                          (* Vérification que l'info n'existe pas déjà dans la tds locale *)
                          match chercherLocalement tdsfille y with
                            (* L'info n'a pas été trouvé dans la tds locale, on peut donc l'ajouter *)
                            | None -> 
                                (* Transformation de l'info en info ast *)
                                let info = info_to_info_ast infovar in
                                    (* Ajout de l'info associée au paramètre dans la tds locale *)
                                    ajouter tdsfille y info;
                                    (* Renvoie l'identifiant du paramètre et son info *)
                                    (x,info)
                            (* L'info existe déjà dans la tds locale il y a donc double déclaration, on renvoie
                               une erreur avec l'identifiant du paramètre concerné *)
                            |Some _ -> 
                                raise (DoubleDeclaration y)
                      end
                    ) lp in
              (* Accès à l'info de la fonction contenue dans la tds principale à partir de son identifiant *)
              let info_func = (chercherLocalement maintds n) in
                (* Renvoie un AstTds.Fonction contenant son info, la liste des paramètres contenant les infos et leurs
                   identifiants et le nouveau bloc après analyse *)
                 AstTds.Fonction (t,info_fun,nlp,(analyse_tds_bloc tdsfille info_func li))
        (* L'info de la fonction a été trouvé dans la tds principale indiquant qu'il y'a doule déclaration, on renvoie
           une erreur avec l'identifiant concerné *)
        | Some _-> 
              raise (DoubleDeclaration n)


(* analyser : AstSyntax.programme -> AstTds.programme *)
(* Paramètre : le programme à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme le programme
en un programme de type AstTds.programme *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyser (AstSyntax.Programme (fonctions,prog)) =
    (* Création de la tds principale *)
    let tds = creerTDSMere () in
    (* Transformation de la liste de fonctions en AstTds.fonction list en appliquant
       analyse_tds_fonction à chaque fonction de la liste *)
    let nf = List.map (analyse_tds_fonction tds) fonctions in
    (* Transformation du bloc principal en AstTds.bloc *)
    let nb = analyse_tds_bloc tds None prog in
        (* Renvoie un AstTds.programme contenant la nouvelle liste de fonctions
           et le nouveau bloc principal *)
        AstTds.Programme (nf,nb)
