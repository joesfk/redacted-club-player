# RCPlayer — Agent Handover Document

**Date:** 2026-02-11
**File:** `redacted_club_project/redacted_player.html` (~5,391 lines)
**Reference:** See `CLAUDE.md` for project instructions and `RCPlayer_Features.txt` for full feature list.

---

## Project Summary

Single-file retro terminal-themed music player with ARG (Alternate Reality Game) puzzle mechanics. Everything lives in `redacted_player.html` — HTML, CSS, and JavaScript inline. No frameworks, no build system, no external dependencies (except Google Fonts CDN). Runs directly from filesystem.

Themed as a cyberpunk hacker terminal where users discover and unlock music tracks by solving puzzles, scanning frequencies, and entering codes.

---

## File Structure

```
redacted-club-player/
  CLAUDE.md                    # AI agent project instructions
  HANDOVER.md                  # This document
  RCPlayer_Features.txt        # Complete feature list (human-readable)
  redacted_club_project/
    redacted_player.html       # THE app (~5391 lines) - everything is here
    README.txt                 # User guide with spoiler section
    redacted_assets/
      audio/                   # 7 WAV tracks (~570 MB total)
        Casino.wav, DnS.wav, DA.wav, Could Be 5.wav,
        One Last Drink 2.wav, Sundee Arvo.wav, GG.wav
      gallery/                 # 6 unlockable images
      sfx/                     # Sound effects (ui/, glitch/, scanner/, ambient/, easter_eggs/)
      images/                  # Images + GIFs (Jurassic Park easter egg)
    older builds/              # Previous versions for reference
```

---

## Code Architecture (redacted_player.html)

All sections use consistent `═══` dividers for navigation. Search for `═══` to jump between sections.

### CSS (Lines 7–901)

| Line | Section | Description |
|------|---------|-------------|
| 13 | STAGE & ENVIRONMENT | Stage, server room, background monitors |
| 54 | TERMINAL SURFACE & CRT | CRT bezel, zoom-out, scanlines, flicker, keyframe animations |
| 128 | WELCOME & BOOT | Welcome screen, boot sequence styles |
| 143 | LAYOUT | Main grid, terminal, output, input line |
| 189 | SIDEBAR & TASKBAR | Sidebar panel, taskbar items, status display |
| 221 | POPUP BASE STYLES | Shared popup/titlebar/close button styles, dragging |
| 270 | CALC.EXE | Calculator popup |
| 312 | NOTEPAD.EXE | Notepad popup |
| 345 | MATRIX.EXE | Matrix rain popup |
| 367 | TRON.EXE | Tron lightcycle popup |
| 420 | PINCODE.EXE | PIN code popup + animations |
| 486 | SIDEBAR BUTTONS | Music FAB, gallery FAB, pulse animation |
| 517 | PLAYER.EXE | Media player popup + volume slider |
| 534 | SCANNER & RADAR | Scanner, radar, echoes popup styles |
| 562 | EASTER EGGS | Jurassic Park overlay + fade animations |
| 632 | GALLERY.EXE | Gallery grid, items, lightbox |
| 727 | SNAKE.EXE | Snake game canvas + controls |
| 790 | SYNTH.EXE | Synthesizer keyboard, ADSR, sequencer grid |
| 857 | DRUMS.EXE | Drum pads, step grid, transport controls |

### HTML (Lines 902–1365)

| Line | Section | Description |
|------|---------|-------------|
| 906 | WELCOME & BOOT | Welcome screen, boot screen, glitch/screensaver overlays |
| 919 | STAGE & TERMINAL | Server room, CRT, terminal header/output/input |
| 947 | CALC.EXE | Calculator buttons |
| 977 | NOTEPAD.EXE | Editable contenteditable notepad |
| 988 | MATRIX.EXE | Canvas for matrix rain |
| 998 | SNAKE.EXE | Canvas + score/highscore |
| 1019 | TRON.EXE | Canvas + win counter |
| 1040 | PINCODE.EXE | 4-digit PIN pad buttons |
| 1065 | PLAYER.EXE | Track list, play/pause/prev/next, volume |
| 1090 | SCANNER & RADAR | Radar canvas, scanner knobs + numeric inputs, spectrum canvas, echoes log |
| 1182 | SYNTH.EXE | Waveform selector, keyboard, octave shift, ADSR, filter, volume, 16-step sequencer |
| 1273 | DONUT.EXE | ASCII donut display |
| 1282 | DRUMS.EXE | 8 pads, 16x8 step grid, transport, BPM, volume |
| 1323 | GALLERY.EXE | Gallery grid + lightbox overlay |
| 1342 | SIDEBAR | Music/gallery FABs, taskbar, tier/secrets status |
| 1359 | AUDIO & EASTER EGGS | `<audio>` element, Jurassic Park GIF overlay |

