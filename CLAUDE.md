# REDACTED CLUB Player (RCPlayer)

## Project Overview
Single-file retro terminal-themed music player with ARG puzzle mechanics. Everything lives in `redacted_club_project/redacted_player.html` — HTML, CSS, and JavaScript inline. No frameworks, no build system, no external dependencies (except Google Fonts CDN).

Themed as a cyberpunk hacker terminal where users discover and unlock music tracks by solving puzzles, scanning frequencies, and entering codes.

## Tech Stack
- **Language**: Vanilla JavaScript (ES6+)
- **Markup/Styling**: HTML5, CSS3 (all inline in single file)
- **Audio**: HTML5 Audio API (MP3 320kbps for web, WAV originals gitignored)
- **Graphics**: Canvas API (spectrum visualizer, donut renderer, matrix rain)
- **Fonts**: Google Fonts CDN (Share Tech Mono, VT323)
- **Persistence**: localStorage (high scores only, `rcplayer_` prefix)

## Project Structure
```
redacted-club-player/
  CLAUDE.md                    # This file (AI agent instructions)
  redacted_club_project/
    redacted_player.html       # THE app (~5000 lines) — everything is here
    README.txt                 # User guide with spoiler section
    redacted_assets/
      audio/                   # 7 MP3 tracks (320kbps, ~65 MB total; WAV originals gitignored)
        Casino.mp3, DnS.mp3, DA.mp3, Could Be 5.mp3,
        One Last Drink 2.mp3, Sundee Arvo.mp3, GG.mp3
      gallery/                 # 6 unlockable images
      sfx/                     # Sound effects (ui/, glitch/, scanner/, ambient/, easter_eggs/)
      images/                  # Images + GIFs (Jurassic Park easter egg)
```

---

## Git & Deployment

- **Repo**: `https://github.com/joesfk/redacted-club-player.git`
- **Live site**: `https://joesfk.github.io/redacted-club-player/redacted_club_project/redacted_player.html`
- **Hosting**: GitHub Pages, deploys automatically from `master` branch
- **Audio format**: MP3 (320kbps) for web. WAV originals are gitignored.

### Agent workflow (IMPORTANT — follow every session)
1. **Start of session**: Run `git pull` to get latest changes before making any edits
2. **After changes**: Commit and push so the live site updates and other machines stay in sync
3. **New audio files**: If WAV files are added, convert to MP3 at 320kbps using ffmpeg before committing
4. **Commit style**: Short descriptive message, single commit per logical change
5. **Never force push** unless explicitly asked — the repo may be used from multiple machines

### Running locally
Open `redacted_player.html` in a web browser. All assets load via relative paths. No server needed.

---

## Code Architecture (redacted_player.html)

All sections use `═══` dividers for navigation. Search for `═══` to jump between sections.

