# ═══════════════════════════════════════════════════════════════
# RCPlayer - Deploy to GitHub + Google Drive
# ═══════════════════════════════════════════════════════════════

Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  RCPlayer - Deploy (GitHub + Google Drive)" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

$projectPath = $PSScriptRoot

# Check if git is initialized
if (-not (Test-Path "$projectPath\.git")) {
    Write-Host "⚠️  Git repository not initialized." -ForegroundColor Yellow
    Write-Host ""
    $initRepo = Read-Host "Would you like to initialize a new git repository? (y/n)"

    if ($initRepo -eq "y") {
        Write-Host ""
        Write-Host "📦 Initializing git repository..." -ForegroundColor Green
        git init

        Write-Host ""
        $repoUrl = Read-Host "Enter your GitHub repository URL (e.g., https://github.com/username/repo.git)"

        if ($repoUrl) {
            git remote add origin $repoUrl
            Write-Host "✓ Remote 'origin' added: $repoUrl" -ForegroundColor Green
        }
    } else {
        Write-Host "❌ Deployment cancelled." -ForegroundColor Red
        exit
    }
}

Write-Host ""
Write-Host "📊 Checking status..." -ForegroundColor Cyan
git status

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "  Files to commit" -ForegroundColor White
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host ""

# Stage all changes
Write-Host "📝 Staging changes..." -ForegroundColor Cyan
git add .

Write-Host ""
$commitMsg = Read-Host "Enter commit message (or press Enter for auto-message)"

if (-not $commitMsg) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
    $commitMsg = "Update RCPlayer - $timestamp"
}

Write-Host ""
Write-Host "💾 Committing changes..." -ForegroundColor Green
git commit -m "$commitMsg"

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ℹ️  No changes to commit." -ForegroundColor Yellow
} else {
    Write-Host "✓ Commit successful!" -ForegroundColor Green
}

Write-Host ""
$doPush = Read-Host "Push to GitHub? (y/n)"

if ($doPush -eq "y") {
    Write-Host ""
    Write-Host "🚀 Pushing to GitHub..." -ForegroundColor Cyan

    # Check if remote exists
    $remote = git remote -v
    if (-not $remote) {
        Write-Host "❌ No remote repository configured." -ForegroundColor Red
        Write-Host ""
        $repoUrl = Read-Host "Enter your GitHub repository URL"
        if ($repoUrl) {
            git remote add origin $repoUrl
            Write-Host "✓ Remote added." -ForegroundColor Green
        } else {
            Write-Host "❌ Push cancelled." -ForegroundColor Red
            exit
        }
    }

    # Get current branch
    $branch = git rev-parse --abbrev-ref HEAD
    Write-Host "   Branch: $branch" -ForegroundColor DarkGray

    # Push
    git push -u origin $branch

    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ Successfully pushed to GitHub!" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "❌ Push failed. Check your credentials and repository URL." -ForegroundColor Red
    }
}

# ═══════════════════════════════════════════════════════════════
# Google Drive Sync (via rclone)
# ═══════════════════════════════════════════════════════════════

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "  Google Drive Sync" -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray

$rclonePath = Get-Command rclone -ErrorAction SilentlyContinue
if (-not $rclonePath) {
    Write-Host ""
    Write-Host "rclone not found. Skipping Google Drive sync." -ForegroundColor Yellow
    Write-Host "Install with: winget install Rclone.Rclone" -ForegroundColor DarkGray
} else {
    # Check if gdrive remote is configured
    $remotes = rclone listremotes 2>&1
    $hasGdrive = $remotes -match "gdrive:"

    if (-not $hasGdrive) {
        Write-Host ""
        Write-Host "Google Drive remote not configured yet." -ForegroundColor Yellow
        Write-Host "Run this once to set up:  rclone config" -ForegroundColor Cyan
        Write-Host "  1. Choose 'n' for new remote" -ForegroundColor DarkGray
        Write-Host "  2. Name it: gdrive" -ForegroundColor DarkGray
        Write-Host "  3. Choose 'Google Drive' (type: drive)" -ForegroundColor DarkGray
        Write-Host "  4. Follow the browser auth flow" -ForegroundColor DarkGray
        Write-Host "  5. Re-run this script after setup" -ForegroundColor DarkGray
    } else {
        Write-Host ""
        $doSync = Read-Host "Sync to Google Drive? (y/n)"

        if ($doSync -eq "y") {
            $gdrivePath = "gdrive:RCPlayer"

            Write-Host ""
            Write-Host "Syncing entire project (including audio) to $gdrivePath ..." -ForegroundColor Cyan

            rclone sync "$projectPath\redacted_club_project" "$gdrivePath" `
                --progress `
                --exclude ".git/**" `
                --exclude "older builds/**"

            if ($LASTEXITCODE -eq 0) {
                Write-Host ""
                Write-Host "Google Drive sync complete!" -ForegroundColor Green
            } else {
                Write-Host ""
                Write-Host "Google Drive sync failed. Check rclone config." -ForegroundColor Red
            }
        }
    }
}

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "  Deployment Complete" -ForegroundColor Green
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host ""
