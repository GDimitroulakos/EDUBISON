lexer grammar BNFLexer;

@header {	using System;
			using System.IO; }

/*
 * Lexer Rules
 */
SEPARATOR : '%%' { Mode(BNFLexer.DEFINITIONS); };
DERIVESOP : ':' ;
OR : '|' ;
SEMI : ';' ; 
CHARACTERLITERAL : '\'' ~[ \r\n\t] '\'' ; 
SYMBOL : [a-zA-Z][a-zA-Z0-9_]* ;
WS	:	[ \r\n\t] -> skip
	;

mode DECLARATIONS;
DECLSTOP : '%%' {
					Mode(BNFLexer.DefaultMode);				    
					Type = BNFLexer.SEPARATOR;					
				} 
		   ;
IGNORE_DECL : .  ;
DECL_SPACE :[ \r\n\t]+ ->skip
			 ;

		   

mode DEFINITIONS;
IGNORE_DEF :  .  ;
DEF_SPACE: [ \r\n\t]+ ->skip
			 ;