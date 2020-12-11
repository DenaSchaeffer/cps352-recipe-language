# Team Project #

![logo](https://trello-attachments.s3.amazonaws.com/5fd2f0e0a869473863e42f5d/500x500/aef05f83a3734cf1d955147dcfe10cba/cooking.png)

University of Dayton 

Department of Computer Science

CPS 352 - Concepts and Implementation of Programming Languages, Fall 2020

Instructor: Dr. Phu Phung

### Private Repository for CPS 352 - Fall 2020 ###

# Team Members

1. Dena Schaeffer, <backd1@udayton.edu>
2. Quan Nguyen, <nguyenq2@udayton.edu>

### What is this repository for? ###
- This repo stores the information and code for the CPS352 final project.

# Language Design
## The language: Syntax and Semantics
```{bnf}
<rice>          ::= <ingredient>
<ingredient> 	::= <grams>
		        ::= <name>
		        ::= (<action> <ingredient> <ingredient>)
		        ::= cook {<name> using <ingredient>}^+(&) with <ingredient>
		        ::= taste <ingredient> yummy <ingredient> bummy <ingredient>
		        ::= recipe {<name>}^+(&) mix <ingredient> stop
				::= prepare <name> contains {<ingredient>}^+(&) stop
; fry + | cut - | combine * | split / | more > | less < | ferment ^ 
<action>        ::= "fry" | "cut" | "combine" | "split" | "more" | "less" | "ferment"  
<grams>         ::= [sign]<digit> | [sign]<digit>.<digit>
<sign>			::= + | -
<digit>        	::= [0-9]+
<name>          ::= [A-Za-z][A-Za-z0-9]*
```
## Language Description
The following explains the correlations between the language we developed and the basic syntax. We wanted to mimic our language like a recipe book, where variables act as ingredients and functions act as what you do with the ingredients.

* Rice = program
* Ingredient = expression
* Grams = a number
* Name = identifier that begins with a letter and can be followed by letters or numbers
* Action = operator (+, -, *, ^, /, >, <)
* Cook, using, and with are similar to the let expression for local binding. 
* Taste, yummy, and bummy is used for conditional evaluation (if, then, else respectively)
* Recipe acts as a function
* Prepare is used to call a recipe (function)
* Number = integer 

## Programming in your language
### Simple program
1. `(cut 1 (fry -2 3.5))`
2. `cook fish using 20 & egg using 5 with (fry fish egg)`
3. `taste 1 yummy 5 bummy 0`

### Program with function definition

```
    cook soup using recipe a & b 
         mix (fry a b) stop 
         with prepare soup contains 1 & 2 stop
```

# Language Implementation and Evaluation
## Language Implementation

Our language design was implemented through the interpretation method. The Scheme code from Lab 4 was used as a guide for this part of our final project. We went through the following steps to implement our language:

1. Revised the-grammer in sllgen-grammar.rkt to include the new syntax and semantics. This includes the inclusion of an assignement function, conditional statement, function definition, and function call. We also defined the grammar for add, subtract, multiply, divide, less-than, more-than, and power functions.
```
(define the-grammar
  '((program (myexpression) a-program)
    (myexpression (number) lit-exp)
    (myexpression (identifier) id-exp)   
    (myexpression
      ("(" primitive myexpression myexpression ")")
      primapp-exp)
    (myexpression
     ("cook" (separated-list identifier "using" myexpression "&")
            "with" myexpression)
     let-exp)
    (myexpression
     ("taste" myexpression "yummy" myexpression "bummy" myexpression)
     if-exp)
    (myexpression
     ("recipe" (separated-list identifier "&") "mix" myexpression "stop")
     function-def-exp)
    (myexpression
     ("prepare" myexpression "contains" (separated-list myexpression "&") "stop")
     function-call-exp)
    (primitive ("fry")              add-prim)
    (primitive ("cut")         subtract-prim)
    (primitive ("combine")     multiply-prim)
    (primitive ("split")         divide-prim)
    (primitive ("less")            less-prim)
    (primitive ("more")            more-prim)
    (primitive ("ferment")        power-prim)
   )
)
```
2. Revised eval-primapp in myinterpreter.rkt to include implementation of the functions with primitives (add, subtract, multiply, divide, less-than, more-than, power).
```
(define eval-primapp
  (lambda (prim expr1 expr2 env)
    (cases primitive prim
      (add-prim ()
                (+ (eval-expression expr1 env) (eval-expression expr2 env))
                )
      (subtract-prim ()
                     (- (eval-expression expr1 env) (eval-expression expr2 env))
                     )
      (multiply-prim ()
                     (* (eval-expression expr1 env) (eval-expression expr2 env)))
      (divide-prim ()
                   (/ (eval-expression expr1 env) (eval-expression expr2 env)))
      (more-prim ()
                 (> (eval-expression expr1 env) (eval-expression expr2 env))
                 )
      (less-prim ()
                 (< (eval-expression expr1 env) (eval-expression expr2 env))
                 )
      (power-prim ()
                  (expt (eval-expression expr1 env) (eval-expression expr2 env))
                  )
      (else (eopl:error 'eval-expression "Unknown primitive: ~s" prim))
      )
    )
  )
```
3. Implemented error handling to catch invalid sentences. 
```
      ... (eopl:error 'eval-expression "Cannot execute a non-function: ~s\n" func-exp)))
      ... (else (eopl:error 'eval-expression "Unknown primitive: ~s" prim))
      ... (eopl:error 'value-of "No binding for ~s" sym))

                             
```
## Evaluation

### Three simple programs
![one](https://i.gyazo.com/ac0a51c9b3ec79cdcf565afba1ba7453.png)

![two](https://i.gyazo.com/59c121f444dd47ec6c8467f57aca1169.png)

![three](https://i.gyazo.com/8c93a0c7a503ff32f1fd70364a871252.png)

### Additional Examples

#### Fry
![fry](https://trello-attachments.s3.amazonaws.com/5fd2f23f77e1a36d935ad78b/850x134/7b60eb10036a0765e41a523f1f4267bd/6f569903fc3ffe219fe6216cab0a70b5.png)

#### Cut
![cut](https://trello-attachments.s3.amazonaws.com/5fd2f2b572bd59626428a46a/840x185/0b4482c2ec775092d0375a9fb6b1fe85/image.png)

#### Combine
![combine](https://trello-attachments.s3.amazonaws.com/5fd2f2df65cc6906cf58b064/856x183/8dae3fa833da56edc65e4368c0b5997e/image.png)

#### Split
![split](https://trello-attachments.s3.amazonaws.com/5fd2f320f673b1241bd334f6/856x182/d569e84cd024e00c89e3d4d145ef8900/image.png)

#### More
![more](https://trello-attachments.s3.amazonaws.com/5fd2f37deaeead07c0595273/872x175/bfb179738618c42e13d5f256ea18ca31/image.png)

#### Less
![less](https://trello-attachments.s3.amazonaws.com/5fd2f3bf080dc4567afc90ea/976x211/f52376d2ccec950536c3b15cc1e5b7d3/image.png)

#### Ferment
![ferment](https://trello-attachments.s3.amazonaws.com/5fd2f3ff8a52a887ec03559b/862x189/e470eea675aa7eee86ecc526b3955a57/image.png)

#### Cook
![cook](https://i.gyazo.com/59c121f444dd47ec6c8467f57aca1169.png)

#### Taste Test
![taste](https://trello-attachments.s3.amazonaws.com/5fd2f4d83982fd7c5dd95e23/869x180/c74adca2ee4f7ccf93d0c526e5303bd7/image.png)

#### Recipe
![recipe](https://i.gyazo.com/4b5594039e7ad012962c7acb6b730237.png)

#### Prepare
![prepare](https://i.gyazo.com/0cf06f0136cebeaf01382c494c6dd343.png)

### Program with Function Definition & Application:
![defapp](https://i.gyazo.com/6406488e8640ec8a60fce5ce61499d17.png)

### Invalid Syntax Examples

#### 1
![first](https://i.gyazo.com/613601d131ac802edfdf58e68ad8d89d.png)

#### 2
![second](https://i.gyazo.com/811e32e120b7e5236552a8125ff8fa8c.png)

#### 3
![third](https://i.gyazo.com/0451c9bf7d64c494d3f31af3401668e4.png)