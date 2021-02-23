parser grammar BNFParser;

options { tokenVocab = BNFLexer; }

/*
 * Parser Rules
 */

compileUnit
	:	declarations SEPARATOR rule+ SEPARATOR definitions
	;

rule : SYMBOL DERIVESOP alternatives  SEMI
	 ;

alternatives : derivation ( OR derivation? )*
			 | ( OR derivation? )+ 
			 ;

derivation : (CHARACTERLITERAL | SYMBOL)+ 
		   ;

declarations : ( switch | (IGNORE_DECL | DECL_SPACE ) )*
			   ;

switch :     token_switch
		   | start_switch
		   | left_switch
           | right_switch
		   ;

token_switch : PERC TOKEN SYMBOL*
			   ;

start_switch : PERC START SYMBOL
			   ;

left_switch : PERC LEFT SYMBOL*
			  ;

right_switch : PERC RIGHT SYMBOL*
			  ;

definitions : IGNORE_DEF
			  ;