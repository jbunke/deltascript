parser grammar ScriptParser;

options {
    tokenVocab=ScriptLexer;
}

head_rule: signature func_body helper*;

helper: ident signature func_body;

func_body: body                             #StandardFuncBody
| ARROW expr                                #FunctionalFuncBody
;

signature
: LPAREN param_list? RPAREN                 #VoidReturnSignature
| LPAREN param_list? ARROW type RPAREN      #TypeReturnSignature
;

param_list: declaration (COMMA declaration)*;

declaration: FINAL? type ident;

type
: BOOL                                      #BoolType
| INT                                       #IntType
| FLOAT                                     #FloatType
| CHAR                                      #CharType
| STRING                                    #StringType
| IMAGE                                     #ImageType
| COLOR                                     #ColorType
| type LBRACKET RBRACKET                    #ArrayType
| type LT GT                                #ListType
| type LCURLY RCURLY                        #SetType
| LCURLY key=type COLON val=type RCURLY     #MapType
| LPAREN func_type RPAREN                   #FunctionType
| ident                                     #ExtensionType
;

func_type: param_types ARROW ret=type;

param_types: (type (COMMA type)*)?;

body
: stat                                      #SingleStatBody
| LCURLY stat* RCURLY                       #ComplexBody
;

stat
: loop_stat                                 #LoopStatement
| if_stat                                   #IfStatement
| when_stat                                 #WhenStatement
| var_def SEMICOLON                         #VarDefStatement
| assignment SEMICOLON                      #AssignmentStatement
| return_stat                               #ReturnStatement
| expr subident args SEMICOLON              #ScopedFuncCallStatement
| ident args SEMICOLON                      #FunctionCallStatement
| namespace args SEMICOLON                  #ExtFuncCallStatement
;

return_stat: RETURN expr? SEMICOLON;

loop_stat
: while_def body                            #WhileLoop
| iteration_def body                        #IteratorLoop
| for_def body                              #ForLoop
| DO body while_def SEMICOLON               #DoWhileLoop
;

iteration_def: FOR LPAREN 
iterator_declaration IN expr RPAREN;

iterator_declaration
: declaration                               #ExplicitDeclaration
| ident                                     #ImplicitDeclaration
;

while_def: WHILE LPAREN expr RPAREN;

for_def: FOR LPAREN var_init SEMICOLON
expr SEMICOLON assignment RPAREN;

if_stat: if_def (ELSE if_def)*
(ELSE elseBody=body)?;

if_def: IF LPAREN cond=expr RPAREN body;

when_stat: WHEN LPAREN 
control=expr RPAREN when_body;

when_body: LCURLY case+ otherwise? RCURLY;

case
: IS expr ARROW body                        #IsCase
| PASSES expr ARROW body                    #PassesCase
;

otherwise: OTHERWISE ARROW body;

expr
: LPAREN expr RPAREN                        #NestedExpression
| lambda_params lambda_body                 #LambdaFunctionExpression
| ident args                                #FunctionCallExpression
| namespace args                            #ExtFuncCallExpression
| namespace                                 #ExtPropertyExpression
| DEF ident                                 #HOFuncExpression
| expr subident args                        #ScopedFuncCallExpression
| expr subident                             #PropertyExpression
| op=(MINUS | NOT | SIZE) expr              #UnaryExpression
| LPAREN type RPAREN expr                   #CastExpression
| a=expr op=(PLUS | MINUS) b=expr           #ArithmeticBinExpression
| a=expr op=(TIMES | DIVIDE | MOD) b=expr   #MultBinExpression
| a=expr RAISE b=expr                       #PowerBinExpression
| a=expr op=(EQUAL | NOT_EQUAL |
  GT | LT | GEQ | LEQ) b=expr               #ComparisonBinExpression
| a=expr op=(OR | AND) b=expr               #LogicBinExpression
| cond=expr QUESTION if=expr
  COLON else=expr                           #TernaryExpression
| LCURLY k_v_pairs RCURLY                   #ExplicitMapExpression
| LBRACKET elements? RBRACKET               #ExplicitArrayExpression
| LT elements? GT                           #ExplicitListExpression
| LCURLY elements? RCURLY                   #ExplicitSetExpression
| NEW type LBRACKET expr RBRACKET           #NewArrayExpression
| NEW LCURLY kt=type COLON vt=type RCURLY   #NewMapExpression
| assignable                                #AssignableExpression
| literal                                   #LiteralExpression
;

lambda_params
: LPAREN RPAREN                             #NoLambdaParams
| ident                                     #OneLambdaParam
| LPAREN ident (COMMA ident)+ RPAREN        #MultLambdaParams
;

lambda_body
: ARROW body                                #StandardLambdaBody
| ARROW expr                                #ExprLambdaBody
;

k_v_pairs: k_v_pair (COMMA k_v_pair)*;

k_v_pair: key=expr COLON val=expr;

args: LPAREN elements? RPAREN;

elements: expr (COMMA expr)*;

assignment
: assignable ASSIGN expr                    #StandardAssignment
| assignable INCREMENT                      #IncrementAssignment
| assignable DECREMENT                      #DecrementAssignment
| assignable ADD_ASSIGN expr                #AddAssignment
| assignable SUB_ASSIGN expr                #SubAssignment
| assignable MUL_ASSIGN expr                #MultAssignment
| assignable DIV_ASSIGN expr                #DivAssignmnet
| assignable MOD_ASSIGN expr                #ModAssignment
| assignable AND_ASSIGN expr                #AndAssignment
| assignable OR_ASSIGN expr                 #OrAssignment
;

var_init: declaration ASSIGN expr;

var_def
: declaration                               #ImplicitVarDef
| var_init                                  #ExplicitVarDef
;

assignable
: ident                                     #SimpleAssignable
| ident LT expr GT                          #ListAssignable
| ident LBRACKET expr RBRACKET              #ArrayAssignable
;

ident: IDENTIFIER;

subident: SUB_IDENT;

namespace: EXTENSION ident subident;

literal
: STRING_LIT                                #StringLiteral
| CHAR_LIT                                  #CharLiteral
| COL_LIT                                   #ColorLiteral
| int_lit                                   #IntLiteral
| FLOAT_LIT                                 #FloatLiteral
| bool_lit                                  #BoolLiteral
;

int_lit: HEX_LIT                            #Hexadecimal
| DEC_LIT                                   #Decimal
;

bool_lit: TRUE                              #True
| FALSE                                     #False
;
