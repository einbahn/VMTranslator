import os
import sys


def trim(docstring):
    if not docstring:
        return ""
    # Convert tabs to spaces (following the normal Python rules)
    # and split into a list of lines:
    lines = docstring.expandtabs().splitlines()
    # Determine minimum indentation (first line doesn't count):
    indent = sys.maxsize
    for line in lines[1:]:
        stripped = line.lstrip()
        if stripped:
            indent = min(indent, len(line) - len(stripped))
    # Remove indentation (first line is special):
    trimmed = [lines[0].strip()]
    if indent < sys.maxsize:
        for line in lines[1:]:
            trimmed.append(line[indent:].rstrip())
    # Strip off trailing and leading blank lines:
    while trimmed and not trimmed[-1]:
        trimmed.pop()
    while trimmed and not trimmed[0]:
        trimmed.pop(0)
    # Return a single string:
    return "\n".join(trimmed)


class Parser(object):
    def __init__(self, inputfile):
        self.file = open(inputfile)
        self.currentCommand = ""
        self.hasMoreCommands = True

    def advance(self):
        try:
            while True:
                self.currentCommand = self.file.readline()
                if self.currentCommand == "":
                    raise EOFError
                if not self.currentCommand.startswith((r"//", "\n")):
                    break
        except EOFError:
            self.hasMoreCommands = False

    def commandtype(self, command):
        if command.startswith("push"):
            return "C_PUSH"
        elif command.startswith("pop"):
            return "C_POP"
        elif command.startswith(
            ("add", "sub", "neg", "eq", "gt", "lt", "and", "or", "not")
        ):
            return "C_ARITHMETIC"
        elif command.startswith("label"):
            return "C_LABEL"
        elif command.startswith("goto"):
            return "C_GOTO"
        elif command.startswith("if-goto"):
            return "C_IF"
        elif command.startswith("call"):
            return "C_CALL"
        elif command.startswith("function"):
            return "C_FUNCTION"
        elif command.startswith("return"):
            return "C_RETURN"

    def arg1(self, commandtype):
        if commandtype == 'C_RETURN':
            raise ValueError
        if commandtype == 'C_ARITHMETIC':
            return self.currentCommand.split(" ")[0].replace("\n", "")
        else:
            return self.currentCommand.split(' ')[1].replace('\n', '')

    def arg2(self, commandtype):
        if commandtype in (
            "C_PUSH",
            "C_POP",
            "C_FUNCTION",
            "C_CALL",
        ):
            return self.currentCommand.split(' ')[2].replace('\n', '')
        else:
            raise ValueError

    def close(self):
        self.file.close()