### CSS (~900 lines)
Green terminal aesthetic (#00ff41), CRT scanline/flicker effects, responsive design, draggable window styling.

CSS variables: `--green` (#00ff41), `--green-dim`, `--green-dark`, `--green-ghost`, `--red`, `--amber`, `--cyan`, `--bg`

### HTML (~460 lines)
Grid layout with terminal interface, 14 draggable popup windows, audio element, canvas elements.

### JavaScript (~4000 lines)
Key systems:

1. **CONFIG** — Track metadata (7 tracks), paths, secret codes, format toggle
2. **SFX system** — `playSFX()`, 13 MP3 effects, caching, `cloneNode()` overlap
3. **WindowRegistry** — 14 popup windows, discovery state, sidebar taskbar rendering
4. **HintEngine** — 30s idle detection, contextual hints, no repeats
5. **Welcome/Boot** — ASCII art logo, POST messages, boot animation
6. **Terminal** — `printLine()`, `showHelp()`, 50+ commands, fuzzy match, input handling
7. **Audio** — `playTrack()`, `pauseTrack()`, `stopTrack()`, format switching
8. **Secrets** — `addSecret()`, `checkAllSecrets()`, 10 total secrets
9. **Effects** — Melt, matrix melt, screensaver (standalone, no tier/paranoia dependencies)
10. **Scanner** — `scannerState`, signal detection, radar display, spectrogram, knob controls, signal locking
11. **Gallery** — Image gallery, unlock states, lightbox
12. **Player popup** — Track list rendering, UI updates
13. **PIN code** — 4-digit PIN pad, code validation
14. **Synth.exe** — Web Audio synth, 2-octave keyboard, ADSR, filter, 16-step sequencer
15. **Shared Transport** — Unified play/stop/rec/BPM for synth + drums
16. **Drums.exe** — 8 synthesized drum pads, 16x8 step grid
17. **Snake/Tron** — Games with localStorage high scores
18. **Calc/Matrix/Donut** — Mini-apps
19. **Draggable popups** — Shared drag handler for all 14 windows

### ARG Comments (end of file)
Hidden HTML comments with player hints. **Do not remove.**

---

## Key Systems

### Popup Window System (14 windows)
- All popups share `.popup-titlebar` and `.popup-close` classes
- Toggle via `toggleWindow(id)` or direct `.classList.add/remove('show')`
- Draggable via shared handler — new popups must be added to the forEach array
- `WindowRegistry` tracks discovery and renders sidebar taskbar
- Windows: player, gallery, scanner, radar, echoes, snake, tron, calc, notepad, matrix, donut, pincode, synth, drums

### Shared Transport (Synth + Drums)
- Single `transport` object: `{ bpm, step, playing, recording, recStep, timer }`
- One tick loop drives BOTH synth sequencer and drum grid in lockstep
- BPM change on either popup updates both

### Frequency Scanner (3-window system)
- **SCANNER.EXE** — Frequency/amplitude knobs, spectrum canvas, ping/lock buttons
- **RADAR.EXE** — Circular canvas radar with sweep arm, ping waves, echo blips
- **ECHOES.EXE** — Log showing detected signals with proximity %
- **3 hidden signals:**
  - SIGNAL: 97.7 MHz @ amplitude 70 (±1.5 MHz, ±12 amp)
  - BENEATH: 108.0 MHz @ amplitude 85 (±1.5 MHz, ±12 amp)
  - VOID: 115.3 MHz @ amplitude 45 (±2.0 MHz, ±15 amp)
- Flow: adjust knobs → PING → echo proximity shown → LOCK at >90% → `decode [code]` in terminal

### Secrets System (10 total)
- All commands available from start (no tier gating)
- `addSecret()` tracks discoveries, updates sidebar counter
- Finding all secrets triggers "TRANSMISSION COMPLETE" message

---

## Key Constants
- **Audio path**: `./redacted_assets/audio/`
- **Unlock codes**: SIGNAL, BENEATH, REDACTED, VOID, OMNISCIENT
- **PIN codes**: 1337, 9775, 1984, 0420
- **Konami Code**: up up down down left right left right B A

---

## Adding a New Popup Window (Checklist)

1. **CSS**: Add styles in new `/* ═══ NEWPOPUP.EXE ═══ */` section before `</style>`
2. **HTML**: Add `<div id="newpopup-popup">` with `.popup-titlebar` and `.popup-close`
3. **JS — WindowRegistry**: Add entry with `name`, `icon`, `command`, `discovered: false`
4. **JS — Commands**: Add command handler calling `WindowRegistry.discover()` and toggling popup
5. **JS — Help**: Add help text line
6. **JS — Draggable**: Add `'newpopup-popup'` to the forEach array

---

## Gotchas

1. **Single file** — everything in `redacted_player.html`. No imports, no modules, no build.
2. **`eval()` in calculator** — intentional for retro feel, not a bug.
3. **Tier/Paranoia/Glitch system fully removed** — no `triggerGlitch()`, no `printCorrupt()`, no `state.tier`, no `state.paranoia`. All commands unlocked from start.
4. **`setNormState()` fully removed** — was a character system, all calls + stub deleted.
5. **localStorage keys** use `rcplayer_` prefix: `rcplayer_snakeHighScore`, `rcplayer_tronWins`
6. **No server needed** — runs from filesystem via relative paths starting with `./`
7. **Hidden HTML comments** at end of file contain ARG hints. Don't remove.
8. **Popup drag array** — new popups must be added to the forEach array.
9. **`stopScanner()`** clears `scannerState.animInterval`. Must be called on scanner close.
10. **Dev mode** — boot sequence only shows with `?nodev` URL param. Direct file open skips intro.
11. **Default audio format is MP3** — do not change CONFIG.format to `wav` unless user requests it.

---

## Automations

### Pre-commit Hook (local)
- Validates HTML tag balance, asset paths, and config defaults before each commit
- Setup: `git config core.hooksPath .githooks` (one-time per machine)
- Test manually: `powershell .githooks/validate.ps1`
- Files: `.githooks/pre-commit` (bash shim) + `.githooks/validate.ps1` (logic)

### GitHub Actions CI
- Runs on push/PR to master — validates HTML structure, asset existence, config sanity, file size
- See `.github/workflows/validate.yml`
- No Node.js needed, runs in seconds on free tier

### Data Persistence & Backup
- Secrets and discovered tracks auto-persist to localStorage (`rcplayer_secrets`, `rcplayer_discovered`)
- Terminal commands: `backup` (export JSON), `restore` (import JSON), `resetdata confirm` (wipe all)

---

## Code Style
- Mixed semicolon usage (mostly without)
- Template literals for HTML generation
- Event-driven with DOM manipulation (no virtual DOM)
- Functions are standalone (not class-based)
- CSS variables for theming

---

## Troubleshooting
- **Audio not loading**: Check relative paths in CONFIG object (`./redacted_assets/audio/`)
- **Gallery images not showing**: Verify unlock codes are correct in state management
- **Terminal not responding**: Check event listeners on input element
- **Draggable windows stuck**: Check z-index management in popup system