### JavaScript (Lines 1365–5365)

| Line | Section | Description |
|------|---------|-------------|
| 1365 | CONFIG | Track metadata (7 tracks), paths, secret codes, format toggle |
| 1385 | SOUND EFFECTS SYSTEM | `playSFX()`, 13 MP3 effects, caching, `cloneNode()` overlap |
| 1492 | WINDOW REGISTRY | 14 popup windows, discovery state, sidebar taskbar rendering |
| 1550 | HINT ENGINE | 30s idle detection, contextual hints per tier, no repeats |
| 1617 | CORRUPTION | Floating corrupted text particles |
| 1632 | WELCOME | ASCII art logo, welcome screen handlers |
| 1684 | BOOT | POST messages, subsystem checks, boot animation |
| 1772 | PROGRESSION | Tier system (0-4), `tryProgress()`, `onTierUp()` |
| 1790 | OUTPUT | `printLine()` — terminal output with styling classes |
| 1795 | HELP | `showHelp()` — tier-gated command help text |
| 1825 | COMMANDS | `COMMANDS` object — 50+ terminal commands |
| 1954 | FUZZY MATCH | `fuzzyMatch()` — typo suggestions for mistyped commands |
| 1968 | PROCESS COMMAND | `processCommand()` — parser, dispatch, history |
| 1990 | HEADER | Clock update, session ID generation |
| 1994 | AUDIO | `playTrack()`, `pauseTrack()`, `stopTrack()`, format switching |
| 2004 | SECRETS | `addSecret()`, `checkAllSecrets()`, secret counting |
| 2008 | EFFECTS | Glitch, melt, matrix melt, screensaver, reality break (zoom-out) |
| 2425 | CORRUPTED WHISPERS | 50+ atmospheric messages, tier-based, 30-80s interval |
| 2520 | AUDIO EVENTS | Audio element event listeners (ended, timeupdate) |
| 2523 | UTILITIES | Helper functions |
| 2528 | INPUT | Terminal input handling, command history (up/down), tab autocomplete |
| 2547 | INIT | `initApp()`, Konami code listener, DOMContentLoaded |
| 2554 | FREQUENCY SCANNER | `scannerState`, `initScanner()`, `stopScanner()`, signal detection, ping |
| 2686 | RADAR DISPLAY | Canvas radar with sweep arm, ping waves, echo blips |
| 2906 | ANIMATED SPECTROGRAM | Canvas noise/spectrum visualization for scanner |
| 3079 | KNOB CONTROLS | Drag-to-rotate frequency/amplitude knobs |
| 3469 | SIGNAL LOCKING | `attemptLockSignal()`, echo management, radar unlock |
| 3553 | WINDOW INTERACTION | `toggleWindow()`, z-index management, close handlers |
| 3674 | GALLERY | Image gallery, unlock states, `renderGallery()` |
| 3808 | PLAYER | Media player popup, track list rendering, UI updates |
| 3973 | PIN CODE | 4-digit PIN pad, code validation |
| 4094 | SYNTH.EXE | Web Audio synth engine, 2-octave keyboard, ADSR envelope, filter |
| 4377 | SHARED TRANSPORT | Unified play/stop/rec/BPM for synth + drums sequencers |
| 4469 | DRUMS.EXE | 8 synthesized drum pads (Web Audio), 16x8 step grid |
| 4758 | SNAKE.EXE | Snake game with grid, scoring, localStorage high score |
| 4961 | TRON.EXE | Tron lightcycle game, player vs AI, localStorage wins |
| 5239 | CALC.EXE | Calculator (uses `eval()` — intentional) |
| 5260 | MATRIX.EXE | Matrix rain canvas animation |
| 5297 | DRAGGABLE POPUPS | Shared drag handler for all 14 popup windows |

