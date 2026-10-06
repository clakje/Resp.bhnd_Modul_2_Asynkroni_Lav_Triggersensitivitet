# lag-rise-zip.ps1 — pakker spilleren som zip for opplasting i Articulate Rise.
#
# Rise krever at index.html ligger i roten av zip-filen (ikke i en undermappe).
# Bare filene siden trenger tas med.
#
#   powershell -ExecutionPolicy Bypass -File lag-rise-zip.ps1

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$dir   = $PSScriptRoot
$zip   = Join-Path $dir 'asynkroni-lav-trigger-sensitivitet-player.zip'
$files = 'index.html', 'style.css', 'player.css', 'simulator.js', 'renderer.js', 'scenario-data.js', 'app.js'

if (Test-Path $zip) { Remove-Item $zip -Confirm:$false }

$archive = [System.IO.Compression.ZipFile]::Open($zip, 'Create')
try {
    foreach ($f in $files) {
        [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
            $archive, (Join-Path $dir $f), $f, 'Optimal') | Out-Null
    }
} finally {
    $archive.Dispose()
}

Write-Host "Skrev $zip"
