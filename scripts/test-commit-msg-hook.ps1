$ErrorActionPreference = 'Stop'

function Get-RepoRoot {
    $root = git -C $PSScriptRoot rev-parse --show-toplevel 2>$null
    if (-not $root) {
        throw 'Cannot determine repository root.'
    }

    return $root.Trim()
}

function Get-GitShPath {
    $gitPath = (Get-Command git).Source
    $gitRoot = Split-Path (Split-Path $gitPath)
    $candidates = @(
        (Join-Path $gitRoot 'bin\sh.exe'),
        (Join-Path $gitRoot 'usr\bin\sh.exe')
    )

    foreach ($candidate in $candidates) {
        if (Test-Path $candidate) {
            return $candidate
        }
    }

    throw 'Cannot locate Git sh.exe.'
}

function New-CommitMessageFile {
    param(
        [Parameter(Mandatory = $true)]
        [string] $Content
    )

    $path = Join-Path $env:TEMP ("codex-commit-msg-{0}.txt" -f ([guid]::NewGuid().ToString('N')))
    $encoding = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($path, $Content, $encoding)
    return $path
}

function Get-ChineseSampleMessage {
    return 'docs: ' + ([char]0x6DFB) + ([char]0x52A0) + ([char]0x94A9) + ([char]0x5B50)
}

function Invoke-HookCase {
    param(
        [Parameter(Mandatory = $true)]
        [string] $HookPath,

        [Parameter(Mandatory = $true)]
        [string] $ShPath,

        [Parameter(Mandatory = $true)]
        [string] $Label,

        [Parameter(Mandatory = $true)]
        [string] $Message,

        [Parameter(Mandatory = $true)]
        [bool] $ShouldPass
    )

    $messageFile = New-CommitMessageFile -Content $Message
    $stdoutFile = Join-Path $env:TEMP ("codex-commit-msg-stdout-{0}.txt" -f ([guid]::NewGuid().ToString('N')))
    $stderrFile = Join-Path $env:TEMP ("codex-commit-msg-stderr-{0}.txt" -f ([guid]::NewGuid().ToString('N')))

    try {
        $process = Start-Process -FilePath $ShPath -ArgumentList @($HookPath, $messageFile) -Wait -PassThru -NoNewWindow -RedirectStandardOutput $stdoutFile -RedirectStandardError $stderrFile
        $exitCode = $process.ExitCode
    } finally {
        Remove-Item $messageFile -ErrorAction SilentlyContinue
        Remove-Item $stdoutFile -ErrorAction SilentlyContinue
        Remove-Item $stderrFile -ErrorAction SilentlyContinue
    }

    $passed = ($exitCode -eq 0)
    $status = if ($passed -eq $ShouldPass) { 'PASS' } else { 'FAIL' }
    $expected = if ($ShouldPass) { 'pass' } else { 'fail' }
    Write-Host ("[{0}] {1}: expected {2}, got exit {3}" -f $status, $Label, $expected, $exitCode)

    return ($passed -eq $ShouldPass)
}

$repoRoot = Get-RepoRoot
$hookPath = Join-Path $repoRoot '.githooks\commit-msg'
$shPath = Get-GitShPath

if (-not (Test-Path $hookPath)) {
    Write-Error ("Missing hook file: {0}" -f $hookPath)
}

$allPassed = $true
$allPassed = (Invoke-HookCase -HookPath $hookPath -ShPath $shPath -Label 'english-summary' -Message 'docs: add hook' -ShouldPass $false) -and $allPassed
$allPassed = (Invoke-HookCase -HookPath $hookPath -ShPath $shPath -Label 'chinese-summary' -Message (Get-ChineseSampleMessage) -ShouldPass $true) -and $allPassed
$allPassed = (Invoke-HookCase -HookPath $hookPath -ShPath $shPath -Label 'merge-message' -Message "Merge branch 'x'" -ShouldPass $true) -and $allPassed

if (-not $allPassed) {
    exit 1
}
