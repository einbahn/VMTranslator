// bootstrap code
@256
D=A
@SP
M=D
// call Sys.init 0
@Sys.init$ret.0 // push returnAddress
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL        // push LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG        // push ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS       // push THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT       // push THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP         // arg = SP - 5 - nArgs
D=M
@5
D=D-A
@0
D=D-A
@ARG
M=D
@SP         // LCL = SP
D=M
@LCL
M=D
@Sys.init        // goto Sys.init transfers control to the called function
0;JMP
(Sys.init$ret.0)  // declares a label for the return address
// function Sys.init 0
(Sys.init)
@R13
M=0
(Sys.init$LOOP.1)
@R13       // push 0 * numlocals
D=M
@0
D=D-A
@Sys.init$END.1
D;JGE
@LCL
D=M
@R13
A=D+M
M=0
@R13
M=M+1
@SP
M=M+1
@Sys.init$LOOP.1
0;JMP
(Sys.init$END.1)
// push constant 4
@4
D=A
@SP
A=M
M=D
@SP
M=M+1
// call Main.fibonacci 1
@Main.fibonacci$ret.2 // push returnAddress
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL        // push LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG        // push ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS       // push THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT       // push THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP         // arg = SP - 5 - nArgs
D=M
@5
D=D-A
@1
D=D-A
@ARG
M=D
@SP         // LCL = SP
D=M
@LCL
M=D
@Main.fibonacci        // goto Main.fibonacci transfers control to the called function
0;JMP
(Main.fibonacci$ret.2)  // declares a label for the return address
// label WHILE
(Sys.init$WHILE)
//goto WHILE
@Sys.init$WHILE
0;JMP
// function Main.fibonacci 0
(Main.fibonacci)
@R13
M=0
(Main.fibonacci$LOOP.0)
@R13       // push 0 * numlocals
D=M
@0
D=D-A
@Main.fibonacci$END.0
D;JGE
@LCL
D=M
@R13
A=D+M
M=0
@R13
M=M+1
@SP
M=M+1
@Main.fibonacci$LOOP.0
0;JMP
(Main.fibonacci$END.0)
// push argument 0
@ARG
D=M
@0
D=D+A
@R13
M=D
@R13
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
// push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1
// lt
@SP
M=M-1
@SP
A=M
D=M
@SP
M=M-1
@SP
A=M
D=M-D
@LT1
D;JLT
@NLT2
0;JMP
(LT1)
@SP
A=M
M=-1
@END3
0;JMP
(NLT2)
@SP
A=M
M=0
(END3)
@SP
M=M+1
//if-goto IF_TRUE
@SP
M=M-1
@SP
A=M
D=M
@Main.fibonacci$IF_TRUE
D;JNE
//goto IF_FALSE
@Main.fibonacci$IF_FALSE
0;JMP
// label IF_TRUE
(Main.fibonacci$IF_TRUE)
// push argument 0
@ARG
D=M
@0
D=D+A
@R13
M=D
@R13
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
// return
@LCL            //endframe = LCL
D=M
@R13
M=D            // retAddr = *(endFrame - 5)
@5
A=D-A
D=M
@R14
M=D
@SP             // *ARG = POP()
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
@R13            // THAT = *(endFrame - 1)
A=M-1
D=M
@THAT
M=D
@R13            // THIS = *(endFrame - 2)
D=M
@2
A=D-A
D=M
@THIS
M=D
@R13            // ARG = *(endFrame - 3)
D=M
@3
A=D-A
D=M
@ARG
M=D
@R13            // LCL = *(endFrame - 4)
D=M
@4
A=D-A
D=M
@LCL
M=D
@R14            // goto retAddr
A=M
0;JMP
// label IF_FALSE
(Main.fibonacci$IF_FALSE)
// push argument 0
@ARG
D=M
@0
D=D+A
@R13
M=D
@R13
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
// push constant 2
@2
D=A
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
// call Main.fibonacci 1
@Main.fibonacci$ret.4 // push returnAddress
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL        // push LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG        // push ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS       // push THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT       // push THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP         // arg = SP - 5 - nArgs
D=M
@5
D=D-A
@1
D=D-A
@ARG
M=D
@SP         // LCL = SP
D=M
@LCL
M=D
@Main.fibonacci        // goto Main.fibonacci transfers control to the called function
0;JMP
(Main.fibonacci$ret.4)  // declares a label for the return address
// push argument 0
@ARG
D=M
@0
D=D+A
@R13
M=D
@R13
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
// push constant 1
@1
D=A
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
// call Main.fibonacci 1
@Main.fibonacci$ret.5 // push returnAddress
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL        // push LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG        // push ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS       // push THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT       // push THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP         // arg = SP - 5 - nArgs
D=M
@5
D=D-A
@1
D=D-A
@ARG
M=D
@SP         // LCL = SP
D=M
@LCL
M=D
@Main.fibonacci        // goto Main.fibonacci transfers control to the called function
0;JMP
(Main.fibonacci$ret.5)  // declares a label for the return address
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
// return
@LCL            //endframe = LCL
D=M
@R13
M=D            // retAddr = *(endFrame - 5)
@5
A=D-A
D=M
@R14
M=D
@SP             // *ARG = POP()
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
@R13            // THAT = *(endFrame - 1)
A=M-1
D=M
@THAT
M=D
@R13            // THIS = *(endFrame - 2)
D=M
@2
A=D-A
D=M
@THIS
M=D
@R13            // ARG = *(endFrame - 3)
D=M
@3
A=D-A
D=M
@ARG
M=D
@R13            // LCL = *(endFrame - 4)
D=M
@4
A=D-A
D=M
@LCL
M=D
@R14            // goto retAddr
A=M
0;JMP