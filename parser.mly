/* Imports. */

%{

open Type
open Ast.AstSyntax
%}


%token <int> ENTIER
%token <string> ID
%token RETURN
%token PV
%token AO
%token AF
%token PF
%token PO
%token EQUAL
%token CONST
%token PRINT
%token IF
%token ELSE
%token WHILE
%token BOOL
%token INT
%token RAT
%token CALL 
%token CO
%token CF
%token SLASH
%token NUM
%token DENOM
%token TRUE
%token FALSE
%token PLUS
%token MULT
%token INF
%token EOF
(* Token des pointeurs *)
%token AD
%token NULL
%token NEW
(* Token de l'opérateur ternaire *)
%token TER
%token DP
(* Token des boucles *)
%token LOOP
%token BREAK
%token CONTINUE

(* Type de l'attribut synthétisé des non-terminaux *)
%type <programme> prog
%type <instruction list> bloc
%type <fonction> fonc
%type <instruction> i
%type <typ> typ
%type <typ*string> param
%type <expression> e 

(* Type et définition de l'axiome *)
%start <Ast.AstSyntax.programme> main

%%

main : lfi=prog EOF     {lfi}

prog : lf=fonc* ID li=bloc  {Programme (lf,li)}

fonc : t=typ n=ID PO lp=param* PF li=bloc {Fonction(t,n,lp,li)}

param : t=typ n=ID  {(t,n)}

bloc : AO li=i* AF      {li}


i :
| t=typ n=ID EQUAL e1=e PV          {Declaration (t,n,e1)}
| CONST n=ID EQUAL e=ENTIER PV      {Constante (n,e)}
| PRINT e1=e PV                     {Affichage (e1)}
| WHILE exp=e li=bloc               {TantQue (exp,li)}
| RETURN exp=e PV                   {Retour (exp)}
(* Instruction modifiée ou ajoutée pour le traitement des conditionelles sans bloc else (bloc else = [])*)
| IF exp=e li1=bloc ELSE li2=bloc  {Conditionnelle (exp,li1,li2)}
| IF exp=e li1=bloc                {Conditionnelle (exp,li1,[])}

(* Instruction de l'affectation modifiée : à gauche de l'opérateur "=" on a un affectable désormais et une expression de
l'autre côté *)
| a1=a EQUAL e1=e PV                {Affectation (a1,e1)}
(* Instructions ajoutées pour traiter les boucles nommées et non nommées (le nom de la boucle est remplacé par None dans le cas
d'une boucle non nommée) *)
| LOOP li=bloc                      {Loop (None,li)}
| n=ID DP LOOP li=bloc              {Loop (Some n,li)}
| BREAK PV                          {Break None}
| BREAK n=ID PV                     {Break (Some n)}
| CONTINUE PV                       {Continue None}
| CONTINUE n=ID PV                  {Continue (Some n)}

typ :
| BOOL    {Bool}
| INT     {Int}
| RAT     {Rat}
(* type Pointeur (par ex (int * ) ou int * ) *)
| PO t = typ MULT PF {Pointeur t}
| t = typ MULT {Pointeur t} 

e : 
| CALL n=ID PO lp=e* PF   {AppelFonction (n,lp)}
| CO e1=e SLASH e2=e CF   {Binaire(Fraction,e1,e2)}
| TRUE                    {Booleen true}
| FALSE                   {Booleen false}
| e=ENTIER                {Entier e}
| NUM e1=e                {Unaire(Numerateur,e1)}
| DENOM e1=e              {Unaire(Denominateur,e1)}
| PO e1=e PLUS e2=e PF    {Binaire (Plus,e1,e2)}
| PO e1=e MULT e2=e PF    {Binaire (Mult,e1,e2)}
| PO e1=e EQUAL e2=e PF   {Binaire (Equ,e1,e2)}
| PO e1=e INF e2=e PF     {Binaire (Inf,e1,e2)}
| PO exp=e PF             {exp}
(* Expression des pointeurs *)
| a1 = a                  {Affectable a1}
| NEW t=typ               {New t}
| NULL                    {Null}
| AD adr = ID             {Adresse adr}
(* Expression de l'opérateur Ternaire *)
| e1=e TER e2=e DP e3=e     {Ternaire (e1,e2,e3)}

a :
(* L'identifiant qui a le même comportement que celui de la version avant implémentation du système affectable/non affectable *)
| n = ID                       {Ident n}
(* Pointeur considéré avec ou sans paranthèses *)
| PO MULT a1 = a PF            {Deref a1}
| MULT a1 = a                  {Deref a1}