### ARG Comments (Lines ~5370+)
Hidden HTML comments at end of file with player hints. **Do not remove.**

---

## Key Systems In Detail

### 1. Popup Window System (14 windows)
- All popups share `.popup-titlebar` and `.popup-close` classes
- Toggle via `toggleWindow(id)` or direct `.classList.add/remove('show')`
- Draggable via shared handler (line ~5297) — new popups must be added to the forEach array
- `WindowRegistry` (line ~1492) tracks discovery and renders sidebar taskbar
- Windows: player, gallery, scanner, radar, echoes, snake, tron, calc, notepad, matrix, donut, pincode, synth, drums

### 2. Shared Transport (Synth + Drums)
- Single `transport` object (line ~4377): `{ bpm, step, playing, recording, recStep, timer }`
- One tick loop drives BOTH synth sequencer and drum grid in lockstep
- `transportPlay()` / `transportStop()` / `transportToggle()` / `transportToggleRec()` / `transportSetBPM()`
- BPM change on either popup updates both
- Synth records notes to `synthState.seq[]`, drums record to `drumState.grid[][]`
- When playing, recording uses `transport.step` (live position); when stopped, uses `transport.recStep`

### 3. Frequency Scanner (3-window system)
- **SCANNER.EXE** — Frequency/amplitude knobs, spectrum canvas, ping/lock buttons
- **RADAR.EXE** — Circular canvas radar with sweep arm, ping waves, echo blips (locked until first signal)
- **ECHOES.EXE** — Log showing detected signals with proximity %
- **3 hidden signals:**
  - SIGNAL: 97.7 MHz @ amplitude 70 (±1.5 MHz, ±12 amp)
  - BENEATH: 108.0 MHz @ amplitude 85 (±1.5 MHz, ±12 amp)
  - VOID: 115.3 MHz @ amplitude 45 (±2.0 MHz, ±15 amp)
- Flow: adjust knobs → PING → echo proximity shown → LOCK at >90% → `decode [code]` in terminal

### 4. Secrets System
- **10 secrets** total: discovered via commands, scanner, PIN codes, Konami code
- All commands available from start (no tier gating)
- `addSecret()` tracks discoveries, updates sidebar counter
- Finding all secrets triggers "TRANSMISSION COMPLETE" message

### 5. Audio System
- HTML5 Audio element for track playback (7 tracks, WAV ~570 MB total)
- Web Audio API (separate AudioContexts) for synth and drums
- `playSFX()` for 13 UI sound effects with `cloneNode()` for overlapping playback
- SFX categories: ui, glitch, scanner, ambient, easter_eggs

---

## Important Gotchas

1. **Single file** — everything in `redacted_player.html`. No imports, no modules, no build.
2. **`eval()` in calculator** — intentional for retro feel, not a bug.
3. **`setNormState()` fully removed** — was a character system, all 42 calls + stub deleted.
4. **Tier/Paranoia/Glitch system fully removed** — no `triggerGlitch()`, no `printCorrupt()`, no `state.tier`, no `state.paranoia`. All commands unlocked from start.
5. **localStorage keys** use `rcplayer_` prefix: `rcplayer_snakeHighScore`, `rcplayer_tronWins`
5. **Audio files are huge WAVs** (~50-130 MB each, ~570 MB total). Intentional for quality.
6. **No server needed** — runs from filesystem via relative paths starting with `./`
7. **Hidden HTML comments** at end of file contain ARG hints. Don't remove.
8. **Popup drag array** — new popups must be added to the forEach array at line ~5298.
9. **`stopScanner()`** clears `scannerState.animInterval`. Must be called on scanner close.
11. **Dev mode** — boot sequence only shows with `?nodev` URL param. Direct file open skips intro.

---

## Adding a New Popup Window (Checklist)

1. **CSS**: Add styles in new `/* ═══ NEWPOPUP.EXE ═══ */` section before `</style>`
2. **HTML**: Add `<div id="newpopup-popup">` with `.popup-titlebar` and `.popup-close`
3. **JS — WindowRegistry** (~line 1492): Add `'newpopup-popup': { name: 'NAME', icon: '🎯', command: 'cmd', discovered: false }`
4. **JS — Commands** (~line 1825): Add command handler calling `WindowRegistry.discover()` and toggling popup
5. **JS — Help** (~line 1795): Add help text line
6. **JS — Draggable** (~line 5298): Add `'newpopup-popup'` to the forEach array

