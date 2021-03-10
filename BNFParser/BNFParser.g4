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
		   |  code_switch
		   ;

token_switch : PERC token_switch_ID SYMBOL+
			   ;

code_switch : PERC CODE codequalifier OB CODE_FRAGMENT  CB	#CodeSwitchQualifier
			 | OPENCODEDEL  CODE_FRAGMENT  CLOSECODEDEL		#CodeSwitch
			 | OPENCODEDEL  CLOSECODEDEL					#CodeSwitchEmpty
			 ;

// CODE_FRAGMENT : it is a fragment of text representing code in the host language which ultimately 
// ignored. The code fragment start with the '{' and ends with the '}'. Since these characters
// may exist in the fragment it is necessary to determine which one '}' end the code fragment
// We may assume the '{' '}' are perfectly nested which means that the ending '}' brace of 
// the fragment can be determined by the detection of the balanced '{' and '}' in the code 
// fragment. It is a correct assumption since the code in the fragment must valid code in the
// host language which enforces this rule to apply.


codequalifier : REQUIRES
				| PROVIDES
				| TOP
				| IMPORT
				;

token_switch_ID : TOKEN
				| LEFT
				| RIGHT
				| NONASSOC
				| START
				| PREC
				;

definitions : IGNORE_DEF
			  ;