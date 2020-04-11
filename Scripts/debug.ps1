param(
$sourcefile,    
$linenumber
)
function translate_line($sourcefile, $linenumber) 
{
    $source_line_count = 1
    $cpu_em_line_count = 0
    $lines = get-content $sourcefile
    if ($linenumber -gt $lines.count -or $linenumber -lt 0) {
        throw "line number is out of range"
    }
    foreach ($line in $lines) {
        if ($line -eq '' -or $line -imatch '^//|^\n|\(') {
            write-psfmessage "$($line) is a label, empty or comment"
        } else {
            write-psfmessage "$($line) is a program line"
            write-psfmessage "`$source_line_count is $($source_line_count)."
            $cpu_em_line_count += 1
            write-psfmessage "`$cpu_em_line_count is $($cpu_em_line_count)."
        }
        if ($linenumber -eq $cpu_em_line_count)
        {
            return $source_line_count, $line
        }
        $source_line_count += 1
    }
}

try {
    $info = translate_line -sourcefile $sourcefile -linenumber $linenumber
    write-psfmessage -message ("{0} {1}" -f $info[0], $info[1]) -level Significant
} catch {
    write-psfmessage -message $_.exception.message -level critical
}
