lexer grammar BNFLexer;

@header {	using System;
			using System.IO; }

@lexer::members{
    public static int bracenesting = 0;
}

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
PERC : '%' ;
OB   : '{'  { bracenesting =1;
			  Mode(BNFLexer.CODEFRAGMENT);				    
			};
CB   : '}' ;
OPENCODEDEL : '%{';
CLODECODEDEL : '%}';
REQUIRES : 'requires';
PROVIDES : 'provides';
TOP :'top';
IMPORT : 'import';
TOKEN : 'token';
LEFT : 'left';
RIGHT : 'right';
START : 'start';
PREC : 'prec';
NONASSOC : 'nonassoc';
DECLSYMBOL : [a-zA-Z][a-zA-Z0-9_]* { Type = BNFLexer.SYMBOL ; };
DECL_SPACE :[ \r\n\t]+ ->skip
		  ;

mode CODEFRAGMENT :
~[}] 

mode DEFINITIONS;
IGNORE_DEF :  .  ;
DEF_SPACE: [ \r\n\t]+ ->skip
			 ;