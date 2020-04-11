def find_problem_line(filename, linenumber, context):
    with open(filename) as f:
        lines = [line for line in f if not line.startswith(('//', '('))]
        res = {index:line for index, line in enumerate(lines)}
        if context == 0:
            try:
                return [(linenumber, res[linenumber])]
            except KeyError:
                print("line number out of range. Min is {}, max is {}".format(min(res.keys()), max(res.keys())))
                raise
        else:
            returnlines = []
            for i in range(linenumber-context, linenumber+context):
                try:
                    returnlines.append((i, res[i]))
                except:
                    pass
            return returnlines

if __name__ == "__main__":
    import sys
    from pprint import pprint as pp
    linenumber = int(sys.argv[2])
    try:
        context = int(sys.argv[3])
    except IndexError:
        context = 0
    try:    
        for i in find_problem_line(sys.argv[1], linenumber, context):
            print("{}: {}".format(i[0], i[1]), end='')
    except:
        pass