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
                       

###################### REVERSE EACH WORD IN A STRING ######################


; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

ASSUME CS:CODE,DS:DATA

CODE SEGMENT
    XOR CX,CX
    LEA BP,STR3
    LEA SI,STR1
    LEA DI,STR2
    CLD
    L1:
       MOVSB
       INC CX
       CMP [DI-1],' '
       JE REVERSE
       CMP [DI-1],'$' 
       JZ EXIT
       JMP L1
       
    REVERSE:
       PUSH SI
       MOV SI,DI
       SUB SI,1
       MOV DI,BP
       STD
       MOVE:
         MOVSB 
         ADD DI,2  
         MOV BP,DI
         LOOP MOVE
       POP SI     
       LEA DI,STR2
       XOR CX,CX 
       CLD
       JMP L1
       
    EXIT:
    
    LEA SI,STR3+1
    LEA DI,STR3
    CLD
    MOV CX,L
    REPE MOVSB
    HLT
       
    


STR1 DB 'THIS IS A TEST $' 
STR2 DB 'DUPLICATE STRING HERE'
STR3 DB 'REVERSE STRING HERE GOES'
L DW 14


################################## CHECKING DIAGONAL OR NOT FOR SQUARE MATRIX #########################
CODE SEGMENT
ASSUME CS:CODE,DS:CODE  

MOV AX,DIM     
MUL DIM
MOV ELEMENT,AX
DEC AX  
ADD AX,AX
MOV COUNT,AX 
MOV BX,COUNT 

MOV CX,ELEMENT
INC CX           

MOV DX,DIM
ADD DX,1
ADD DX,DX
MOV VAR,DX 

CHECKING:
DEC CX ;just to get out of the loop
JZ NEXT
MOV AX,W[BX]
PUSH AX
SHR AX,15 ;checking the MSB for negative inputs
AND AX,1
JNZ CHANGE ;changing to positive numbers
SUB BX,2
JMP CHECKING
CHANGE:
POP AX
NOT AX
ADD AX,1
MOV W[BX],AX
SUB BX,2
JMP CHECKING

NEXT:
  MOV BX,COUNT
  MOV SI,0H 
  
  MOV CX,DIM
  L1:
   MOV AX,W[BX] 
   MOV B[SI],AX
   MOV W[BX],0H 
   SUB BX,VAR
   ADD SI,2
   LOOP L1
   
   MOV BX,COUNT
   MOV SI,0H   
   
   FINDSUM:
   MOV CX,DIM
   DEC CX
   
   MOV AX,W[BX]
   L2:
   ADD AX,W[BX-2]
   SUB BX,2
   LOOP L2
     
   MOV C[SI],AX 
   ADD SI,2     
   CMP BX,0 
   JZ LASTCHECK 
   SUB BX,2
   JMP FINDSUM
   
   LASTCHECK:
   
        XOR SI,SI
        XOR DI,DI
        
        MOV CX,DIM
        L3:    
          MOV AX,B[SI]
          CMP AX,C[SI]
          JL NOT_DIA
          ADD SI,2
          LOOP L3
        
        MOV AX,1
        HLT 
   NOT_DIA:
     XOR AX,AX
     HLT  

W DW 6,4,0
DW 1,-5,2
DW 1,-5,8  

B DW 0,0,0     ;ADD DIMENSION NUMBERS OF ZEROS 
C DW 0,0,0
  
COUNT DW ?
ELEMENT DW ? 
VAR DW ?

DIM DW 3 ;dimension

END

#########################CHECKING IF A PRIME NUMBER#############################
CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
    
    MOV AX,NUMBER
    PUSH AX
    XOR DX,DX
    MOV BX,2
    DIV BX
    MOV CX,AX
    
    POP AX
    
    CHECK:    
      CMP CX,1
      JE PRIME 
      PUSH AX
      XOR DX,DX
      MOV BX,CX
      DIV BX
      CMP DX,0
      JE NOTPRIME
      
      POP AX
      LOOP CHECK
      
    NOTPRIME:
     MOV CX,0
     HLT
    PRIME:
    MOV CX,1
    HLT
    
  
NUMBER DW 17


############################ SUM OF NTH FIBONACCI NUMBERS ###########################################
CODE SEGMENT
    ASSUME CS:CODE, DS:CODE      
    MOV CX,COUNT 
    SUB CX,2
    
    XOR AX,AX
    XOR SI,SI
    
    CALL MY_FIBONACCI
    
    MY_FIBONACCI PROC      
        
        MOV AX,FIB_NUMBERS[SI]
        ADD AX,FIB_NUMBERS[SI+2]
        MOV FIB_NUMBERS[SI+4],AX
        ADD SI,2
        DEC CX
        JZ NEXT
        CALL MY_FIBONACCI
         
    MY_FIBONACCI ENDP
    
    NEXT:
    MOV CX,COUNT 
    XOR SI,SI
    
    
    SUMM:              
      MOV AX,FIB_NUMBERS[SI]
      ADD SUM,AX
      ADD SI,2
      LOOP SUMM
HLT
    
    

    
CODE ENDS

SUM DW 0 
COUNT DW 12   ;N = 12
FIB_NUMBERS DW 0,1,10 DUP(0)   
END


#################### REPEATATION OF A SUBSTRING IN A MAIN STRING ##########################

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
    
    XOR DX,DX
  
    LEA DI,STR2             
    MOV BX,15D
    CLD
    AGAIN:  
    DEC BX     
    CMP [DI],'$'
    JE EXIT
    MOV CX,4
    LEA SI,STR1
    
    REP CMPSB 
    CMP CX,0H
    JE MATCHED
    JMP AGAIN
    
    MATCHED:
    INC DX
    JMP AGAIN 
    
    EXIT:
    HLT
 
    
    STR1 DB 'eee'
    STR2 DB 'dfeeehgeeehjoee $'



testinggggggggggggggggggggggggggggggggggggggggggggg
CODE SEGMENT 
    ASSUME CS:CODE,DS:DATA
    
  MOV CL,POINT
  MOV BL,LENGTH1
  LEA DI,STR1+4
  LEA SI,STR1+3
  CLD        
  
  MOV AL,LENGTH1
  SUB AL,POINT 
  MOV DX,AL
  
  REPEAT:
  
     MOVSB
     ADD DI,2 
     DEC BL
     JZ NEXT
     JMP REPEAT 
  NEXT:
     HLT
  
  
               
  LENGTH2 DB 3 
  LENGTH1 DB 4
  POINT DB 1
  STR2 DB 'ROG'
  STR1 DB 'PGAM'
  
