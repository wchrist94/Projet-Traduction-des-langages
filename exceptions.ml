open Type
open Ast.AstSyntax

(* Exceptions pour la gestion des identificateurs *)
exception DoubleDeclaration of string 
exception IdentifiantNonDeclare of string 
exception MauvaiseUtilisationIdentifiant of string 
exception BreakMalPlace of string
exception ContinueMalPlace of string
exception BoucleInconnue of string
exception BreakNonNommeeMalPlace
exception ContinueNonNommeMalPlace

(* Exceptions pour le typage *)
(* Le premier type est le type réel, le second est le type attendu *)
exception TypeInattendu of typ * typ
exception TypesParametresInattendus of typ list * typ list
exception TypeBinaireInattendu of binaire * typ * typ (* les types sont les types réels non compatible avec les signatures connues de l'opérateur *)
exception PointeurNull
exception TypeCondTernaireInattendus of typ * typ
exception TypeValTernaireInattendus of typ * typ

(* Utilisation illégale de return dans le programme principal *)
exception RetourDansMain