---

## Code Style

- Mixed semicolon usage (mostly without)
- Template literals for HTML generation
- Event-driven with DOM manipulation (no virtual DOM)
- Functions are standalone (not class-based)
- CSS variables: `--green` (#00ff41), `--green-dim`, `--green-dark`, `--green-ghost`, `--red`, `--amber`, `--cyan`, `--bg`

---

## Recent Changes (2026-02-11)

### Added
- **SYNTH.EXE** — Full keyboard synthesizer with 2-octave keyboard, ADSR envelope, low-pass filter, 16-step sequencer
- **DRUMS.EXE** — 8-pad drum machine with 16x8 step grid, all sounds synthesized via Web Audio
- **Shared Transport** — Single tick loop syncing synth + drums sequencers (play/stop/rec/BPM)
- **RCPlayer_Features.txt** — Comprehensive feature documentation

### Fixed
- **Drag bug** — donut-popup was after `</script>`, crashing drag forEach for ALL popups. Moved into body, added null guards.
- **`stopScanner()` undefined** — Defined proper function clearing animation interval
- **Scanner interval leak** — setInterval now stored and cleared on re-init/close
- **Transport recording bug** — recStep double-advance when playing, now uses correct step source
- **Class rename** — `donut-titlebar`/`donut-close` → `popup-titlebar`/`popup-close` (35 occurrences each)

### Removed
- 42 `setNormState()` calls + stub function
- Placeholder demo tracks (RC-DEMO-01, RC-DEMO-02) + isPlaceholder filter
- Disabled "TRANSMISSION DOWNLOAD - TBA" button
- Commented-out signal audio code + unused audioFile properties
- Dead scanner comment block
- **Tier progression system** (0-4) — all commands now unlocked from start
- **Paranoia system** — `state.paranoia`, all increments, random glitch frequency scaling
- **Dynamic glitch effects** — `triggerGlitch()`, `#glitch-overlay`, `heavy-glitch` keyframes, `.active`/`.heavy` CSS
- **Corruption utilities** — `corruptString()`, `scrambleText()`, `partialRedact()`, `printCorrupt()`, `GC` charset
- **Corrupted whispers** — `WHISPERS` arrays, `startWhispers()`, `injectWhisper()`, whisper CSS
- **Ambient effects** — `spawnDeadPixels()`, `startAmbientCorruption()`, `startRandomGlitches()`, dead-pixel CSS
- **Reality break** — `triggerReality()`, `reality`/`wake`/`truth` commands, zoom-out CSS
- **RGB split** — `@keyframes rgb-split`, `.line.corrupt` class
- **Header corruption** — `partialRevealHeader()`, corrupt string animations in `revealHeader()`
- **State variables** — `tier`, `paranoia`, `glitchCount`, `wrongAttempts`, `hasUsedLs`, `hasReadFile`, `hasScanned`, `hasTuned`
- **HTML elements** — `#glitch-overlay`, `#ambient-corrupt`, `#sidebar-tier`
- **Boot corruption** — `corrupt:true` boot messages, `scrambleText`/`corruptString` in boot loop

### Cleaned Up
- localStorage keys namespaced with `rcplayer_` prefix
- All CSS/HTML/JS sections standardized with `═══` dividers
- All `printCorrupt()` calls replaced with `printLine()`
- Help shows all commands (no tier gating)
- HintEngine simplified (discovery-based hints only)
- Commands like `rm`, `sudo`, `echo redacted` just print messages (no glitch effects)

---

## What's NOT Done / Potential Next Steps

- No test suite (manual testing only)
- Mobile responsiveness is basic (media queries at 700px and 500px)
- No PWA/service worker
- Dev mode logic could be inverted for release (`?dev` to skip boot instead of `?nodev`)
- Consider splitting into separate files if project grows beyond ~6000 lines
- SFX files in `redacted_assets/sfx/` should be verified present
- Some old scanner dead code may still remain deep in the JS
