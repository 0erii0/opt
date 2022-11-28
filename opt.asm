DATA SEGMENT
    S1    DB "VLADIMIR"
    S2    DB "ILYICH"
    S3    DB "ULYANOVI"
DATA ENDS

STACK SEGMENT
    DB 16 DUP(?)
STACK ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA,SS:STACK
    START:
;清屏
        MOV AX,0B800H     ;屏幕起始地址
        MOV ES,AX
        MOV CX,80*50      ;屏幕尺寸
        MOV SI,0
    CLR:
        MOV AX,0
        MOV ES:[SI],AX    ;清屏
        INC SI
        LOOP CLR

        MOV AX,DATA
        MOV DS,AX

        MOV BX,0          ;BX控制字符串数据起始位置
        MOV AX,0B800H
        MOV ES,AX         ;ES控制打印屏幕
;第一行      
        MOV SI,0          ;SI控制打印在屏幕上的位置
        ADD SI,2* 36      ;列数*2
        ADD SI,160* 7     ;行数*160  
        MOV CX, 8         ;字符串长度(loop计数器)
        MOV AH, 41H        ;0 100 0 001 B 红底兰字
    CIR1:   
        MOV AL,DS:[BX]    ;读内存数据
        MOV ES:[SI],AX
        INC BX            ;字符数据移动
        ADD SI,2          ;一个字符打印在屏幕上占两个字节
        LOOP CIR1
;第二行
        MOV SI,0          ;SI控制打印在屏幕上的位置
        ADD SI,2*37       ;列数*2
        ADD SI,160*8      ;行数*160  
        MOV CX,6          ;字符串长度(loop计数器)
        MOV AH,0C2H       ;1 100 0 010 B 红底绿字闪烁
    CIR2:   
        MOV AL,DS:[BX]    ;读内存数据
        MOV ES:[SI],AX
        INC BX            ;字符数据移动
        ADD SI,2          ;一个字符打印在屏幕上占两个字节
        LOOP CIR2
;第三行
        MOV SI,0          ;SI控制打印在屏幕上的位置
        ADD SI,2*36       ;列数*2
        ADD SI,160*9      ;行数*160                              
        MOV CX,8          ;字符串长度(loop计数器)
        MOV AH,21H        ;0 010 0 001 B 绿底兰字
    CIR3:   
        MOV AL,DS:[BX]    ;读内存数据
        MOV ES:[SI],AX
        INC BX            ;字符数据移动
        ADD SI,2          ;一个字符打印在屏幕上占两个字节
        LOOP CIR3

    EXIT: 
        MOV AH,4CH
        INT 21H
CODE ENDS
END START