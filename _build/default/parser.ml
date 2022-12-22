
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | WHILE
    | TRUE
    | SLASH
    | RETURN
    | RAT
    | PV
    | PRINT
    | PO
    | PLUS
    | PF
    | NUM
    | NULL
    | NEW
    | MULT
    | INT
    | INF
    | IF
    | ID of (
# 11 "parser.mly"
       (string)
# 32 "parser.ml"
  )
    | FALSE
    | EQUAL
    | EOF
    | ENTIER of (
# 10 "parser.mly"
       (int)
# 40 "parser.ml"
  )
    | ELSE
    | DENOM
    | CONST
    | CO
    | CF
    | CALL
    | BOOL
    | AO
    | AF
    | AD
  
end

include MenhirBasics

# 3 "parser.mly"
  

open Type
open Ast.AstSyntax

# 63 "parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_main) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: main. *)

  | MenhirState07 : (('s, _menhir_box_main) _menhir_cell1_typ _menhir_cell0_ID, _menhir_box_main) _menhir_state
    (** State 07.
        Stack shape : typ ID.
        Start symbol: main. *)

  | MenhirState10 : (('s, _menhir_box_main) _menhir_cell1_param, _menhir_box_main) _menhir_state
    (** State 10.
        Stack shape : param.
        Start symbol: main. *)

  | MenhirState13 : ((('s, _menhir_box_main) _menhir_cell1_typ _menhir_cell0_ID, _menhir_box_main) _menhir_cell1_list_param_, _menhir_box_main) _menhir_state
    (** State 13.
        Stack shape : typ ID list(param).
        Start symbol: main. *)

  | MenhirState14 : (('s, _menhir_box_main) _menhir_cell1_AO, _menhir_box_main) _menhir_state
    (** State 14.
        Stack shape : AO.
        Start symbol: main. *)

  | MenhirState15 : (('s, _menhir_box_main) _menhir_cell1_WHILE, _menhir_box_main) _menhir_state
    (** State 15.
        Stack shape : WHILE.
        Start symbol: main. *)

  | MenhirState17 : (('s, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_state
    (** State 17.
        Stack shape : PO.
        Start symbol: main. *)

  | MenhirState18 : (('s, _menhir_box_main) _menhir_cell1_NUM, _menhir_box_main) _menhir_state
    (** State 18.
        Stack shape : NUM.
        Start symbol: main. *)

  | MenhirState20 : (('s, _menhir_box_main) _menhir_cell1_NEW, _menhir_box_main) _menhir_state
    (** State 20.
        Stack shape : NEW.
        Start symbol: main. *)

  | MenhirState22 : (('s, _menhir_box_main) _menhir_cell1_MULT, _menhir_box_main) _menhir_state
    (** State 22.
        Stack shape : MULT.
        Start symbol: main. *)

  | MenhirState27 : (('s, _menhir_box_main) _menhir_cell1_DENOM, _menhir_box_main) _menhir_state
    (** State 27.
        Stack shape : DENOM.
        Start symbol: main. *)

  | MenhirState28 : (('s, _menhir_box_main) _menhir_cell1_CO, _menhir_box_main) _menhir_state
    (** State 28.
        Stack shape : CO.
        Start symbol: main. *)

  | MenhirState31 : (('s, _menhir_box_main) _menhir_cell1_CALL _menhir_cell0_ID, _menhir_box_main) _menhir_state
    (** State 31.
        Stack shape : CALL ID.
        Start symbol: main. *)

  | MenhirState36 : (('s, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_state
    (** State 36.
        Stack shape : e.
        Start symbol: main. *)

  | MenhirState40 : ((('s, _menhir_box_main) _menhir_cell1_CO, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_state
    (** State 40.
        Stack shape : CO e.
        Start symbol: main. *)

  | MenhirState46 : ((('s, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_state
    (** State 46.
        Stack shape : PO e.
        Start symbol: main. *)

  | MenhirState50 : ((('s, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_state
    (** State 50.
        Stack shape : PO e.
        Start symbol: main. *)

  | MenhirState53 : ((('s, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_state
    (** State 53.
        Stack shape : PO e.
        Start symbol: main. *)

  | MenhirState56 : ((('s, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_state
    (** State 56.
        Stack shape : PO e.
        Start symbol: main. *)

  | MenhirState59 : ((('s, _menhir_box_main) _menhir_cell1_WHILE, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_state
    (** State 59.
        Stack shape : WHILE e.
        Start symbol: main. *)

  | MenhirState61 : (('s, _menhir_box_main) _menhir_cell1_RETURN, _menhir_box_main) _menhir_state
    (** State 61.
        Stack shape : RETURN.
        Start symbol: main. *)

  | MenhirState64 : (('s, _menhir_box_main) _menhir_cell1_PRINT, _menhir_box_main) _menhir_state
    (** State 64.
        Stack shape : PRINT.
        Start symbol: main. *)

  | MenhirState67 : (('s, _menhir_box_main) _menhir_cell1_IF, _menhir_box_main) _menhir_state
    (** State 67.
        Stack shape : IF.
        Start symbol: main. *)

  | MenhirState68 : ((('s, _menhir_box_main) _menhir_cell1_IF, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_state
    (** State 68.
        Stack shape : IF e.
        Start symbol: main. *)

  | MenhirState70 : (((('s, _menhir_box_main) _menhir_cell1_IF, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_cell1_bloc, _menhir_box_main) _menhir_state
    (** State 70.
        Stack shape : IF e bloc.
        Start symbol: main. *)

  | MenhirState79 : (('s, _menhir_box_main) _menhir_cell1_typ _menhir_cell0_ID, _menhir_box_main) _menhir_state
    (** State 79.
        Stack shape : typ ID.
        Start symbol: main. *)

  | MenhirState84 : (('s, _menhir_box_main) _menhir_cell1_i, _menhir_box_main) _menhir_state
    (** State 84.
        Stack shape : i.
        Start symbol: main. *)

  | MenhirState87 : (('s, _menhir_box_main) _menhir_cell1_a, _menhir_box_main) _menhir_state
    (** State 87.
        Stack shape : a.
        Start symbol: main. *)

  | MenhirState95 : (('s, _menhir_box_main) _menhir_cell1_list_fonc_ _menhir_cell0_ID, _menhir_box_main) _menhir_state
    (** State 95.
        Stack shape : list(fonc) ID.
        Start symbol: main. *)

  | MenhirState97 : (('s, _menhir_box_main) _menhir_cell1_fonc, _menhir_box_main) _menhir_state
    (** State 97.
        Stack shape : fonc.
        Start symbol: main. *)


and ('s, 'r) _menhir_cell1_a = 
  | MenhirCell1_a of 's * ('s, 'r) _menhir_state * (Ast.AstSyntax.affectable)

and ('s, 'r) _menhir_cell1_bloc = 
  | MenhirCell1_bloc of 's * ('s, 'r) _menhir_state * (Ast.AstSyntax.bloc)

and ('s, 'r) _menhir_cell1_e = 
  | MenhirCell1_e of 's * ('s, 'r) _menhir_state * (Ast.AstSyntax.expression)

and ('s, 'r) _menhir_cell1_fonc = 
  | MenhirCell1_fonc of 's * ('s, 'r) _menhir_state * (Ast.AstSyntax.fonction)

and ('s, 'r) _menhir_cell1_i = 
  | MenhirCell1_i of 's * ('s, 'r) _menhir_state * (Ast.AstSyntax.instruction)

and ('s, 'r) _menhir_cell1_list_fonc_ = 
  | MenhirCell1_list_fonc_ of 's * ('s, 'r) _menhir_state * (Ast.AstSyntax.fonction list)

and ('s, 'r) _menhir_cell1_list_param_ = 
  | MenhirCell1_list_param_ of 's * ('s, 'r) _menhir_state * ((Type.typ * string) list)

and ('s, 'r) _menhir_cell1_param = 
  | MenhirCell1_param of 's * ('s, 'r) _menhir_state * (Type.typ * string)

and ('s, 'r) _menhir_cell1_typ = 
  | MenhirCell1_typ of 's * ('s, 'r) _menhir_state * (Type.typ)

and ('s, 'r) _menhir_cell1_AO = 
  | MenhirCell1_AO of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_CALL = 
  | MenhirCell1_CALL of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_CO = 
  | MenhirCell1_CO of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_DENOM = 
  | MenhirCell1_DENOM of 's * ('s, 'r) _menhir_state

and 's _menhir_cell0_ID = 
  | MenhirCell0_ID of 's * (
# 11 "parser.mly"
       (string)
# 260 "parser.ml"
)

and ('s, 'r) _menhir_cell1_IF = 
  | MenhirCell1_IF of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_MULT = 
  | MenhirCell1_MULT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_NEW = 
  | MenhirCell1_NEW of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_NUM = 
  | MenhirCell1_NUM of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_PO = 
  | MenhirCell1_PO of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_PRINT = 
  | MenhirCell1_PRINT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_RETURN = 
  | MenhirCell1_RETURN of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_WHILE = 
  | MenhirCell1_WHILE of 's * ('s, 'r) _menhir_state

and _menhir_box_main = 
  | MenhirBox_main of (Ast.AstSyntax.programme) [@@unboxed]

let _menhir_action_01 =
  fun n ->
    (
# 105 "parser.mly"
                          (Ident n)
# 295 "parser.ml"
     : (Ast.AstSyntax.affectable))

let _menhir_action_02 =
  fun a1 ->
    (
# 106 "parser.mly"
                          (Deref a1)
# 303 "parser.ml"
     : (Ast.AstSyntax.affectable))

let _menhir_action_03 =
  fun li ->
    (
# 66 "parser.mly"
                        (li)
# 311 "parser.ml"
     : (Ast.AstSyntax.bloc))

let _menhir_action_04 =
  fun lp n ->
    (
# 86 "parser.mly"
                          (AppelFonction (n,lp))
# 319 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_05 =
  fun e1 e2 ->
    (
# 87 "parser.mly"
                          (Binaire(Fraction,e1,e2))
# 327 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_06 =
  fun a1 ->
    (
# 89 "parser.mly"
                          (Affectable a1)
# 335 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_07 =
  fun t ->
    (
# 90 "parser.mly"
                          (New t)
# 343 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_08 =
  fun () ->
    (
# 91 "parser.mly"
                          (Null)
# 351 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_09 =
  fun adr ->
    (
# 92 "parser.mly"
                          (Adresse adr)
# 359 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_10 =
  fun () ->
    (
# 93 "parser.mly"
                          (Booleen true)
# 367 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_11 =
  fun () ->
    (
# 94 "parser.mly"
                          (Booleen false)
# 375 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_12 =
  fun e ->
    (
# 95 "parser.mly"
                          (Entier e)
# 383 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_13 =
  fun e1 ->
    (
# 96 "parser.mly"
                          (Unaire(Numerateur,e1))
# 391 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_14 =
  fun e1 ->
    (
# 97 "parser.mly"
                          (Unaire(Denominateur,e1))
# 399 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_15 =
  fun e1 e2 ->
    (
# 98 "parser.mly"
                          (Binaire (Plus,e1,e2))
# 407 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_16 =
  fun e1 e2 ->
    (
# 99 "parser.mly"
                          (Binaire (Mult,e1,e2))
# 415 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_17 =
  fun e1 e2 ->
    (
# 100 "parser.mly"
                          (Binaire (Equ,e1,e2))
# 423 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_18 =
  fun e1 e2 ->
    (
# 101 "parser.mly"
                          (Binaire (Inf,e1,e2))
# 431 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_19 =
  fun exp ->
    (
# 102 "parser.mly"
                          (exp)
# 439 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_20 =
  fun li lp n t ->
    (
# 62 "parser.mly"
                                          (Fonction(t,n,lp,li))
# 447 "parser.ml"
     : (Ast.AstSyntax.fonction))

let _menhir_action_21 =
  fun e1 n t ->
    (
# 69 "parser.mly"
                                    (Declaration (t,n,e1))
# 455 "parser.ml"
     : (Ast.AstSyntax.instruction))

let _menhir_action_22 =
  fun a1 e1 ->
    (
# 71 "parser.mly"
                                    (Affectation (a1,e1))
# 463 "parser.ml"
     : (Ast.AstSyntax.instruction))

let _menhir_action_23 =
  fun e n ->
    (
# 72 "parser.mly"
                                    (Constante (n,e))
# 471 "parser.ml"
     : (Ast.AstSyntax.instruction))

let _menhir_action_24 =
  fun e1 ->
    (
# 73 "parser.mly"
                                    (Affichage (e1))
# 479 "parser.ml"
     : (Ast.AstSyntax.instruction))

let _menhir_action_25 =
  fun exp li1 li2 ->
    (
# 74 "parser.mly"
                                    (Conditionnelle (exp,li1,li2))
# 487 "parser.ml"
     : (Ast.AstSyntax.instruction))

let _menhir_action_26 =
  fun exp li ->
    (
# 75 "parser.mly"
                                    (TantQue (exp,li))
# 495 "parser.ml"
     : (Ast.AstSyntax.instruction))

let _menhir_action_27 =
  fun exp ->
    (
# 76 "parser.mly"
                                    (Retour (exp))
# 503 "parser.ml"
     : (Ast.AstSyntax.instruction))

let _menhir_action_28 =
  fun () ->
    (
# 208 "<standard.mly>"
    ( [] )
# 511 "parser.ml"
     : (Ast.AstSyntax.expression list))

let _menhir_action_29 =
  fun x xs ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 519 "parser.ml"
     : (Ast.AstSyntax.expression list))

let _menhir_action_30 =
  fun () ->
    (
# 208 "<standard.mly>"
    ( [] )
# 527 "parser.ml"
     : (Ast.AstSyntax.fonction list))

let _menhir_action_31 =
  fun x xs ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 535 "parser.ml"
     : (Ast.AstSyntax.fonction list))

let _menhir_action_32 =
  fun () ->
    (
# 208 "<standard.mly>"
    ( [] )
# 543 "parser.ml"
     : (Ast.AstSyntax.bloc))

let _menhir_action_33 =
  fun x xs ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 551 "parser.ml"
     : (Ast.AstSyntax.bloc))

let _menhir_action_34 =
  fun () ->
    (
# 208 "<standard.mly>"
    ( [] )
# 559 "parser.ml"
     : ((Type.typ * string) list))

let _menhir_action_35 =
  fun x xs ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 567 "parser.ml"
     : ((Type.typ * string) list))

let _menhir_action_36 =
  fun lfi ->
    (
# 58 "parser.mly"
                        (lfi)
# 575 "parser.ml"
     : (Ast.AstSyntax.programme))

let _menhir_action_37 =
  fun n t ->
    (
# 64 "parser.mly"
                    ((t,n))
# 583 "parser.ml"
     : (Type.typ * string))

let _menhir_action_38 =
  fun lf li ->
    (
# 60 "parser.mly"
                            (Programme (lf,li))
# 591 "parser.ml"
     : (Ast.AstSyntax.programme))

let _menhir_action_39 =
  fun () ->
    (
# 79 "parser.mly"
          (Bool)
# 599 "parser.ml"
     : (Type.typ))

let _menhir_action_40 =
  fun () ->
    (
# 80 "parser.mly"
          (Int)
# 607 "parser.ml"
     : (Type.typ))

let _menhir_action_41 =
  fun () ->
    (
# 81 "parser.mly"
          (Rat)
# 615 "parser.ml"
     : (Type.typ))

let _menhir_action_42 =
  fun t ->
    (
# 83 "parser.mly"
               (Pointeur t)
# 623 "parser.ml"
     : (Type.typ))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | AD ->
        "AD"
    | AF ->
        "AF"
    | AO ->
        "AO"
    | BOOL ->
        "BOOL"
    | CALL ->
        "CALL"
    | CF ->
        "CF"
    | CO ->
        "CO"
    | CONST ->
        "CONST"
    | DENOM ->
        "DENOM"
    | ELSE ->
        "ELSE"
    | ENTIER _ ->
        "ENTIER"
    | EOF ->
        "EOF"
    | EQUAL ->
        "EQUAL"
    | FALSE ->
        "FALSE"
    | ID _ ->
        "ID"
    | IF ->
        "IF"
    | INF ->
        "INF"
    | INT ->
        "INT"
    | MULT ->
        "MULT"
    | NEW ->
        "NEW"
    | NULL ->
        "NULL"
    | NUM ->
        "NUM"
    | PF ->
        "PF"
    | PLUS ->
        "PLUS"
    | PO ->
        "PO"
    | PRINT ->
        "PRINT"
    | PV ->
        "PV"
    | RAT ->
        "RAT"
    | RETURN ->
        "RETURN"
    | SLASH ->
        "SLASH"
    | TRUE ->
        "TRUE"
    | WHILE ->
        "WHILE"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37-39"]
  
  let rec _menhir_run_96 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_list_fonc_ _menhir_cell0_ID -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _v _tok ->
      let MenhirCell0_ID (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_list_fonc_ (_menhir_stack, _, lf) = _menhir_stack in
      let li = _v in
      let _v = _menhir_action_38 lf li in
      match (_tok : MenhirBasics.token) with
      | EOF ->
          let lfi = _v in
          let _v = _menhir_action_36 lfi in
          MenhirBox_main _v
      | _ ->
          _eRR ()
  
  let rec _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | MULT ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ID _v_0 ->
          let _menhir_stack = MenhirCell0_ID (_menhir_stack, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | PO ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | RAT ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v = _menhir_action_41 () in
                  _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState07 _tok
              | INT ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v = _menhir_action_40 () in
                  _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState07 _tok
              | BOOL ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v = _menhir_action_39 () in
                  _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState07 _tok
              | PF ->
                  let _v = _menhir_action_34 () in
                  _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState07
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_05 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_typ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_typ (_menhir_stack, _menhir_s, t) = _menhir_stack in
      let _v = _menhir_action_42 t in
      _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_typ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState84 ->
          _menhir_run_77 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState14 ->
          _menhir_run_77 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState20 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState10 ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState07 ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState97 ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState00 ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_77 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | MULT ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ID _v_0 ->
          let _menhir_stack = MenhirCell0_ID (_menhir_stack, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | EQUAL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TRUE ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v = _menhir_action_10 () in
                  _menhir_run_80 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | PO ->
                  _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState79
              | NUM ->
                  _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState79
              | NULL ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v = _menhir_action_08 () in
                  _menhir_run_80 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | NEW ->
                  _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState79
              | MULT ->
                  _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState79
              | ID _v_3 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let n = _v_3 in
                  let _v = _menhir_action_01 n in
                  _menhir_run_38_spec_79 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | FALSE ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v = _menhir_action_11 () in
                  _menhir_run_80 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | ENTIER _v_6 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let e = _v_6 in
                  let _v = _menhir_action_12 e in
                  _menhir_run_80 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | DENOM ->
                  _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState79
              | CO ->
                  _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState79
              | CALL ->
                  _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState79
              | AD ->
                  _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState79
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_80 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_typ _menhir_cell0_ID -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_ID (_menhir_stack, n) = _menhir_stack in
          let MenhirCell1_typ (_menhir_stack, _menhir_s, t) = _menhir_stack in
          let e1 = _v in
          let _v = _menhir_action_21 e1 n t in
          _menhir_goto_i _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_i : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_i (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState84
      | RETURN ->
          _menhir_run_61 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState84
      | RAT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_41 () in
          _menhir_run_77 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState84 _tok
      | PRINT ->
          _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState84
      | MULT ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState84
      | INT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_40 () in
          _menhir_run_77 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState84 _tok
      | IF ->
          _menhir_run_67 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState84
      | ID _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v_2 in
          let _v = _menhir_action_01 n in
          _menhir_run_86 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState84 _tok
      | CONST ->
          _menhir_run_72 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState84
      | BOOL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_39 () in
          _menhir_run_77 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState84 _tok
      | AF ->
          let _v = _menhir_action_32 () in
          _menhir_run_85 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _eRR ()
  
  and _menhir_run_15 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_WHILE (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_10 () in
          _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState15 _tok
      | PO ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState15
      | NUM ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState15
      | NULL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_08 () in
          _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState15 _tok
      | NEW ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState15
      | MULT ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState15
      | ID _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_01 n in
          _menhir_run_38_spec_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | FALSE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_11 () in
          _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState15 _tok
      | ENTIER _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let e = _v in
          let _v = _menhir_action_12 e in
          _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState15 _tok
      | DENOM ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState15
      | CO ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState15
      | CALL ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState15
      | AD ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState15
      | _ ->
          _eRR ()
  
  and _menhir_run_59 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_WHILE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_e (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | AO ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState59
      | _ ->
          _eRR ()
  
  and _menhir_run_14 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_AO (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState14
      | RETURN ->
          _menhir_run_61 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState14
      | RAT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_41 () in
          _menhir_run_77 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState14 _tok
      | PRINT ->
          _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState14
      | MULT ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState14
      | INT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_40 () in
          _menhir_run_77 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState14 _tok
      | IF ->
          _menhir_run_67 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState14
      | ID _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_01 n in
          _menhir_run_86 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState14 _tok
      | CONST ->
          _menhir_run_72 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState14
      | BOOL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_39 () in
          _menhir_run_77 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState14 _tok
      | AF ->
          let _v = _menhir_action_32 () in
          _menhir_run_82 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _eRR ()
  
  and _menhir_run_61 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_RETURN (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_10 () in
          _menhir_run_62 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | PO ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState61
      | NUM ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState61
      | NULL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_08 () in
          _menhir_run_62 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | NEW ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState61
      | MULT ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState61
      | ID _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_01 n in
          _menhir_run_38_spec_61 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | FALSE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_11 () in
          _menhir_run_62 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | ENTIER _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let e = _v in
          let _v = _menhir_action_12 e in
          _menhir_run_62 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | DENOM ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState61
      | CO ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState61
      | CALL ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState61
      | AD ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState61
      | _ ->
          _eRR ()
  
  and _menhir_run_62 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_RETURN -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_RETURN (_menhir_stack, _menhir_s) = _menhir_stack in
          let exp = _v in
          let _v = _menhir_action_27 exp in
          _menhir_goto_i _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_17 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PO (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_10 () in
          _menhir_run_45 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState17 _tok
      | PO ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState17
      | NUM ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState17
      | NULL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_08 () in
          _menhir_run_45 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState17 _tok
      | NEW ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState17
      | MULT ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState17
      | ID _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_01 n in
          _menhir_run_38_spec_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | FALSE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_11 () in
          _menhir_run_45 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState17 _tok
      | ENTIER _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let e = _v in
          let _v = _menhir_action_12 e in
          _menhir_run_45 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState17 _tok
      | DENOM ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState17
      | CO ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState17
      | CALL ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState17
      | AD ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState17
      | _ ->
          _eRR ()
  
  and _menhir_run_45 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_PO as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PLUS ->
          let _menhir_stack = MenhirCell1_e (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_10 () in
              _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | PO ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState46
          | NUM ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState46
          | NULL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_08 () in
              _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | NEW ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState46
          | MULT ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState46
          | ID _v_2 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let n = _v_2 in
              let _v = _menhir_action_01 n in
              _menhir_run_38_spec_46 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | FALSE ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_11 () in
              _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | ENTIER _v_5 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let e = _v_5 in
              let _v = _menhir_action_12 e in
              _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | DENOM ->
              _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState46
          | CO ->
              _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState46
          | CALL ->
              _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState46
          | AD ->
              _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState46
          | _ ->
              _eRR ())
      | PF ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_PO (_menhir_stack, _menhir_s) = _menhir_stack in
          let exp = _v in
          let _v = _menhir_action_19 exp in
          _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MULT ->
          let _menhir_stack = MenhirCell1_e (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_10 () in
              _menhir_run_51 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | PO ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState50
          | NUM ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState50
          | NULL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_08 () in
              _menhir_run_51 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | NEW ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState50
          | MULT ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState50
          | ID _v_9 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let n = _v_9 in
              let _v = _menhir_action_01 n in
              _menhir_run_38_spec_50 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | FALSE ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_11 () in
              _menhir_run_51 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | ENTIER _v_12 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let e = _v_12 in
              let _v = _menhir_action_12 e in
              _menhir_run_51 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | DENOM ->
              _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState50
          | CO ->
              _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState50
          | CALL ->
              _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState50
          | AD ->
              _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState50
          | _ ->
              _eRR ())
      | INF ->
          let _menhir_stack = MenhirCell1_e (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_10 () in
              _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | PO ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState53
          | NUM ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState53
          | NULL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_08 () in
              _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | NEW ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState53
          | MULT ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState53
          | ID _v_16 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let n = _v_16 in
              let _v = _menhir_action_01 n in
              _menhir_run_38_spec_53 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | FALSE ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_11 () in
              _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | ENTIER _v_19 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let e = _v_19 in
              let _v = _menhir_action_12 e in
              _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | DENOM ->
              _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState53
          | CO ->
              _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState53
          | CALL ->
              _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState53
          | AD ->
              _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState53
          | _ ->
              _eRR ())
      | EQUAL ->
          let _menhir_stack = MenhirCell1_e (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_10 () in
              _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | PO ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState56
          | NUM ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState56
          | NULL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_08 () in
              _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | NEW ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState56
          | MULT ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState56
          | ID _v_23 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let n = _v_23 in
              let _v = _menhir_action_01 n in
              _menhir_run_38_spec_56 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | FALSE ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_11 () in
              _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | ENTIER _v_26 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let e = _v_26 in
              let _v = _menhir_action_12 e in
              _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | DENOM ->
              _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState56
          | CO ->
              _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState56
          | CALL ->
              _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState56
          | AD ->
              _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState56
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_47 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PF ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_e (_menhir_stack, _, e1) = _menhir_stack in
          let MenhirCell1_PO (_menhir_stack, _menhir_s) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_15 e1 e2 in
          _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_e : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState87 ->
          _menhir_run_88 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState79 ->
          _menhir_run_80 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState67 ->
          _menhir_run_68 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState64 ->
          _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState61 ->
          _menhir_run_62 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState15 ->
          _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState56 ->
          _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState53 ->
          _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState50 ->
          _menhir_run_51 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState46 ->
          _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState17 ->
          _menhir_run_45 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState18 ->
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState27 ->
          _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState40 ->
          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState28 ->
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState36 ->
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState31 ->
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_88 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_a -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_a (_menhir_stack, _menhir_s, a1) = _menhir_stack in
          let e1 = _v in
          let _v = _menhir_action_22 a1 e1 in
          _menhir_goto_i _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_68 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_IF as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_e (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | AO ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState68
      | _ ->
          _eRR ()
  
  and _menhir_run_65 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_PRINT -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_PRINT (_menhir_stack, _menhir_s) = _menhir_stack in
          let e1 = _v in
          let _v = _menhir_action_24 e1 in
          _menhir_goto_i _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_57 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PF ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_e (_menhir_stack, _, e1) = _menhir_stack in
          let MenhirCell1_PO (_menhir_stack, _menhir_s) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_17 e1 e2 in
          _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_54 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PF ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_e (_menhir_stack, _, e1) = _menhir_stack in
          let MenhirCell1_PO (_menhir_stack, _menhir_s) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_18 e1 e2 in
          _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_51 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PF ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_e (_menhir_stack, _, e1) = _menhir_stack in
          let MenhirCell1_PO (_menhir_stack, _menhir_s) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_16 e1 e2 in
          _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_44 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_NUM -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_NUM (_menhir_stack, _menhir_s) = _menhir_stack in
      let e1 = _v in
      let _v = _menhir_action_13 e1 in
      _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_43 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_DENOM -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_DENOM (_menhir_stack, _menhir_s) = _menhir_stack in
      let e1 = _v in
      let _v = _menhir_action_14 e1 in
      _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_41 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_CO, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | CF ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_e (_menhir_stack, _, e1) = _menhir_stack in
          let MenhirCell1_CO (_menhir_stack, _menhir_s) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_05 e1 e2 in
          _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_39 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_CO as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_e (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | SLASH ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_10 () in
              _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | PO ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState40
          | NUM ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState40
          | NULL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_08 () in
              _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | NEW ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState40
          | MULT ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState40
          | ID _v_2 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let n = _v_2 in
              let _v = _menhir_action_01 n in
              _menhir_run_38_spec_40 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | FALSE ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_11 () in
              _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | ENTIER _v_5 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let e = _v_5 in
              let _v = _menhir_action_12 e in
              _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | DENOM ->
              _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState40
          | CO ->
              _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState40
          | CALL ->
              _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState40
          | AD ->
              _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState40
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_18 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_NUM (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_10 () in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | PO ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
      | NUM ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
      | NULL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_08 () in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | NEW ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
      | MULT ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
      | ID _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_01 n in
          _menhir_run_38_spec_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | FALSE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_11 () in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | ENTIER _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let e = _v in
          let _v = _menhir_action_12 e in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | DENOM ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
      | CO ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
      | CALL ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
      | AD ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
      | _ ->
          _eRR ()
  
  and _menhir_run_20 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_NEW (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | RAT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_41 () in
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState20 _tok
      | INT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_40 () in
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState20 _tok
      | BOOL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_39 () in
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState20 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_21 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_NEW as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | MULT ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AD | AO | CALL | CF | CO | DENOM | ENTIER _ | EQUAL | FALSE | ID _ | INF | NEW | NULL | NUM | PF | PLUS | PO | PV | SLASH | TRUE ->
          let MenhirCell1_NEW (_menhir_stack, _menhir_s) = _menhir_stack in
          let t = _v in
          let _v = _menhir_action_07 t in
          _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_22 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MULT (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | MULT ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState22
      | ID _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_01 n in
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_24 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_MULT -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_MULT (_menhir_stack, _menhir_s) = _menhir_stack in
      let a1 = _v in
      let _v = _menhir_action_02 a1 in
      _menhir_goto_a _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_a : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState14 ->
          _menhir_run_86 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState84 ->
          _menhir_run_86 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState87 ->
          _menhir_run_38_spec_87 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState79 ->
          _menhir_run_38_spec_79 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState67 ->
          _menhir_run_38_spec_67 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState64 ->
          _menhir_run_38_spec_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState61 ->
          _menhir_run_38_spec_61 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState15 ->
          _menhir_run_38_spec_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState17 ->
          _menhir_run_38_spec_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState56 ->
          _menhir_run_38_spec_56 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState53 ->
          _menhir_run_38_spec_53 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState50 ->
          _menhir_run_38_spec_50 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState46 ->
          _menhir_run_38_spec_46 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState18 ->
          _menhir_run_38_spec_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState27 ->
          _menhir_run_38_spec_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState28 ->
          _menhir_run_38_spec_28 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState40 ->
          _menhir_run_38_spec_40 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState31 ->
          _menhir_run_38_spec_31 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState36 ->
          _menhir_run_38_spec_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState22 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_86 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_a (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | EQUAL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_10 () in
              _menhir_run_88 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | PO ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState87
          | NUM ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState87
          | NULL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_08 () in
              _menhir_run_88 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | NEW ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState87
          | MULT ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState87
          | ID _v_2 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let n = _v_2 in
              let _v = _menhir_action_01 n in
              _menhir_run_38_spec_87 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | FALSE ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_11 () in
              _menhir_run_88 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | ENTIER _v_5 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let e = _v_5 in
              let _v = _menhir_action_12 e in
              _menhir_run_88 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | DENOM ->
              _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState87
          | CO ->
              _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState87
          | CALL ->
              _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState87
          | AD ->
              _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState87
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_38_spec_87 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_a -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a1 = _v in
      let _v = _menhir_action_06 a1 in
      _menhir_run_88 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_27 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_DENOM (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_10 () in
          _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | PO ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState27
      | NUM ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState27
      | NULL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_08 () in
          _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | NEW ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState27
      | MULT ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState27
      | ID _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_01 n in
          _menhir_run_38_spec_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | FALSE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_11 () in
          _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | ENTIER _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let e = _v in
          let _v = _menhir_action_12 e in
          _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | DENOM ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState27
      | CO ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState27
      | CALL ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState27
      | AD ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState27
      | _ ->
          _eRR ()
  
  and _menhir_run_38_spec_27 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_DENOM -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a1 = _v in
      let _v = _menhir_action_06 a1 in
      _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_28 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_CO (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_10 () in
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState28 _tok
      | PO ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState28
      | NUM ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState28
      | NULL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_08 () in
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState28 _tok
      | NEW ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState28
      | MULT ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState28
      | ID _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_01 n in
          _menhir_run_38_spec_28 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | FALSE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_11 () in
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState28 _tok
      | ENTIER _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let e = _v in
          let _v = _menhir_action_12 e in
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState28 _tok
      | DENOM ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState28
      | CO ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState28
      | CALL ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState28
      | AD ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState28
      | _ ->
          _eRR ()
  
  and _menhir_run_38_spec_28 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_CO -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a1 = _v in
      let _v = _menhir_action_06 a1 in
      _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState28 _tok
  
  and _menhir_run_29 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_CALL (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ID _v ->
          let _menhir_stack = MenhirCell0_ID (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | PO ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TRUE ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v = _menhir_action_10 () in
                  _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState31 _tok
              | PO ->
                  _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState31
              | NUM ->
                  _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState31
              | NULL ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v = _menhir_action_08 () in
                  _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState31 _tok
              | NEW ->
                  _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState31
              | MULT ->
                  _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState31
              | ID _v_2 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let n = _v_2 in
                  let _v = _menhir_action_01 n in
                  _menhir_run_38_spec_31 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | FALSE ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v = _menhir_action_11 () in
                  _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState31 _tok
              | ENTIER _v_5 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let e = _v_5 in
                  let _v = _menhir_action_12 e in
                  _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState31 _tok
              | DENOM ->
                  _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState31
              | CO ->
                  _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState31
              | CALL ->
                  _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState31
              | AD ->
                  _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState31
              | PF ->
                  let _v = _menhir_action_28 () in
                  _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer _v
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_36 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_e (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_10 () in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState36 _tok
      | PO ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState36
      | NUM ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState36
      | NULL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_08 () in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState36 _tok
      | NEW ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState36
      | MULT ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState36
      | ID _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v_2 in
          let _v = _menhir_action_01 n in
          _menhir_run_38_spec_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | FALSE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_11 () in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState36 _tok
      | ENTIER _v_5 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let e = _v_5 in
          let _v = _menhir_action_12 e in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState36 _tok
      | DENOM ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState36
      | CO ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState36
      | CALL ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState36
      | AD ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState36
      | PF ->
          let _v = _menhir_action_28 () in
          _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _eRR ()
  
  and _menhir_run_38_spec_36 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a1 = _v in
      let _v = _menhir_action_06 a1 in
      _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState36 _tok
  
  and _menhir_run_32 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ID _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let adr = _v in
          let _v = _menhir_action_09 adr in
          _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_37 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_e (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_29 x xs in
      _menhir_goto_list_e_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_list_e_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState36 ->
          _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState31 ->
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_34 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_CALL _menhir_cell0_ID -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell0_ID (_menhir_stack, n) = _menhir_stack in
      let MenhirCell1_CALL (_menhir_stack, _menhir_s) = _menhir_stack in
      let lp = _v in
      let _v = _menhir_action_04 lp n in
      _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_38_spec_31 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_CALL _menhir_cell0_ID -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a1 = _v in
      let _v = _menhir_action_06 a1 in
      _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState31 _tok
  
  and _menhir_run_38_spec_79 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_typ _menhir_cell0_ID -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a1 = _v in
      let _v = _menhir_action_06 a1 in
      _menhir_run_80 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_38_spec_67 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_IF -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a1 = _v in
      let _v = _menhir_action_06 a1 in
      _menhir_run_68 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState67 _tok
  
  and _menhir_run_38_spec_64 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_PRINT -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a1 = _v in
      let _v = _menhir_action_06 a1 in
      _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_38_spec_61 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_RETURN -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a1 = _v in
      let _v = _menhir_action_06 a1 in
      _menhir_run_62 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_38_spec_15 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_WHILE -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a1 = _v in
      let _v = _menhir_action_06 a1 in
      _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState15 _tok
  
  and _menhir_run_38_spec_17 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_PO -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a1 = _v in
      let _v = _menhir_action_06 a1 in
      _menhir_run_45 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState17 _tok
  
  and _menhir_run_38_spec_56 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a1 = _v in
      let _v = _menhir_action_06 a1 in
      _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_38_spec_53 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a1 = _v in
      let _v = _menhir_action_06 a1 in
      _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_38_spec_50 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a1 = _v in
      let _v = _menhir_action_06 a1 in
      _menhir_run_51 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_38_spec_46 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a1 = _v in
      let _v = _menhir_action_06 a1 in
      _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_38_spec_18 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_NUM -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a1 = _v in
      let _v = _menhir_action_06 a1 in
      _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_38_spec_40 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_CO, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a1 = _v in
      let _v = _menhir_action_06 a1 in
      _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_64 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PRINT (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_10 () in
          _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | PO ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
      | NUM ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
      | NULL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_08 () in
          _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | NEW ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
      | MULT ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
      | ID _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_01 n in
          _menhir_run_38_spec_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | FALSE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_11 () in
          _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | ENTIER _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let e = _v in
          let _v = _menhir_action_12 e in
          _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | DENOM ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
      | CO ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
      | CALL ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
      | AD ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
      | _ ->
          _eRR ()
  
  and _menhir_run_67 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IF (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_10 () in
          _menhir_run_68 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState67 _tok
      | PO ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState67
      | NUM ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState67
      | NULL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_08 () in
          _menhir_run_68 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState67 _tok
      | NEW ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState67
      | MULT ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState67
      | ID _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_01 n in
          _menhir_run_38_spec_67 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | FALSE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_11 () in
          _menhir_run_68 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState67 _tok
      | ENTIER _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let e = _v in
          let _v = _menhir_action_12 e in
          _menhir_run_68 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState67 _tok
      | DENOM ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState67
      | CO ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState67
      | CALL ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState67
      | AD ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState67
      | _ ->
          _eRR ()
  
  and _menhir_run_72 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ID _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | EQUAL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | ENTIER _v_0 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | PV ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      let (n, e) = (_v, _v_0) in
                      let _v = _menhir_action_23 e n in
                      _menhir_goto_i _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_82 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_AO -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_AO (_menhir_stack, _menhir_s) = _menhir_stack in
      let li = _v in
      let _v = _menhir_action_03 li in
      _menhir_goto_bloc _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_bloc : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState95 ->
          _menhir_run_96 _menhir_stack _v _tok
      | MenhirState13 ->
          _menhir_run_90 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState70 ->
          _menhir_run_71 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState68 ->
          _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState59 ->
          _menhir_run_60 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_90 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_typ _menhir_cell0_ID, _menhir_box_main) _menhir_cell1_list_param_ -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_list_param_ (_menhir_stack, _, lp) = _menhir_stack in
      let MenhirCell0_ID (_menhir_stack, n) = _menhir_stack in
      let MenhirCell1_typ (_menhir_stack, _menhir_s, t) = _menhir_stack in
      let li = _v in
      let _v = _menhir_action_20 li lp n t in
      let _menhir_stack = MenhirCell1_fonc (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | RAT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_41 () in
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState97 _tok
      | INT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_40 () in
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState97 _tok
      | BOOL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_39 () in
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState97 _tok
      | ID _ ->
          let _v = _menhir_action_30 () in
          _menhir_run_98 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_98 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_fonc -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_fonc (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_31 x xs in
      _menhir_goto_list_fonc_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_list_fonc_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState97 ->
          _menhir_run_98 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState00 ->
          _menhir_run_94 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_94 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_list_fonc_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | ID _v_0 ->
          let _menhir_stack = MenhirCell0_ID (_menhir_stack, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | AO ->
              _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState95
          | _ ->
              _eRR ())
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_71 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_IF, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_cell1_bloc -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_bloc (_menhir_stack, _, li1) = _menhir_stack in
      let MenhirCell1_e (_menhir_stack, _, exp) = _menhir_stack in
      let MenhirCell1_IF (_menhir_stack, _menhir_s) = _menhir_stack in
      let li2 = _v in
      let _v = _menhir_action_25 exp li1 li2 in
      _menhir_goto_i _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_69 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_IF, _menhir_box_main) _menhir_cell1_e as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_bloc (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | ELSE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | AO ->
              _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState70
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_60 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_WHILE, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_e (_menhir_stack, _, exp) = _menhir_stack in
      let MenhirCell1_WHILE (_menhir_stack, _menhir_s) = _menhir_stack in
      let li = _v in
      let _v = _menhir_action_26 exp li in
      _menhir_goto_i _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_85 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_i -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_i (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_33 x xs in
      _menhir_goto_list_i_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_list_i_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState84 ->
          _menhir_run_85 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState14 ->
          _menhir_run_82 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_08 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | MULT ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ID _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (t, n) = (_v, _v_0) in
          let _v = _menhir_action_37 n t in
          let _menhir_stack = MenhirCell1_param (_menhir_stack, _menhir_s, _v) in
          (match (_tok : MenhirBasics.token) with
          | RAT ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_41 () in
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState10 _tok
          | INT ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_40 () in
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState10 _tok
          | BOOL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_39 () in
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState10 _tok
          | PF ->
              let _v = _menhir_action_34 () in
              _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_11 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_param -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_param (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_35 x xs in
      _menhir_goto_list_param_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_list_param_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState07 ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState10 ->
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_12 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_typ _menhir_cell0_ID as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_list_param_ (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | AO ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState13
      | _ ->
          _eRR ()
  
  let rec _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | RAT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_41 () in
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00 _tok
      | INT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_40 () in
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00 _tok
      | BOOL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_39 () in
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00 _tok
      | ID _ ->
          let _v = _menhir_action_30 () in
          _menhir_run_94 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00 _tok
      | _ ->
          _eRR ()
  
end

let main =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_main v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
