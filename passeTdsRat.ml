(* Module de la passe de gestion des identifiants *)
(* doit être conforme à l'interface Passe *)
open Tds
open Exceptions
open Ast

type t1 = Ast.AstSyntax.programme
type t2 = Ast.AstTds.programme

(* analyser_tds_affectable : tds -> bool -> AstSyntax.affectable -> AstTds.affectable *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre m : booléen indiquant si on souhaite ou non effectuer une modification de la tds *)
(* Paramètre a : l'affectable à anlayser *)
(* Vérifie la bonne utilisation des identifiants et des déréférencement. Transforme l'AstSyntax.affectable 
   en AstTds.affectable *)
(* Renvoie une exception de type IdentifiantNonDeclare si l'Identifiant n'a pas été déclaré au préalable *)
(* Renvoie une exception de type MauvaiseUTilisationIdentifiant si on tente d'effectuer une affectation
   sur une fonction, une constante ou une boucle *)
let rec analyser_tds_affectable tds modif a =
    match a with
        |AstSyntax.Ident n ->
            begin
                match chercherGlobalement tds n false with
                    |None -> 
                        (* L'identifiant n'a pas été retrouvé dans la tds, il n'a donc pas été déclaré on renvoie une
                        exception de type IdentifiantNonDeclare avec le nom *)
                        raise (IdentifiantNonDeclare n)
                    |Some i ->
                        begin 
                            match (info_ast_to_info i) with
                                |InfoFun (n, _, _) -> 
                                    (* Appel de fonction sans call, on lève une exception indquant une mauvaise utilisation
                                    de l'identifiant *)
                                    raise (MauvaiseUtilisationIdentifiant n)
                                |InfoConst (n, _) ->
                                    if modif then
                                        (* Dans le cas où on souhaite effectue une affecation sur une constante on lève une
                                        exception indiquant une mauvaise utilisation d'identifiant *)
                                        raise (MauvaiseUtilisationIdentifiant n)
                                    else
                                        (* Sinon on renvoie un AstTds.Ident avec son info *)
                                        AstTds.Ident i
                                |InfoVar _ ->
                                    (* Dans le cas d'une variable on renvoie simplement un AstTds.Ident avec l'info *)
                                    AstTds.Ident i
                                |InfoLoop (n,_,_, _) ->
                                    (* Identifiant d'une boucle utilisé dans un contexte autre que sa création, un break ou un
                                    continue, on lève une exception indiquant une mauvaise utilisation d'identifiant *)
                                    raise (MauvaiseUtilisationIdentifiant n)
                        end
            end
        |AstSyntax.Deref af ->
            (* Dans le cas d'un déréférencement on anlayse l'affectable faisant l'objet du déréférencement *)
            AstTds.Deref(analyser_tds_affectable tds false af)

(* analyse_tds_expression : tds -> AstSyntax.expression -> AstTds.expression *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre e : l'expression à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'expression
en une expression de type AstTds.expression *)
(* Erreur si mauvaise utilisation des identifiants *)
let rec analyse_tds_expression tds e =
      match e with
        | AstSyntax.Ternaire (cond,e1,e2) ->
            (* Transformation de l'expression formant la condition pour obtenir une nouvelle expression de type
            AstTds.expression *)
            let ncond = analyse_tds_expression tds cond in 
            (* Transformation des expression des valeurs possibles de l'opération pour obtenir des expression de type
            AstTds.expression *)
            let ne1 = analyse_tds_expression tds e1 in 
            let ne2 = analyse_tds_expression tds e2 in
                (* Renvoie un AstTds.Ternaire avec la condition et les expression analysées *)
                AstTds.Ternaire (ncond,ne1,ne2)
        |AstSyntax.Null ->
            (* Renvoie un AstTds.Null *)
            AstTds.Null
        |AstSyntax.New t ->
            (* Renvoie un AstTds.New avec le type *)
            AstTds.New t
        |AstSyntax.Affectable a ->
            (* Transformation de l'affectable en AstTds.affectable *)
            let na = analyser_tds_affectable tds false a in
                AstTds.Affectable na
        |AstSyntax.Adresse n ->
            begin
                match chercherGlobalement tds n false with
                    |None ->
                        (* Le nom de la variable dont on cherche l'adresse n'a pas été trouvé dans la tds, on lève une
                           exception indiquant que l'identifiant n'a pas été déclaré *)
                        raise (IdentifiantNonDeclare n)
                    |Some i ->
                        begin
                            match (info_ast_to_info i)  with
                                |InfoVar _ ->
                                    (* On renvoie un AstTds.Adresse avec l'info de la variable *)
                                    AstTds.Adresse i
                                |_ ->
                                    (* Dans le cas où l'info n'est pas une InfoVar, on lève une exception
                                    indiquant une mauvaise utilisation d'identifiant *)
                                    raise (MauvaiseUtilisationIdentifiant n)
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
                match chercherGlobalement tds s false with
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
        match chercherLocalement tds n false with
        | None ->
            (* L'identifiant n'est pas trouvé dans la tds locale,
            il n'a donc pas été déclaré dans le bloc courant *)
            (* Vérification de la bonne utilisation des identifiants dans l'expression *)
            (* et obtention de l'expression transformée *)
            let ne = analyse_tds_expression tds e in
            (* Création d'un InfoVar avec l'identifiant de la variable *)
            let i = InfoVar (n, Undefined, 0, "") in
            let ia = info_to_info_ast i in
            (* Ajout de l'info crée à la tds *)
            ajouter tds n ia;
            (* On renvoie un AstTds.Declaration avec le type de la variable déclarée, l'info crée, et
               l'expression analysée *)
            AstTds.Declaration (t, ia, ne)
        | Some _ ->
            (* L'identifiant est trouvé dans la tds locale,
            il a donc déjà été déclaré dans le bloc courant *)
            raise (DoubleDeclaration n)
      end
    | AstSyntax.Loop (n,li) ->
        begin
            (* Séparation des cas nommés et non nommés *)
            match n with
                (* Gestion des boucles non nommées *)
                |None ->
                    (* Initialisation d'une InfoLoop avec un identifiant "vide" *)
                    let i = InfoLoop ("","","", []) in
                    let ia = info_to_info_ast i in 
                    (* Ajout de l'InfoLoop crée à la tds et de son propre identifiant à sa liste des identifiants
                       de boucle supérieure *)
                        ajouter tds "" ia;
                        ajouterLoop [""] ia;
                    begin
                        match oia with
                        | None -> 
                            (* Déclaration de boucle depuis le main *)
                            (* Analyse du bloc de la boucle non nommée *)
                            let nli = analyse_tds_bloc tds (Some ia) li in
                            (* On renvoie un AstTds.Loop avec l'info_ast crée et le bloc analysé *)
                            AstTds.Loop (ia, nli)
                        | Some i ->
                            begin
                                match (info_ast_to_info i) with
                                |InfoLoop (_,_,_,lb) ->
                                    (* Déclaration d'une boucle depuis le bloc d'une autre boucle, on récupère la liste des identifiants
                                       des boucles supérieur à la boucle courante *)
                                    (* Ajout de la liste récupèrée à l'InfoLoop de la boucle déclarée *)
                                    ajouterLoop lb ia;
                                    (* Analyse des instructions de la boucle déclarée *)
                                    let nli = analyse_tds_bloc tds (Some ia) li in 
                                        (* On renvoie un AstTds.Loop avec l'info crée et le bloc analysé *)
                                         AstTds.Loop (ia, nli)
                                | InfoFun _ ->
                                    (* Déclaration d'une boucle depuis le bloc principal d'une fonction *)
                                    (* Analyse du bloc de la boucle déclaré et transformation en AstTds.bloc *)
                                    let nli = analyse_tds_bloc tds (Some ia) li in 
                                        (* On renvoie un AstTds.Loop avec l'info crée et le bloc analysé *)
                                         AstTds.Loop (ia, nli)
                                | _ ->
                                    (* Cas impossible sauf erreur interne *)
                                    failwith "Erreur interne : Déclaration de loop depuis une InfoVar ou une InfoConst"
                            end
                    end
                |Some str ->
                    (* Gestion des boucles nommées *)
                    (* Création d'une InfoLoop avec l'identifiant de la loop *)
                    let i = InfoLoop(str, "", "", []) in
                    let ia = info_to_info_ast i in 
                        (* Ajout de l'info crée à la tds et ajout de l'identifiant de la boucle à sa liste des identifiants
                           de boucle supérieure *)
                        ajouter tds str ia;
                        ajouterLoop [str] ia;
                        begin 
                            match oia with
                                |None ->
                                    (* Déclaration de boucle depuis le main *)
                                    (* On récupère l'info de la boucle que l'on vient de créer (nécessaire car analyse_tds_bloc
                                       demande une info_ast option en paramètre) *)
                                    let nia = chercherLocalement tds str true in
                                    (* Analyse du bloc de la boucle déclarée et transformation en AstTds.bloc *)
                                    let nli = analyse_tds_bloc tds nia li in
                                        (* On renvoie un AstTds.Loop avec l'info crée et le bloc analysé *)
                                        AstTds.Loop (ia, nli)
                                |Some i ->
                                    begin
                                        match (info_ast_to_info i) with
                                            |InfoLoop (_,_,_,lb) ->
                                                (* Déclaration d'une boucle nommée depuis le bloc d'une boucle, on récupère la liste
                                                   des identifiants des boucles supérieures de la boucle courante *)
                                                (* Ajout de la liste récupérée dans l'info de la boucle déclarée *)
                                                ajouterLoop lb ia;
                                                (* On récupère l'info de la boucle que l'on vient de créer (nécessaire car analyse_tds_bloc
                                                demande une info_ast option en paramètre) *)
                                                let nia = chercherLocalement tds str true in
                                                (* Analyse du bloc de la boucle déclarée et transformation en AstTds.bloc *)
                                                let nli = analyse_tds_bloc tds nia li in
                                                    (* On renvoie un AstTds.Loop avec l'info crée et le bloc analysé *)
                                                    AstTds.Loop (ia, nli)
                                            | _ ->
                                                (* On récupère l'info de la boucle que l'on vient de créer (nécessaire car analyse_tds_bloc
                                                demande une info_ast option en paramètre) *)
                                                let nia = chercherLocalement tds str true in
                                                (* Analyse du bloc de la boucle déclarée et transformation en AstTds.bloc *)
                                                let nli = analyse_tds_bloc tds nia li in
                                                    (* On renvoie un AstTds.Loop avec l'info crée et le bloc analysé *)
                                                    AstTds.Loop (ia, nli)
                                    end
                        end             
        end
    | AstSyntax.Break n ->
        begin
            (* Séparation des cas nommés et non nommés *)
            match n with
                |None ->
                    (* Cas non nommé *)
                    begin
                        match oia with
                            | None -> 
                                (* break appelé directement dans le main on lève une exception indicant que le break a été
                                mal placé *)
                                raise (BreakNonNommeeMalPlace)
                            | Some i ->
                                begin
                                    match (info_ast_to_info i) with
                                        |InfoLoop _->
                                            (* break appelé depuis une InfoLoop on renvoie donc un AstTds.Break avec cette InfoLoop
                                            (boucle de plus bas niveau) *)
                                            AstTds.Break i
                                        |InfoFun _ ->
                                            (* break appelé directement depuis le bloc principal d'une fonction (InfoFun) on lève 
                                            une exception indiquant que le break a été mal placé *)
                                            raise (BreakNonNommeeMalPlace)
                                        | _ ->
                                            (* Cas Impossible sauf erreur interne *)
                                            failwith "Erreur interne : Break non nommé appelé depuis une InfoVar ou une InfoConst"
                                        
                                end
                    end
                |Some str ->
                    (* Cas des break nommés *)
                    (* On récupére l'InfoLoop associé à l'identifiant de la boucle dans la tds en indiquant à la fonction
                       chercherGlobalement qu'on cherche une boucle avec le paramètre true *)
                    let iast = chercherGlobalement tds str true in 
                    begin
                        match oia with
                            |None ->
                                (* Break directement appelé depuis le main on lève une exception indiquant que le break est
                                   mal placé avec le nom du break *)
                                raise (BreakMalPlace str)
                            |Some i ->
                                begin
                                    match (info_ast_to_info i) with
                                        |InfoLoop (_,_,_, l) ->
                                            (* Le break a été appelé depuis une InfoLoop on récupère la liste des identifiants des 
                                               boucle de niveau supérieur (boucle courante comprise) *)
                                            begin
                                                match iast with
                                                    |None ->
                                                        (* Le break a été appelé pour interrompre une boucle inconnue, on lève
                                                           une exception indiquant que le nom de la boucle qu'on tente d'interrompre
                                                           est inconnu *)
                                                        raise (BoucleInconnue str)
                                                    |Some ia ->
                                                        (* Une info avec l'identifiant associé au break a été retrouvé dans la tds *)
                                                        begin
                                                            match (info_ast_to_info ia) with
                                                                |InfoLoop (str,_,_,_) ->
                                                                    (* On vérifie que le break a été appelé depuis une boucle
                                                                       qui est dans la liste des boucles au dessus de la boucle
                                                                       à partir de laquelle le break a été appelé *)
                                                                    if (List.mem str l) then
                                                                        (* La boucle à interrompre a été trouvé dans la liste, on renvoie
                                                                        donc un AstTds.Break avec l'info de la boucle à interrompre *)
                                                                        AstTds.Break ia
                                                                    else
                                                                        (* La boucle n'a pas été trouvé on lève une exception indiquant
                                                                           que le break nommé a été mal placé avec le nom de la boucle
                                                                           à interrompre *)
                                                                        raise (BreakMalPlace str)
                                                                |_ ->
                                                                    (* Cas Impossible sauf erreur interne *)
                                                                    failwith "Erreur interne : filtrage de chercherGlobalement incorrect"
                                                        end
                                            end
                                        | InfoFun _ ->
                                            (* Break nommé appelé directement depuis le bloc principal d'une fonction (InfoFun), on lève
                                               une exception indiquant que le break a été mal placé avec son identifiant *)
                                            raise (BreakMalPlace str)
                                        | _ ->
                                            (* Cas Impossible sauf erreur interne *)
                                            failwith "Erreur interne : Break nommé appelé depuis une InfoVar ou une InfoConst"                                
                                end            
                    end
        end
    | AstSyntax.Continue (n) ->
        begin
            (* Séparation des cas nommés et non nommés *)
            match n with
                |None ->
                    (* Gestion des continue non nommé *)
                    begin
                        match oia with
                        | None -> 
                            (* Un continue a été appelé directement depuis le main, on lève une exception indiquant que le
                               continue non nommé a été mal placé *)
                            raise (ContinueNonNommeMalPlace)
                        | Some i ->
                            begin
                                match (info_ast_to_info i) with
                                    |InfoLoop _->
                                        (* continue appelé depuis une boucle, on renvoie un AstTds.Continue avec l'InfoLoop
                                           d'où le continue a été appelé (boucle de plus bas niveau) *)
                                        AstTds.Continue i
                                    |InfoFun _ ->
                                        (* continue appelé directement depuis le bloc principal d'une fonction, on lève une
                                           exception en indiquant que le continue non nommé a été mal placé *)
                                        raise (ContinueNonNommeMalPlace)
                                    | _ ->
                                        (* Cas impossible sauf erreur interne *)
                                        failwith "Erreur interne : continue appelé depuis une InfoVar ou une InfoConst"
                            end
                    end
                |Some str ->
                    (* Gestion des continue nommés *)
                    (* On récupère l'InfoLoop associée à l'identifiant du continue dans la tds en indiquant qu'on recherche une
                       boucle à la fonction chercherGlobalement avec le paramètre true *)
                    let iast = chercherGlobalement tds str true in 
                    begin
                        match oia with
                            |None ->
                                (* Un continue nommé a été appelé depuis le main, on lève une exeption indiquant que le continue
                                   a été mal placé avec son identifiant *)
                                raise (ContinueMalPlace str)
                            |Some i ->
                                begin
                                    match (info_ast_to_info i) with
                                        |InfoLoop (_,_,_,l) ->
                                            (* Un continue a été appelé depuis une boucle, on récupère la liste des boucle de niveau
                                               supérieur (la boucle courante comprise) *)
                                            begin
                                                match iast with
                                                    |None ->
                                                        (* L'identifiant associé avec le continue ne correspond à aucune boucle de la
                                                           tds, on lève une exception indiquant que la boucle n'est pas atteignable avec
                                                           l'identifiant de la boucle en question *)
                                                        raise (BoucleInconnue str)
                                                    |Some ia ->
                                                        (* Une info associé à l'identifiant a été trouvée *)
                                                        begin
                                                            match (info_ast_to_info ia) with
                                                                |InfoLoop (id,_,_,_) ->
                                                                    (* On vérifie que l'identifiant de la boucle qu'on souhaite remonter 
                                                                    appartient à la liste des identifiants des boucles supérieur à la boucle
                                                                    courante *)
                                                                    if (List.mem id l) then
                                                                        (* La boucle à remonter se situe bien dans la liste, on renvoie 
                                                                           un AstTds.Continue avec l'info de cette boucle *)
                                                                        AstTds.Continue ia
                                                                    else
                                                                        (* L'identifiant de la boucle n'a pas été trouvé, on lève une exception
                                                                        indiquant que le continue a été mal placé avec l'identifiant de la
                                                                        boucle qu'on souhaitait remonter *)
                                                                        raise (ContinueMalPlace str)
                                                                |_ ->
                                                                    failwith "Erreur interne : filtrage de chercherGlobalement incorrect"
                                                        end
                                            end
                                        |InfoFun _ ->
                                            (* Un continue a été appelé directement depuis le bloc principal d'une
                                            fonction, on lève une exception indiquant que le continue a été mal
                                            placé avec l'identifiant de la boucle qu'on souhaitait remonter *)
                                            raise (ContinueMalPlace str)
                                        | _ ->
                                            failwith "Erreur interne : continue appelé depuis une InfoVar ou une InfoConst"                 
                                end
                    end
        end
    | AstSyntax.Affectation (a,e) ->
        (* Analyse de l'affectable qui fait l'objet de l'affectation et transformation en AstTds.affectable *)
        let na = analyser_tds_affectable tds true a in
        (* Analyse de l'expression que l'on souhaite affecter et transformation en AstTds.expression *)
        let ne = analyse_tds_expression tds e in
            (* On renvoie un AstTds.Affectation avec l'affectable analysé et l'expression analysée *)
            AstTds.Affectation(na, ne)
  | AstSyntax.Constante (n,v) ->
      begin
        match chercherLocalement tds n false with
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
      let nbt = analyse_tds_bloc tds oia t in
      (* Analyse du bloc else *)
      let nbe = analyse_tds_bloc tds oia e in
      (* Renvoie la nouvelle structure de la conditionnelle *)
      AstTds.Conditionnelle (nc, nbt, nbe)
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
    match (chercherLocalement maintds n false) with
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
                          match chercherLocalement tdsfille y false with
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
              let info_func = (chercherLocalement maintds n false) in
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
