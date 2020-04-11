import os
import sys
import re

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
            m = re.match(r'\w+', self.currentCommand.split(' ')[2])
            return m[0]
        else:
            raise ValueError

    def close(self):
        self.file.close()


class CodeWriter(object):
    def __init__(self, inputfile, outputfile, openmode, writeinit):
        self.file = open(outputfile, openmode)
        self.labelcounter = 0
        self.filename = os.path.basename(inputfile).replace(".vm", "")
        self.currfuncname = ''
        if writeinit:
            self.writeinit()

    def writeinit(self):
        asm = """
        // bootstrap code 
        @256
        D=A
        @SP
        M=D
        """
        self.file.writelines(trim(asm))
        self.writecall('Sys.init', '0')

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
                """
                self.file.writelines(trim(asm).format(commandstring, segmentName, index))

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
                @R13
                M=D
                @SP
                M=M-1
                @SP
                A=M
                D=M
                @R13
                A=M
                M=D
                """
                self.file.writelines(trim(asm).format(commandstring, segmentName, index))
        
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
        f_label = "{}${}".format(self.currfuncname, label)
        asm = """
        {0}// label {1}
        ({2})
        """
        self.file.writelines(trim(asm).format('\n', label, f_label))
    
    def writegoto(self, label):
        f_label = "{}${}".format(self.currfuncname, label)
        asm = """
        {0}//goto {1}
        @{2}
        0;JMP
        """
        self.file.writelines(trim(asm).format('\n', label, f_label))

    def writeif(self, label):
        f_label = "{}${}".format(self.currfuncname, label)
        asm = """
        {0}//if-goto {1}
        @SP
        M=M-1
        @SP
        A=M
        D=M
        @{2}
        D;JNE
        """
        self.file.writelines(trim(asm).format('\n', label, f_label))

    def writecall(self, functionname, nargs):
        asm = """
        {3}// call {0} {1}
        @{0}$ret.{2} // push returnAddress
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
        @{1}
        D=D-A
        @ARG
        M=D
        @SP         // LCL = SP
        D=M
        @LCL
        M=D
        @{0}        // goto {0} transfers control to the called function
        0;JMP
        ({0}$ret.{2})  // declares a label for the return address
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
        @R13
        M=0
        ({0}$LOOP.{2})
        @R13       // push 0 * numlocals
        D=M
        @{1}
        D=D-A
        @{0}$END.{2}
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
        @{0}$LOOP.{2}
        0;JMP
        ({0}$END.{2})
        """
        self.file.writelines(trim(asm).format(
            functionname,
            numlocals,
            self.labelcounter,
            '\n'
            )
        )
        self.labelcounter += 1
        self.currfuncname = functionname

    def writereturn(self):
        asm = """
        {}// return
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
        """
        self.file.writelines(trim(asm).format('\n'))


if __name__ == "__main__":
    inputdir = sys.argv[1]
    outputfile = os.path.basename(inputdir) + ".asm"
    outputfullname = os.path.join(inputdir, outputfile)
    process_files = ['Sys.vm', 'Main.vm']
    for f in process_files:
        parser = Parser(os.path.join(inputdir, f))
        if f == 'Sys.vm':
            openmode = 'w'
            writeinit = True
        else:
            openmode = 'a'
            writeinit = False
        cw = CodeWriter(f, outputfullname, openmode, writeinit)
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
