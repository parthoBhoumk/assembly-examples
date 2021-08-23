################################# to show 80 characters in display ###############################
ASSUME CS:CODE, DS:DATA

MOV CX,80D
MOV AH,2
MOV DL,'*'

TOP:
  INT 21H
  LOOP TOP
  
  ################################# WHEN CX = 0 LOOPING SOLUTION ##################################
  
  ASSUME CS:CODE, DS:DATA

MOV CX,0
MOV AH,2
MOV DL,'*'  

JCXZ LAST     ;this is the solution 

TOP:
  INT 21H
  LOOP TOP  

LAST: HLT

############################## COUNT CHARACTERS UNTIL A WHITESPACE IS ENTERED##############################
ASSUME CS:CODE, DS:DATA

MOV AH,1  ; PREPARE TO READ
XOR DX,DX ;COUNTING VALUE INPUTED  
DEC DX

REPEAT:
   INT 21H
   INC DX                  
   CMP AL,' ' ; UNTIL HITS A BLANK 
   JNE REPEAT 
   
   
  ######################################## FINDING AVG OF TEST MARKS##################################
  ASSUME CS:CODE, DS:DATA

CODE SEGMENT
    MOV SI,6
    REPEAT:    
        
        MOV CX,5
        XOR BX,BX
        XOR AX,AX
        
    FOR:
        ADD AX,SCORES[BX][SI]
        ADD BX,8
        LOOP FOR
        
    FIND_AVG:
    
        XOR DX,DX  ; CLEAR DX BEFORE 32 BIT DIVISION   
        MOV STUDENTS,5
        DIV STUDENTS 
        MOV AVG[SI],AX
        SUB SI,2 
        JNL REPEAT 
        
    SCORES DW 15,34,43,56
           DW 45,23,24,42
           DW 12,56,45,23
           DW 45,71,51,14 
           DW 23,42,65,34  
           
    AVG DW 4DUP(0)    
    STUDENTS DW ?
    
    
    ############################## HOW TO REVERSE A STRING ####################################
    ASSUME CS:CODE, DS:DATA

CODE SEGMENT
    
LEA SI,STRING1+4
LEA DI,STRING2
STD

MOV CX,5

MOVE:

    MOVSB 
    ADD DI,2   ;DF IS DECREASING SO WE HAVE TO INCREASE THE VALUE  
    LOOP MOVE


STRING1 DB 'HELLO'
STRING2 DB 5DUP(0)

################################ INSERTING A NUMBER INTO AN ARRAY #############3###########################


;ARRAY GIVEN 10 20 40 50 60 ? 
;INSERT 30 BETWEEN 20 AND 40

ASSUME CS:CODE, DS:DATA
                       
                       
CODE SEGMENT 
    LEA DI,ARRAY+0AH
    LEA SI,ARRAY+8H
    STD
    
    MOV CX,3
    REP MOVSW
    MOV [DI],30

ARRAY DW 10,20,40,50,60,?

################################### REPE CMPSB USED TO CHECK FOR PALINDROME ############################


;CHECKING FOR PALINDROME 


ASSUME CS:CODE, DS:DATA

CODE SEGMENT          
    
    LEA SI,STR1+6
    LEA DI,STR2
    STD
    
    MOV CX,7
    
    MOVE:
    
        MOVSB 
        ADD DI,2   ;DF IS DECREASING SO WE HAVE TO INCREASE THE VALUE  
        LOOP MOVE
    
    LEA SI,STR1
    LEA DI,STR2
    CLD
    
    MOV CX,7
    
    REPE CMPSB
    JL LAST
    JG LAST     
    
    MOV AX,1    
    HLT
    
    LAST: 
    MOV AX,0
    HLT

STR1 DB 'REVIVER'
STR2 DB 7DUP(0)                       
                       