class CodeWriter(object):
    def __init__(self, outputfile):
        self.file = open(outputfile, "w")
        self.labelcounter = 0
        self.filename = os.path.basename(outputfile).replace(".asm", "")

    def writeArithmetic(self, command):
        if command == "add":
            asm = """
            {}
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
            """
            self.file.writelines(trim(asm).format("\n" + r"// " + command))

        elif command == "sub":
            asm = """
            {}
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
            """
            self.file.writelines(trim(asm).format("\n" + r"// " + command))

        elif command == "neg":
            asm = """
            {}
            @SP
            M=M-1
            @SP
            A=M
            M=-M
            @SP
            M=M+1
            """
            self.file.writelines(trim(asm).format("\n" + r"// " + command))

        elif command == "eq":
            asm = """
            {0}
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
            @EQ{1}
            D;JEQ
            @NEQ{2}
            0;JMP
            (EQ{1})
            @SP
            A=M
            M=-1
            @END{3}
            0;JMP    
            (NEQ{2})
            @SP
            A=M
            M=0
            (END{3})
            @SP
            M=M+1
            """
            labeln = [i for i in range(self.labelcounter, self.labelcounter + 3)]
            self.labelcounter += 3
            self.file.writelines(trim(asm).format("\n" + r"// " + command, *labeln))

        elif command == "gt":
            asm = """
            {0}
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
            @GT{1}
            D;JGT
            @NGT{2}
            0;JMP
            (GT{1})
            @SP
            A=M
            M=-1
            @END{3}
            0;JMP    
            (NGT{2})
            @SP
            A=M
            M=0
            (END{3})
            @SP
            M=M+1
            """
            labeln = [i for i in range(self.labelcounter, self.labelcounter + 3)]
            self.labelcounter += 3
            self.file.writelines(trim(asm).format("\n" + r"// " + command, *labeln))

        elif command == "lt":
            asm = """
            {0}
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
            @LT{1}
            D;JLT
            @NLT{2}
            0;JMP
            (LT{1})
            @SP
            A=M
            M=-1
            @END{3}
            0;JMP    
            (NLT{2})
            @SP
            A=M
            M=0
            (END{3})
            @SP
            M=M+1
            """
            labeln = [i for i in range(self.labelcounter, self.labelcounter + 3)]
            self.labelcounter += 3
            self.file.writelines(trim(asm).format("\n" + r"// " + command, *labeln))

        elif command == "and":
            asm = """
            {}
            @SP
            M=M-1
            @SP
            A=M
            D=M
            @SP
            M=M-1
            @SP
            A=M
            M=D&M
            @SP
            M=M+1
            """
            self.file.writelines(trim(asm).format("\n" + r"// " + command))

        elif command == "or":
            asm = """
            {}
            @SP
            M=M-1
            @SP
            A=M
            D=M
            @SP
            M=M-1
            @SP
            A=M
            MD=D|M
            @SP
            M=M+1
            """
            self.file.writelines(trim(asm).format("\n" + r"// " + command))

        elif command == "not":
            asm = """
            {}
            @SP
            M=M-1
            @SP
            A=M
            M=!M
            @SP
            M=M+1
            """
            self.file.writelines(trim(asm).format("\n" + r"// " + command))

    def close(self):
        self.file.close()

    def writepushpop(self, commandtype, segment, index):
        if commandtype == 'C_PUSH':
            command = 'push'
        else:
            command = 'pop'

        # build command string, same for all segments
        commandstring = "{}// {} {} {}".format("\n", command, segment, index)

        # translate segment into assembly segment name
        if segment == "local":
            segmentName = "LCL"
        elif segment == "argument":
            segmentName = "ARG"
        elif segment == "this":
            segmentName = "THIS"
        elif segment == "that":
            segmentName = "THAT"

        if command == "push":
            if segment == "constant":
                asm = """
                {}
                @{}
                D=A
                @SP
                A=M
                M=D
                @SP
                M=M+1
                """
                self.file.writelines(trim(asm).format(commandstring, index))
            elif segment in ("local", "argument", "this", "that"):
                asm = """
                {0}
                @{1}
                D=M
                @{2}
                D=D+A
                @addr{3}
                M=D
                @addr{3}
                A=M
                D=M
                @SP
                A=M
                M=D
                @SP
                M=M+1
                """
                self.file.writelines(
                    trim(asm).format(
                        commandstring, segmentName, index, self.labelcounter
                    )
                )
                self.labelcounter += 1
            elif segment == "temp":
                segmentName = str(5 + int(index))
                asm = """
                {}
                @{}
                D=M
                @SP
                A=M
                M=D
                @SP
                M=M+1
                """
                self.file.writelines(trim(asm).format(commandstring, segmentName))
            elif segment == "static":
                segmentName = "{}.{}".format(self.filename, index)
                asm = """
                {}
                @{}
                D=M
                @SP
                A=M
                M=D
                @SP
                M=M+1
                """
                self.file.writelines(trim(asm).format(commandstring, segmentName))
            elif segment == "pointer":
                if index == "0":
                    segmentName = "THIS"
                else:
                    segmentName = "THAT"
                asm = """
                {}
                @{}
                D=M
                @SP
                A=M
                M=D
                @SP
                M=M+1
                """
                self.file.writelines(trim(asm).format(commandstring, segmentName))

        elif command == "pop":
            if segment in ("local", "argument", "this", "that"):
                asm = """
                {0}
                @{1}
                D=M
                @{2}
                D=D+A
                @addr{3}
                M=D
                @SP
                M=M-1
                @SP
                A=M
                D=M
                @addr{3}
                A=M
                M=D
                """
                self.file.writelines(
                    trim(asm).format(
                        commandstring, segmentName, index, self.labelcounter
                    )
                )
                self.labelcounter += 1
            elif segment == "temp":
                segmentName = str(5 + int(index))
                asm = """
                {0}
                @SP
                M=M-1
                @SP
                A=M
                D=M
                @{1}
                A=M
                M=D
                """
                self.file.writelines(trim(asm).format(commandstring, segmentName))

            elif segment == "static":
                segmentName = "{}.{}".format(self.filename, index)
                asm = """
                {}
                @SP
                M=M-1
                @SP
                A=M
                D=M
                @{}
                M=D
                """
                self.file.writelines(trim(asm).format(commandstring, segmentName))
            elif segment == "pointer":
                if index == "0":
                    segmentName = "THIS"
                else:
                    segmentName = "THAT"
                asm = """
                {}
                @SP
                M=M-1
                @SP
                A=M
                D=M
                @{}
                M=D
                """
                self.file.writelines(trim(asm).format(commandstring, segmentName))
        
    def writelabel(self, label):
        asm = """
        {0}// label {1}
        ({1})
        """
        self.file.writelines(trim(asm).format('\n', label))
    
    def writegoto(self, label):
        asm = """
        {0}//goto {1}
        @{1}
        0;jmp
        """
        self.file.writelines(trim(asm).format('\n', label))

    def writeif(self, label):
        asm = """
        {0}//if-goto {1}
        @SP
        M=M-1
        @SP
        A=M
        D=M
        @{1}
        D;JNE
        """
        self.file.writelines(trim(asm).format('\n', label))

    def writecall(self, functionname, nargs):
        asm = """
        {3}// call {0} {1}
        ({0}.retaddr{2}) // declare label
        @{0}.retaddr{2} // push returnAddress
        D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
        @LCL        // push LCL
        D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
        @ARG        // push ARG
        D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1 
        @THIS       // push THIS
        D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
        @THAT       // push THAT
        D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
        @SP         // arg = SP - 5 - nArgs
        D=A
        @5
        D=D-A
        @{1}
        D=D-A
        @ARG
        M=D
        @SP         // LCL = SP
        D=A
        @LCL
        M=D
        @{0}        // goto {0} transfers control to the called function
        0;JMP
        ({0}.retaddr{2})  // declares a label for the return address
        """
        self.file.writelines(trim(asm).format(
            functionname,
            nargs,
            self.labelcounter,
            '\n'
            )
        )
        self.labelcounter += 1

    def writefunction(self, functionname, numlocals):
        asm = """{3}// function {0} {1}
        ({0})
        @i{2}
        M=0
        (LOOP{2})
        @i{2}       // push 0 * numlocals
        D=M
        @{1}
        D=D-A
        @END{2}
        D;JGE
        @LCL
        D=M
        @i{2}
        A=D+M
        M=0
        @i{2}
        M=M+1
        @SP
        M=M+1
        @LOOP{2}
        0;JMP
        (END{2})
        """
        self.file.writelines(trim(asm).format(
            functionname,
            numlocals,
            self.labelcounter,
            '\n'
            )
        )
        self.labelcounter += 1

    def writereturn(self):
        asm = """
        {1}// return
        @LCL            //endframe = LCL
        D=A
        @endFrame{0}
        M=D
        @endFrame{0}    // retAddr = *(endFrame - 5)
        A=M
        D=M
        @5
        D=D-A
        @retAddr{0}
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
        @endFrame{0}    // THAT = *(endFrame - 1)
        A=M
        A=M-1
        D=M
        @THAT
        M=D
        @endFrame{0}    // THIS = *(endFrame - 2)
        A=M
        D=M
        @2
        A=D-A
        D=M
        @THIS
        M=D
        @endFrame{0}    // ARG = *(endFrame - 3)
        A=M
        D=M
        @3
        A=D-A
        D=M
        @ARG
        M=D
        @endFrame{0}    // LCL = *(endFrame - 4)
        A=M
        D=M
        @4
        A=D-A
        D=M
        @LCL
        M=D
        @retAddr{0}     // goto retAddr
        A=M
        0;JMP
        """
        self.file.writelines(trim(asm).format(self.labelcounter, '\n'))
        self.labelcounter += 1

