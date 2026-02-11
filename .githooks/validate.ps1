# RCPlayer Pre-commit Validation Script
# Checks HTML structure, asset paths, and config defaults

$ErrorActionPreference = "Continue"
$root = git rev-parse --show-toplevel
$html = Join-Path $root "redacted_club_project\redacted_player.html"
$assetDir = Join-Path $root "redacted_club_project"
$failed = $false

Write-Host "`n=== RCPlayer Pre-commit Checks ===" -ForegroundColor Cyan

# --- Check 1: HTML tag balance ---
Write-Host "`n[1/3] HTML structure..." -ForegroundColor Yellow
$content = Get-Content $html -Raw
$tags = @("html", "head", "body", "style", "script")
foreach ($tag in $tags) {
    $openCount = ([regex]::Matches($content, "<${tag}[\s>]", "IgnoreCase")).Count
    $closeCount = ([regex]::Matches($content, "</${tag}>", "IgnoreCase")).Count
    if ($openCount -ne $closeCount) {
        Write-Host "  FAIL: <$tag> opens $openCount times, closes $closeCount times" -ForegroundColor Red
        $failed = $true
    }
}
if (-not $failed) {
    Write-Host "  PASS: All structural tags balanced" -ForegroundColor Green
}

# --- Check 2: Asset paths ---
Write-Host "`n[2/3] Asset paths..." -ForegroundColor Yellow
$assetFail = $false
$paths = [regex]::Matches($content, '\./redacted_assets/[^''"\)\s]+') | ForEach-Object { $_.Value } | Sort-Object -Unique
foreach ($p in $paths) {
    $fullPath = Join-Path $assetDir $p
    if (-not (Test-Path $fullPath)) {
        Write-Host "  FAIL: Missing asset: $p" -ForegroundColor Red
        $assetFail = $true
        $failed = $true
    }
}
if (-not $assetFail) {
    Write-Host "  PASS: All $($paths.Count) asset references valid" -ForegroundColor Green
}

# --- Check 3: Config defaults ---
Write-Host "`n[3/3] Config defaults..." -ForegroundColor Yellow
$configFail = $false
if ($content -match "format:'wav'") {
    Write-Host "  FAIL: CONFIG.format is 'wav' — should be 'mp3'" -ForegroundColor Red
    $configFail = $true
    $failed = $true
}
if (-not $configFail) {
    Write-Host "  PASS: Config defaults OK" -ForegroundColor Green
}

# --- Result ---
Write-Host ""
if ($failed) {
    Write-Host "COMMIT BLOCKED — fix errors above" -ForegroundColor Red
    exit 1
} else {
    Write-Host "ALL CHECKS PASSED" -ForegroundColor Green
    exit 0
}
