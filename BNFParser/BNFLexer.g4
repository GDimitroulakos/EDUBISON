lexer grammar BNFLexer;

@header {	using System;
			using System.IO; }

@lexer::members{
    public static int bracenesting = 0;
	public static bool lastcodepart = true;
}

/*
 * Lexer Rules
 */
// Default mode refers to the second region of the .y file 
// including the BNF grammar
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
OB   : '{'  {   bracenesting =1;
				lastcodepart = true;
				PushMode(BNFLexer.QUALIFIEDCODEFRAGMENT);	};

OPENCODEDEL : '%{' {  PushMode(BNFLexer.CODEFRAGMENT);  };

REQUIRES : 'requires';
PROVIDES : 'provides';
TOP :'top';
IMPORT : 'import';
TOKEN : 'token';
LEFT : 'left';
RIGHT : 'right';
START : 'start';
PREC : 'prec';
CODE : 'code';
NONASSOC : 'nonassoc';
DECLSYMBOL : [a-zA-Z][a-zA-Z0-9_]* { Type = BNFLexer.SYMBOL ; };
DECL_SPACE :[ \r\n\t]+ ->skip
		  ;

mode QUALIFIEDCODEFRAGMENT;
LB : '{' { bracenesting++; More(); lastcodepart =false; };
CB : '}' { if ( bracenesting == 1 ){		     
			 PopMode();			
		   }
		   else if ( bracenesting == 2 ){
			   lastcodepart =true;
			   More();
		   }
		   else{
			 More();
		   }
			bracenesting--;		   
		 };
QUALIFIED_CODE_FRAGMENT: {!lastcodepart}? ~[{}]+ ->More ;
LAST_CODE_PART : {lastcodepart}? ~[}]+ ->Type(CODE_FRAGMENT);


mode CODEFRAGMENT ;
CLOSECODEDEL : '%}'{ PopMode();   };
CODE_FRAGMENT: (~[%]+|('%'~[}]))+ ;



mode DEFINITIONS;
IGNORE_DEF :  .  ;
DEF_SPACE: [ \r\n\t]+ ->skip
			 ;