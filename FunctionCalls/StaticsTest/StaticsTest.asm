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
// push constant 6
@6
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 8
@8
D=A
@SP
A=M
M=D
@SP
M=M+1
// call Class1.set 2
@Class1.set$ret.2 // push returnAddress
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
@2
D=D-A
@ARG
M=D
@SP         // LCL = SP
D=M
@LCL
M=D
@Class1.set        // goto Class1.set transfers control to the called function
0;JMP
(Class1.set$ret.2)  // declares a label for the return address
// pop temp 0
@SP
M=M-1
@SP
A=M
D=M
@5
M=D
// push constant 23
@23
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 15
@15
D=A
@SP
A=M
M=D
@SP
M=M+1
// call Class2.set 2
@Class2.set$ret.3 // push returnAddress
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
@2
D=D-A
@ARG
M=D
@SP         // LCL = SP
D=M
@LCL
M=D
@Class2.set        // goto Class2.set transfers control to the called function
0;JMP
(Class2.set$ret.3)  // declares a label for the return address
// pop temp 0
@SP
M=M-1
@SP
A=M
D=M
@5
M=D
// call Class1.get 0
@Class1.get$ret.4 // push returnAddress
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
@Class1.get        // goto Class1.get transfers control to the called function
0;JMP
(Class1.get$ret.4)  // declares a label for the return address
// call Class2.get 0
@Class2.get$ret.5 // push returnAddress
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
@Class2.get        // goto Class2.get transfers control to the called function
0;JMP
(Class2.get$ret.5)  // declares a label for the return address
// label WHILE
(Sys.init$WHILE)
//goto WHILE
@Sys.init$WHILE
0;JMP
// function Class1.set 0
(Class1.set)
@R13
M=0
(Class1.set$LOOP.0)
@R13       // push 0 * numlocals
D=M
@0
D=D-A
@Class1.set$END.0
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
@Class1.set$LOOP.0
0;JMP
(Class1.set$END.0)
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
// pop static 0
@SP
M=M-1
@SP
A=M
D=M
@Class1.0
M=D
// push argument 1
@ARG
D=M
@1
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
// pop static 1
@SP
M=M-1
@SP
A=M
D=M
@Class1.1
M=D
// push constant 0
@0
D=A
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
// function Class1.get 0
(Class1.get)
@R13
M=0
(Class1.get$LOOP.1)
@R13       // push 0 * numlocals
D=M
@0
D=D-A
@Class1.get$END.1
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
@Class1.get$LOOP.1
0;JMP
(Class1.get$END.1)
// push static 0
@Class1.0
D=M
@SP
A=M
M=D
@SP
M=M+1
// push static 1
@Class1.1
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
// function Class2.set 0
(Class2.set)
@R13
M=0
(Class2.set$LOOP.0)
@R13       // push 0 * numlocals
D=M
@0
D=D-A
@Class2.set$END.0
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
@Class2.set$LOOP.0
0;JMP
(Class2.set$END.0)
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
// pop static 0
@SP
M=M-1
@SP
A=M
D=M
@Class2.0
M=D
// push argument 1
@ARG
D=M
@1
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
// pop static 1
@SP
M=M-1
@SP
A=M
D=M
@Class2.1
M=D
// push constant 0
@0
D=A
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
// function Class2.get 0
(Class2.get)
@R13
M=0
(Class2.get$LOOP.1)
@R13       // push 0 * numlocals
D=M
@0
D=D-A
@Class2.get$END.1
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
@Class2.get$LOOP.1
0;JMP
(Class2.get$END.1)
// push static 0
@Class2.0
D=M
@SP
A=M
M=D
@SP
M=M+1
// push static 1
@Class2.1
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