if __name__ == "__main__":
    inputf = sys.argv[1]
    outputfile = os.path.basename(inputf).replace(".vm", ".asm")
    outputpath = os.path.split(inputf)[0]
    outputfullname = os.path.join(outputpath, outputfile)
    parser = Parser(inputf)
    cw = CodeWriter(outputfullname)
    while parser.hasMoreCommands:
        parser.advance()
        currcmd = parser.currentCommand
        cmdtype = parser.commandtype(currcmd)
        if cmdtype == "C_ARITHMETIC":
            cw.writeArithmetic(parser.arg1(cmdtype))
        elif cmdtype in ("C_PUSH", "C_POP"):
            seg = parser.arg1(cmdtype)
            idx = parser.arg2(cmdtype)
            cw.writepushpop(cmdtype, seg, idx)
        elif cmdtype in ('C_LABEL', 'C_GOTO', 'C_IF'):
            label = parser.arg1(cmdtype)
            if cmdtype == 'C_LABEL':
                cw.writelabel(label)
            elif cmdtype == 'C_GOTO':
                cw.writegoto(label)
            elif cmdtype == 'C_IF':
                cw.writeif(label)
        elif cmdtype == 'C_FUNCTION':
            functionname = parser.arg1(cmdtype)
            nlocals = parser.arg2(cmdtype)
            cw.writefunction(functionname, nlocals)
        elif cmdtype == 'C_CALL':
            functionname = parser.arg1(cmdtype)
            nargs = parser.arg2(cmdtype)
            cw.writecall(functionname, nargs)
        elif cmdtype == 'C_RETURN':
            cw.writereturn()

    cw.close()
    parser.close()
