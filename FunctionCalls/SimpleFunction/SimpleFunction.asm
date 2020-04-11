
// function SimpleFunction.test 2
(SimpleFunction.test)
@i0
M=0
(LOOP0)
@i0       // push 0 * numlocals
D=M
@2
D=D-A
@END0
D;JGE
@LCL
D=M
@i0
A=D+M
M=0
@i0
M=M+1
@SP
M=M+1
@LOOP0
0;JMP
(END0)
// push local 0
@LCL
D=M
@0
D=D+A
@addr1
M=D
@addr1
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
// push local 1
@LCL
D=M
@1
D=D+A
@addr2
M=D
@addr2
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
// add
@SP
M=M-1
@SP
A=M
D=M
@SP
M=M-1
@SP
A=M
M=D+M
@SP
M=M+1
// not
@SP
M=M-1
@SP
A=M
M=!M
@SP
M=M+1
// push argument 0
@ARG
D=M
@0
D=D+A
@addr3
M=D
@addr3
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
// add
@SP
M=M-1
@SP
A=M
D=M
@SP
M=M-1
@SP
A=M
M=D+M
@SP
M=M+1
// push argument 1
@ARG
D=M
@1
D=D+A
@addr4
M=D
@addr4
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
// sub
@SP
M=M-1
@SP
A=M
D=M
@SP
M=M-1
@SP
A=M
M=M-D
@SP
M=M+1
// return
@LCL            //endframe = LCL
D=A
@endFrame5
M=D
@endFrame5    // retAddr = *(endFrame - 5)
A=M
D=M
@5
D=D-A
@retAddr5
M=D
@SP             // *ARG = POP
M=M-1
@SP
A=M
D=M
@ARG
A=M
M=D
@ARG            // SP = ARG + 1
D=M+1
@SP
M=D
@endFrame5    // THAT = *(endFrame - 1)
A=M
A=M-1
D=M
@THAT
M=D
@endFrame5    // THIS = *(endFrame - 2)
A=M
D=M
@2
A=D-A
D=M
@THIS
M=D
@endFrame5    // ARG = *(endFrame - 3)
A=M
D=M
@3
A=D-A
D=M
@ARG
M=D
@endFrame5    // LCL = *(endFrame - 4)
A=M
D=M
@4
A=D-A
D=M
@LCL
M=D
@retAddr5     // goto retAddr
A=M
0;JMP