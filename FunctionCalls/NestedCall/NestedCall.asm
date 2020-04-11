
// function Sys.init 0
(Sys.init)
@R13
M=0
(Sys.init$LOOP.0)
@R13       // push 0 * numlocals
D=M
@0
D=D-A
@Sys.init$END.0
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
@Sys.init$LOOP.0
0;JMP
(Sys.init$END.0)
// push constant 4000
@4000
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 0
@SP
M=M-1
@SP
A=M
D=M
@THIS
M=D
// push constant 5000
@5000
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 1
@SP
M=M-1
@SP
A=M
D=M
@THAT
M=D
// call Sys.main 0
@Sys.main.retaddr1 // push returnAddress
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
@Sys.main        // goto Sys.main transfers control to the called function
0;JMP
(Sys.main.retaddr1)  // declares a label for the return address
// pop temp 1
@SP
M=M-1
@SP
A=M
D=M
@6
M=D
// label LOOP
(Sys.init$LOOP)
//goto LOOP
@Sys.init$LOOP
0;JMP
// function Sys.main 5
(Sys.main)
@R13
M=0
(Sys.main$LOOP.2)
@R13       // push 0 * numlocals
D=M
@5
D=D-A
@Sys.main$END.2
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
@Sys.main$LOOP.2
0;JMP
(Sys.main$END.2)
// push constant 4001
@4001
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 0
@SP
M=M-1
@SP
A=M
D=M
@THIS
M=D
// push constant 5001
@5001
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 1
@SP
M=M-1
@SP
A=M
D=M
@THAT
M=D
// push constant 200
@200
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop local 1
@LCL
D=M
@1
D=D+A
@addr3
M=D
@SP
M=M-1
@SP
A=M
D=M
@addr3
A=M
M=D
// push constant 40
@40
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop local 2
@LCL
D=M
@2
D=D+A
@addr4
M=D
@SP
M=M-1
@SP
A=M
D=M
@addr4
A=M
M=D
// push constant 6
@6
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop local 3
@LCL
D=M
@3
D=D+A
@addr5
M=D
@SP
M=M-1
@SP
A=M
D=M
@addr5
A=M
M=D
// push constant 123
@123
D=A
@SP
A=M
M=D
@SP
M=M+1
// call Sys.add12 1
@Sys.add12.retaddr6 // push returnAddress
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
@Sys.add12        // goto Sys.add12 transfers control to the called function
0;JMP
(Sys.add12.retaddr6)  // declares a label for the return address
// pop temp 0
@SP
M=M-1
@SP
A=M
D=M
@5
M=D
// push local 0
@LCL
D=M
@0
D=D+A
@addr7
M=D
@addr7
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
@addr8
M=D
@addr8
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
// push local 2
@LCL
D=M
@2
D=D+A
@addr9
M=D
@addr9
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
// push local 3
@LCL
D=M
@3
D=D+A
@addr10
M=D
@addr10
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
// push local 4
@LCL
D=M
@4
D=D+A
@addr11
M=D
@addr11
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
@endFrame12
M=D
@endFrame12    // retAddr = *(endFrame - 5)
D=M
@5
A=D-A
D=M
@retAddr12
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
@endFrame12    // THAT = *(endFrame - 1)
A=M-1
D=M
@THAT
M=D
@endFrame12    // THIS = *(endFrame - 2)
D=M
@2
A=D-A
D=M
@THIS
M=D
@endFrame12    // ARG = *(endFrame - 3)
D=M
@3
A=D-A
D=M
@ARG
M=D
@endFrame12    // LCL = *(endFrame - 4)
D=M
@4
A=D-A
D=M
@LCL
M=D
@retAddr12     // goto retAddr
A=M
0;JMP
// function Sys.add12 0
(Sys.add12)
@R13
M=0
(Sys.add12$LOOP.13)
@R13       // push 0 * numlocals
D=M
@0
D=D-A
@Sys.add12$END.13
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
@Sys.add12$LOOP.13
0;JMP
(Sys.add12$END.13)
// push constant 4002
@4002
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 0
@SP
M=M-1
@SP
A=M
D=M
@THIS
M=D
// push constant 5002
@5002
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 1
@SP
M=M-1
@SP
A=M
D=M
@THAT
M=D
// push argument 0
@ARG
D=M
@0
D=D+A
@addr14
M=D
@addr14
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
// push constant 12
@12
D=A
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
// return
@LCL            //endframe = LCL
D=M
@endFrame15
M=D
@endFrame15    // retAddr = *(endFrame - 5)
D=M
@5
A=D-A
D=M
@retAddr15
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
@endFrame15    // THAT = *(endFrame - 1)
A=M-1
D=M
@THAT
M=D
@endFrame15    // THIS = *(endFrame - 2)
D=M
@2
A=D-A
D=M
@THIS
M=D
@endFrame15    // ARG = *(endFrame - 3)
D=M
@3
A=D-A
D=M
@ARG
M=D
@endFrame15    // LCL = *(endFrame - 4)
D=M
@4
A=D-A
D=M
@LCL
M=D
@retAddr15     // goto retAddr
A=M
0;JMP