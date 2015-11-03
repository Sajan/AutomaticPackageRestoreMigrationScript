$hintPathPattern = @"
<HintPath>(\d|\w|\s|\.|\\)*packages
"@

$tfexe = 'C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Ide\TF.exe'

ls -Recurse -include *.csproj, *.sln, *.fsproj, *.vbproj |
  foreach {

    $content = cat $_.FullName | Out-String
    $origContent = $content
    $content = $content -replace $hintPathPattern, "<HintPath>`$(SolutionDir)packages"
    if ($origContent -ne $content)
    {	
	& $tfexe "checkout" $_.FullName
        $content | out-file -encoding "UTF8" $_.FullName
        write-host messed with $_.Name
    }		    
}
