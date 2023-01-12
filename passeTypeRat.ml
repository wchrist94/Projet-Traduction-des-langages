(* Module de la passe de gestion de typage *)
(* doit être conforme à l'interface passe *)

open Tds
open Type 
open Exceptions
open Ast

type t1 = Ast.AstTds.programme
type t2 = Ast.AstType.programme

(* analyser_type_affectable : AstTds.affectable -> AstTds.affectable * typ *)
(* Paramètre a : l'affectable à analyser *)
(* Gère le typage des affectables, renvoie l'AstTds.affectable avec son type *)
(* Erreur si type différent de celui attendu *)
let rec analyser_type_affectable a = 
		match a with 
				|AstTds.Ident info_ast -> 
						begin
								match info_ast_to_info info_ast with
										| InfoVar (_,t,_,_) -> 
											 (* Dans le cas d'une variable, on renvoie un AstTds.Ident avec le type de la variable *)
												AstTds.Ident info_ast,t
										| InfoConst (_,_) -> 
												(* Dans le cas d'une constante, on renvoie un AstTds.Ident avec le type Entier *)
												AstTds.Ident info_ast,Int
										| _ -> 
												(* Cas impossible sauf erreur interne *)
												failwith "Erreur interne passeTypeRat : non affectable dans analyse_type_affectable"
						end
				|AstTds.Deref a1 -> 
						(* Analyse de l'affectable qui fait l'objet du déréférencement *)
						let na,t = analyser_type_affectable a1 in
						begin
								match t with
										|Pointeur nt ->  
												(* renvoie un AstTds.Deref avec le nouvel affectable et le type du pointeur *)
												AstTds.Deref(na),nt
										|_ -> 
												(* Type inattendu *)
												raise (TypeInattendu (t,Pointeur Undefined))
						end

(* analyser_type_expression : AstTds.expression -> AstType.expression $ typ *)
(* Paramètre e : l'expression à analyser *)
(* Gère le typage des expression, les transforme en AstType.expression et donne leurs type *)
(* Erreur si type différent de celui attendu *)
let rec analyser_type_expression e =
	(match e with
		|AstTds.Ternaire (e1,e2,e3) ->
			(* Analyse de la première expression du ternaire *)
			let (ne1, te1) = analyser_type_expression e1 in
			(* Analyse de la deuxième expression du ternaire *)
			let (ne2, te2) = analyser_type_expression e2 in
			(* Analyse de la troisième expression du ternaire *)
			let (ne3, te3) = analyser_type_expression e3 in
					(* La première expression doit être une condition donc de type Bool *)
					if (est_compatible te1 Bool) then
							(* Les deux autres expressions doivent être de même type *)
							if (est_compatible te2 te3) then
								(* Renvoie un AstType.Ternaire avec les trois expressions analysées et le type du ternaire *)
								AstType.Ternaire(ne1,ne2,ne3), te2
							else 
								(* Dans le cas contraire, on lève une exception indiquant que les deux expressions ne sont pas
								 de même type *)
								raise (TypeValTernaireInattendus(te2, te3))
					else 
							(* Dans le cas contraire, on lève une expression indiquant que la première expression n'est pas une
						 	condition donc de type Bool *)
							raise (TypeCondTernaireInattendus(te1,Bool))
		|AstTds.Null ->
				(* Renvoie un AstType.Null avec le type Undefined *)
				AstType.Null, Undefined
		|AstTds.New t ->
				(* Renvoie un AstType.New avec le type du pointeur instancié *)
				AstType.New t, Pointeur t
		|AstTds.Adresse iast ->
				begin
						match (info_ast_to_info iast) with
								(* On vérifie qu'on cherche à accéder à une variable *)
								|InfoVar (_, t, _, _) ->
										(* Renvoie un AstType.Adresse avec le type du pointeur *)
										AstType.Adresse iast, Pointeur t
								(* Cas impossbile sauf erreur interne *)
								| _ ->
										failwith "Erreur interne passeTypeRat : & pas sur une variable"
				end
		|AstTds.Affectable a ->
				(* Analyse de l'affectable *)
				let na,ta = analyser_type_affectable a in
						(* Renvoie un AstType.Affectable avec l'affectable analysé et son type *)
						AstType.Affectable na, ta
		|AstTds.Booleen b -> 
				(* Retourne un AstType.Booleen qui est de type bool nécessairement *)
				AstType.Booleen b, Bool
		|AstTds.Entier i ->
				(* Retourne un AstType.Entier qui est de type entier nécessairement *)
			  AstType.Entier i, Int
		|AstTds.Unaire (u, exp) ->  
				(* Analyse de l'expression liée à l'opération unaire *)
				let (ne,te) = (analyser_type_expression exp) in
							(* On attend une expression de type Rat *)
							if (est_compatible te Rat) then match u with
										|	Numerateur ->  
													(* Renvoie un AstType.Unaire numérateur avec la nouvelle expression et de type int *)
													AstType.Unaire (Numerateur,ne),Int
										| Denominateur -> 
													(* Renvoie un AstType.Unaire dénominateur avec la nouvelle expression et de type int *)
   												AstType.Unaire (Denominateur,ne),Int  
							else 
										(* Type inattendu si autre que Rat *)
										raise (TypeInattendu (te,Rat))
		|AstTds.Binaire (b, exp1, exp2) -> 
					(* Analyse de la première expression liée à l'opération binaire *)
					let (ne1, te1) = analyser_type_expression exp1 in
					(* Analyse de la seconde expression liée à l'opération binaire *)
					let (ne2, te2) = analyser_type_expression exp2 in
								begin
											match b with
														|AstSyntax.Fraction -> 
																	(* Cas d'une fraction entre deux entiers *)
																	if ((est_compatible te1 Int) && (est_compatible te2 Int)) then
																				(* Renvoie un AstType.Binaire avec un AstType.Fraction composé 
																					 des deux expressions analysées et qui est de type Rat *)
																				AstType.Binaire (AstType.Fraction,ne1,ne2), Rat
																	else	
																				(* Fraction possible uniquement entre deux entiers *)
																				raise (TypeBinaireInattendu (Fraction,te1,te2))
														|AstSyntax.Plus -> 
																	(* Cas d'un addition entre deux entiers *)
																	if ((est_compatible te1 Int) && (est_compatible te2 Int)) then
																				(* Renvoie un AstType.Binaire avec un AstType.PlusInt composé 
																					 des deux expressions analysées et qui est de type Int *)
																				AstType.Binaire (AstType.PlusInt,ne1,ne2), Int
																	(* Cas d'une addition entre deux Rats *)
																	else if ((est_compatible te1 Rat) && (est_compatible te2 Rat)) then
																				(* Renvoie un AstType.Binaire avec un AstType.PlusRat composé 
																					 des deux expressions analysées et qui est de type Rat *)
																				AstType.Binaire (AstType.PlusRat,ne1,ne2), Rat
																	else
																				(* Erreur si on ne respecte pas un des deux critères précédents *)
																				raise (TypeBinaireInattendu (Plus, te1, te2))
														|AstSyntax.Mult ->
																	(* Cas de la multiplication entre deux entiers *)
																	if ((est_compatible te1 Int) && (est_compatible te2 Int)) then
																				(* Renvoie un AstType.Binaire avec un AstType.MultInt composé 
																					 des deux expressions analysées et qui est de type Int *)
																				AstType.Binaire (AstType.MultInt,ne1,ne2), Int
																	(* Cas de la multiplication entre deux Rats *)
																	else if ((est_compatible te1 Rat) && (est_compatible te2 Rat)) then
																				(* Renvoie un AstType.Binaire avec un AstType.MultRat composé 
																					 des deux expressions analysées et qui est de type Rat *)
																				AstType.Binaire (AstType.MultRat,ne1,ne2), Rat
																	(* Erreur si on ne respecte pas un des deux critères précédents *)
																	else
																				raise (TypeBinaireInattendu (Mult, te1, te2))
														|AstSyntax.Equ ->	
																	(* Cas de l'évaluation de l'égalité entre deux entier *)
																	if ((est_compatible te1 Int) && (est_compatible te2 Int)) then
																				(* Renvoie un AstType.Binaire avec un AstType.EquInt composé 
																					 des deux expressions analysées et qui est de type Bool *)
																				AstType.Binaire (AstType.EquInt,ne1,ne2), Bool
																	(* Cas de l'évaluation de l'égalité entre deux booléens *)
																	else if ((est_compatible te1 Bool) && (est_compatible te2 Bool)) then
																				(* Renvoie un AstType.Binaire avec un AstType.EquBool composé 
																					 des deux expressions analysées et qui est de type Bool *)
																				AstType.Binaire (AstType.EquBool,ne1,ne2), Bool
																	(* Erreur si les types ne satisfont pas l'un des deux critères précédents *)
																	else
																				raise (TypeBinaireInattendu (Equ, te1, te2))
														|AstSyntax.Inf -> 
																	(* Cas de l'opération Inf entre deux entiers *)
																	if ((est_compatible te1 Int) && (est_compatible te2 Int)) then
																				(* Renvoie un AstType.Binaire avec un AstType.Inf composé 
																					 des deux expressions analysées et qui est de type Bool *)
																				AstType.Binaire (AstType.Inf,ne1,ne2), Bool
																	(* Erreur si appelé avec autre chose que deux entiers *)
																	else
																				raise (TypeBinaireInattendu (Inf, te1, te2))
									end
		|AstTds.AppelFonction (iast, le) -> 
				begin
					match (info_ast_to_info iast) with
					(* Accès aux informations de l'InfoFun *)
					|InfoFun (_, t, ltp) -> let te = [] in
						(try
						(* Création de la liste des expressions appelées après analyse *)
						let lne, _ = List.split (List.map2 (fun x y -> 
																								(* Analyse d'une expression de la liste le et accès à son type *)
																								let ne,te = (analyser_type_expression x) in 
																									(* Dans le cas où le type de l'expression analysée est conforme à
																										 celle contenue dans l'info on ajoute à la liste lne*)
																									if (est_compatible te y) then
																										(ne,te)
																									(* Si le type de l'expression analysée n'est pas celui attendu, on
																										 renvoie une erreur indiquant le type attendu *)
																									else
																										raise (TypeInattendu (te, t))
																									)
																									(* Application de la fonction précédente à la liste des expression appelées
																										 avec la fonction et la liste des types des paramètres de la fonction *) 																										
																									le ltp) 
						in
							(* Renvoie un AstType.fonction avec l'info et la liste des expressions après analyse et le type de retour de
								 la fonction *)
							AstType.AppelFonction(iast, lne), t
						(* On renvoie l'erreur qui liste les type desparamètres appelés et ceux attendus *)
					with _ -> raise (TypesParametresInattendus (te,ltp)))
					(* Cas où l'info ne correspond pas à une InfoFun qui représente un cas impossible sauf erreur interne *)
					|_ -> failwith "Erreur interne"
			end)

(* analyser_type_instruction : AstTds.instruction -> AstType.instruction *)
(* Paramètre i : l'instrucyion à analyser *)
(* Gère le typage d'une instruction et la transforme en AstType.instruction *)
(* Erreur si type différent de celui attendu ou si retour effectué dans le main *)
let rec analyser_type_instruction i =
			begin
						match i with
									|AstTds.Declaration(t, iast , e) -> 
													(* Modfication de l'info pour y ajouter le type de la variable *)
													modifier_type_variable t iast;
													(* Transformation de l'expression associée à la déclaration et accès à son type *)
													let (ne, te) = analyser_type_expression e in
															(* Vérification que le type de l'expression correspond à celui associé ç la déclaration *)
															if (est_compatible te t) then
																	(* Renvoie un AstType.Declaration contenant l'info et la nouvelle expression *)
																	AstType.Declaration(iast, ne)
															else
																	(* On regarde si on essaie de declarer un pointeur ou une un non pointeur de la mauvaise manière *)
																	if (detection_non_Pointeur t && not (detection_non_Pointeur te)) then
																			(* On déclare un non pointeur de la mauvaise manière *)
																			match (info_ast_to_info iast) with
																					| InfoVar (n,_,_,_) ->
																							raise (PasUnPointeur n)
																					| InfoConst (n,_) ->
																							raise (PasUnPointeur n)
																					| _ ->
																							failwith "Erreur interne : Déclaration inapproprié d'une boucle ou d'une fonction"
																	else	if (not (detection_non_Pointeur t) && detection_non_Pointeur te ) then
																					(* On déclare un pointeur de la mauvaise manière *)
																					raise (MauvaiseOperationSurPointeur)
																	else if ((est_compatible te Undefined) && (detection_non_Pointeur t)) then
																			(* On tente de declarer un non pointeur à null, on lève une exception *)
																			match (info_ast_to_info iast) with
																					| InfoVar (n,_,_,_) ->
																							raise (PasUnPointeur n)
																					| InfoConst (n,_) ->
																							raise (PasUnPointeur n)
																					| _ ->
																							failwith "Erreur interne : Déclaration inapproprié d'une boucle ou d'une fonction"
																	else
																			(* Type inattendu entre non pointeurs *)
																			raise (TypeInattendu (te, t))
									|AstTds.Affectation(a,e) -> 
											(* Analyse de l'expression liée à l'affectation *)
											let ne,te = analyser_type_expression e in
											begin
													match a with
															(* L'objet de l'affectation est un identifiant *)
															|AstTds.Ident iast ->
																	begin
																			match (info_ast_to_info iast) with
																					|InfoVar (n, t, _, _) ->
																							begin
																									match te with
																											|Undefined ->	
																													(* On demande d'affecter un pointeur null à une variable, on lève donc une exception *)
																													raise (OperationInapropriee "null sur un non pointeur")
																											|_ ->
																													(* On vérifie que le type de l'expression à affecter et de la variable sont
																													 identiques *)
																													if (est_compatible te t) then
																															(* On renvoie un AstType.Affectation contenant l'identifiant avec la
																															nouvelle expression *)
																															AstType.Affectation (AstTds.Ident iast, ne)
																													else if (detection_non_Pointeur t && not(detection_non_Pointeur te)) then		
																															(* On affecte un Pointeur à un non pointeur on lève une exception *)						
																															raise (PasUnPointeur n)
																													else if (not(detection_non_Pointeur t) && detection_non_Pointeur te) then
																															(* On tente d'affecter un non pointeur à un pointeur on lève une exception*)
																															raise (MauvaiseOperationSurPointeur)
																													else
																															(* Dans le cas contraire, on lève une exception indiquant que les types 
																															sont différents *)
																															raise (TypeInattendu (te,t))
																								end
																							(* Cas où on tente de faire une affectation sur autre chose qu'une variable, impossible
																								 sauf erreur interne *)
																					|_ -> 
																							failwith "Erreur interne passeTypeRat : Affectation sur un non affectable"
																		end
																	
															(* L'objet de l'affectation est un déréférencement *)
															|AstTds.Deref a1 ->
																	(* Analyse de l'affectable associé au déréférencement *)
																	let na,ta = analyser_type_affectable a1 in
																			begin
																					match ta with
																					| Pointeur t -> 
																						(* Commentaire *)
																							(* On vérifie que le type du pointeur correspond au type de l'expression à affecter *)
																							if (est_compatible te t || est_compatible te Undefined) then
																									(* On renvoie un AstType.Affectation avec un Deref contenant la nouvelle expression *)
																									AstType.Affectation (AstTds.Deref na, ne)
																							else
																									(* Dans le cas contraire, on lève une exception indiquant que les types 
																									sont différents *)																									
																									raise (TypeInattendu (te, t)) (* Pointeur nul a faire*)
																					| _ ->
																							(* Cas impossible sauf erreur interne *)
																							failwith "Erreur interne passeTypeRat : dereferencement avec un non pointeur"
																			end
									
											end
									|AstTds.Affichage e -> 
											(* Transformation de l'expression associé à l'affichage et accès à son type *)
											let (ne, te) = analyser_type_expression e in
													(* Différenciation des affichages en fonction des types *)
													(* Cas de l'affichage d'un entier *)
													if (est_compatible te Int) then
															(* Renvoie un AstType.AffichageInt qui contient la nouvelle expression *)
															AstType.AffichageInt (ne)
													(* Cas de l'affichage d'un booléen *)
													else if (est_compatible te Bool) then
															(* Renvoie un AstType.AffichageBool qui contient la nouvelle expression *)
															AstType.AffichageBool (ne)
													(* Cas de l'affichage d'un Rat *)
													else if (est_compatible te Rat) then
															(* Renvoie un AstType.AffichageRat qui contient la nouvelle expression *)
															AstType.AffichageRat (ne)
													(* Si aucun critère précédent n'a été respecté on a une erreur interne on fait
														 face à un type inconnu *)
													else
															failwith "Erreur interne passeTypeRat : Affichage impossible"
									|AstTds.Conditionnelle (e, b1, b2)-> 
											(* Transformation de l'expression associée à la conditionnelle et accès à son type *)
											let (ne, te) = analyser_type_expression e in
													(* Vérification que le type de l'expression est bien un booléen *)
													if (est_compatible te Bool) then
															(* Transformation du premier bloc de la conditionnelle *)
															let nb1 = analyser_type_bloc b1 in
															(* Transformation du second bloc de la conditionnelle *)
															let nb2 = analyser_type_bloc b2 in
																	(* Renvoie un AstType.Conditionnelle contenant la nouvelle expression et les
																		 nouveaux blocs *)
																	AstType.Conditionnelle (ne, nb1, nb2)
													(* Cas où le type de l'expression n'est pas un booléen on renvoie une erreur
													indiquant qu'on attendait un booléen *)
													else
															raise (TypeInattendu (te, Bool))
									|AstTds.Retour (e, iast) -> 
													begin
														match (info_ast_to_info iast) with
															(* Accès au type de retour de la fonction contenu dans l'info *)
															|InfoFun (_, t, _) -> 
																	(* Transformation de l'expression liée au retour et accès à son type *)
																	let (ne,te) = analyser_type_expression e in
																			(* Vérification que le type de l'expression est conforme à celui contenu
																				 dans l'info *)
																			if (est_compatible t te) then
																					(* Renvoie un AstType.Retour contenant la nouvelle expression et l'info *)
																					AstType.Retour(ne,iast)
																			(* Renvoie une erreur si le type de l'expression n'est pas conforme indiquant le
																				 type attendu *)
																			else
																					raise (TypeInattendu (te,t))
															(* Si l'info n'est pas une InfoFun on ne se situe donc pas dans une fonction on renvoie
																 l'erreur indiquant un retour dans le main *)
															|_ -> raise RetourDansMain
													end
									|AstTds.TantQue (e, b) -> 
												(* Transformation de l'expression liée à la boucle et accès à son type *)
												let (ne, te) = analyser_type_expression e in
															(* Vérification que le type de l'expression est un booléen *)
															if (est_compatible te Bool) then
																		(* Transformation du bloc lié à la boucle *)
																		let nb = analyser_type_bloc b in
																					(* Renvoie un AstType.TantQue contenant la nouvelle expression et le nouveau bloc *)
																					AstType.TantQue (ne, nb)
															(* Cas oÙ le type de l'expression n'est pas un booléen on renvoie un erreur en indiquant qu'on
																 en attend un *)
															else
																		raise (TypeInattendu (te, Bool))
									|AstTds.Empty -> 
												(* Transformation de l'AstTds.Empty en AstType.Empty *)
												AstType.Empty
									|AstTds.Loop (ia,b) ->
												(* Analyse du bloc de la boucle *)
												let nb = analyser_type_bloc b in 
													(* Renvoie un AstType.Loop avec le nouveau bloc *)
													AstType.Loop(ia,nb)
									|AstTds.Continue ia ->
													(* Transforme l'AstTds.Continue en AstType.Continue *)
													AstType.Continue ia
									|AstTds.Break ia ->
													(* Transforme l'AstTds.Break en AstType.Break *)
													AstType.Break ia
			end

(* analyser_type_bloc : AstTds.bloc -> AstType.bloc *)
(* Paramètre list : la liste d'instruction constituant le bloc à analyser *)
(* Gère le typage du bloc et le transforme en AstType.bloc *)
and analyser_type_bloc list =
	(* Application d'analyser_type_instruction à la liste des instructions formant le bloc
		 pour obtenir le nouveau bloc de type AstType.bloc *)
	List.map analyser_type_instruction list
		
(* analyser_type_fonction : AstTds.fonction -> AstType.fonction *)
(* Paramètre : la fonction à analyser *)
(* Gère le typage du retour de la fonction, de tous ses paramètres et la transforme en AstType.fonction *)
let analyser_type_fonction (AstTds.Fonction (r, iast, lp, b)) =
		(* Définition du type de chaque paramètre de la fonction (contenu dans la liste lp)
			 à l'info lui correspondant *)
		List.iter (fun (x,y) -> modifier_type_variable x y) lp;
		(* Séparation de la liste des infos et de la liste des types à partir de lp *)
		let liste_type,liste_iast = List.split lp in
				(* Définition du type de retour et des types des paramètres dans l'info de la fonction *)
				modifier_type_fonction r liste_type iast;
		(* Transformation du bloc de la fonction *)
		let nb = analyser_type_bloc b in
				(* Renvoie un AstType.Fonction contenant l'info de la fonction, la liste des infos des paramètres et le
					 nouveau bloc *)
				AstType.Fonction(iast, liste_iast, nb)

(* analyser : AstTds.programme -> AstType.programme *)
(* Paramètre : le programme à analyser *)
(* Gère le typage des fonctions et du bloc principal du programme et le transforme en AstType.programme *)
let analyser (AstTds.Programme(fonctions,prog)) =
			(* Transformation de la liste de fonction pour obtenir la nouvelle liste de fonctions de type
				 AstType.fonction *)
			let nlf = List.map (analyser_type_fonction) fonctions in
			(* Transformation du bloc principal de la fonction pour obtenir le nouveau bloc de type
				 AstType.bloc *)
      let nb = analyser_type_bloc prog in
				 (* Renvoie un AstType.programme contenant la nouvelle liste de fonctions et le nouveau bloc *)
     		 AstType.Programme(nlf,nb)

  