
// push constant 10
@10
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop local 0
@LCL
D=M
@0
D=D+A
@addr0
M=D
@SP
M=M-1
@SP
A=M
D=M
@addr0
A=M
M=D
// push constant 21
@21
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 22
@22
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop argument 2
@ARG
D=M
@2
D=D+A
@addr1
M=D
@SP
M=M-1
@SP
A=M
D=M
@addr1
A=M
M=D
// pop argument 1
@ARG
D=M
@1
D=D+A
@addr2
M=D
@SP
M=M-1
@SP
A=M
D=M
@addr2
A=M
M=D
// push constant 36
@36
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop this 6
@THIS
D=M
@6
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
// push constant 42
@42
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 45
@45
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop that 5
@THAT
D=M
@5
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
// pop that 2
@THAT
D=M
@2
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
// push constant 510
@510
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop temp 6
@SP
M=M-1
@SP
A=M
D=M
@11
A=M
M=D
// push local 0
@LCL
D=M
@0
D=D+A
@addr6
M=D
@addr6
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
// push that 5
@THAT
D=M
@5
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
// push this 6
@THIS
D=M
@6
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
// push this 6
@THIS
D=M
@6
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
// push temp 6
@11
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