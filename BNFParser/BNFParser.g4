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

declarations : (IGNORE_DECL | DECL_SPACE )*			   
			   ;

definitions : IGNORE_DEF
			  ;