# REDACTED CLUB Player (RCPlayer)

## Project Overview
A retro terminal-themed interactive music player with ARG (Alternate Reality Game) puzzle mechanics. Built as a single self-contained HTML file using vanilla HTML5, CSS3, and JavaScript — no frameworks, no build system, no external dependencies.

The player is themed as a cyberpunk/hacker terminal where users discover and unlock music tracks by solving puzzles, entering codes, and exploring a command-line interface.

## Tech Stack
- **Language**: Vanilla JavaScript (ES6+)
- **Markup/Styling**: HTML5, CSS3 (all inline in single file)
- **Audio**: HTML5 Audio API (WAV format, ~570 MB total)
- **Graphics**: Canvas API (spectrum visualizer, donut renderer, matrix rain)
- **Fonts**: Google Fonts CDN (Share Tech Mono, VT323)
- **Persistence**: localStorage (high scores only)

## Project Structure
```
RCPlayer/
  CLAUDE.md
  redacted_club_project/
    redacted_player.html      # Main app (~4900 lines) — THE single source file
    README.txt                 # User guide with spoiler section
    redacted_assets/
      audio/                   # 7 WAV tracks (~570 MB total)
        Casino.wav
        DnS.wav                # Drunk N Stumblin
        DA.wav                 # Destroy Architecture
        Could Be 5.wav         # Could Be Worse
        One Last Drink 2.wav
        Sundee Arvo.wav
        GG.wav                 # Hidden/secret track
      gallery/                 # 6 unlockable images + 1 PSD source
      sfx/                     # Sound effects (ui/, glitch/, scanner/, ambient/, easter_eggs/)
      images/                  # Empty placeholder
    older builds/              # Previous versions for reference
```

## Architecture (within redacted_player.html)

The entire app lives in one HTML file with three major sections:

### HTML (~200 lines)
- Grid-based layout with terminal interface
- 9 draggable popup windows (PLAYER.EXE, GALLERY.EXE, SNAKE.EXE, etc.)
- Audio element, canvas elements for visualizations

### CSS (~800 lines)
- Green terminal aesthetic (#00ff41)
- CRT scanline/flicker effects
- Responsive design with mobile fallbacks
- Draggable window styling

### JavaScript (~2000+ lines)
Key systems in order of importance:

1. **CONFIG object** — Track metadata, secret codes, asset paths, format toggle (WAV/MP3)
2. **State management** — `state` object tracks discovered tracks, boot status, playback
3. **Terminal/Command system** — 50+ commands with input parsing, history, autocomplete (all unlocked from start)
4. **Audio playback** — Play/pause/seek/volume, track lock/unlock, format switching
5. **Frequency scanner** — Canvas spectrum visualization, signal detection at 97.7/108.0 MHz
6. **Popup window manager** — Draggable windows with z-index management, collision detection
7. **Visual effects** — CRT scanlines, flicker, melt terminal animations, screensaver
8. **Mini-games** — Snake, Tron, calculator (uses eval()), notepad, donut renderer, matrix rain
9. **WindowRegistry** — Tracks discovered popup windows, renders sidebar taskbar, toggle via click
10. **HintEngine** — Idle detection (30s), contextual hints, shown as terminal ghost text
11. **SFX system** — `playSFX()` with MP3 files in `redacted_assets/sfx/` (ui, glitch, scanner, ambient, easter_eggs)

## Development Workflow

### Running locally
Simply open `redacted_player.html` in a web browser. All assets load via relative paths.

### No build step
Edit `redacted_player.html` directly. Refresh browser to see changes.

## Key Constants & Config
- **Audio path**: `./redacted_assets/audio/`
- **Unlock codes**: SIGNAL, BENEATH, REDACTED, VOID
- **PIN codes**: 1337, 9775, 1984, 0420
- **Secret frequencies**:
  - 97.7 MHz (SIGNAL) - FM, 10kHz BW, Gain 65-75, Band-pass filter, SNR >12dB
  - 108.0 MHz (BENEATH) - SSB, 5kHz BW, Gain 80-95, Low-pass filter, SNR >8dB
  - 115.3 MHz (VOID) - Digital, 25kHz BW, Gain 45-60, Notch filter, SNR >6dB
- **Total secret codes**: 10
- **Konami Code**: Active (up up down down left right left right B A)

## Important Notes
- The file uses `eval()` in the calculator — intentional for retro feel, not a bug
- Audio files are large WAVs (~50-130 MB each); total project ~570 MB
- Gallery includes a `.pdn` (Paint.NET) source file — not served to users
- Hidden HTML comments at end of file contain ARG hints for players
- The `older builds/` folder contains previous iterations for reference/rollback

## Code Style
- No semicolons consistently used (mixed style)
- Template literals for HTML generation
- Event-driven architecture with DOM manipulation
- Functions are mostly standalone (not class-based)
- Inline styles mixed with CSS classes
- Console-style output buffer pattern for terminal display

## Recent Work / Current Focus
<!-- Update this section as you work on the project -->
- Removed server requirements (START_SERVER.ps1) — project now runs directly from HTML file
- **MAJOR: Sonar ping scanner with analog controls** (2026-02-06)
  - **Circular radar display** with rotating sweep line and fade trail effects
  - **Two analog knobs**: Frequency (80-120 MHz) and Amplitude (0-100)
  - **Sonar ping mechanic**: Click PING to send pulse, echoes show signal proximity
  - **Echo power system**: Returns show 0-100% power based on how close both parameters are
  - **Visual feedback**: Expanding ping waves, echo dots on radar, power bars
  - **Smart hints**: Echo display tells you which parameter to adjust (freq/amp/both)
  - **Drag-to-rotate knobs**: Click and drag to turn knobs smoothly
  - **3 signals**: SIGNAL (97.7 MHz @ 70 amp), BENEATH (108.0 @ 85), VOID (115.3 @ 45)
  - Simplified from complex multi-parameter system to intuitive freq+amp combo
- **SFX system** (2026-02-06)
  - 13 MP3 sound effects across 5 categories (ui, glitch, scanner, ambient, easter_eggs)
  - Wired into: commands, boot, glitches, windows, scanner, easter eggs, snake, PIN pad
  - `playSFX(name, volume)` with caching and `cloneNode()` for overlapping playback
- **NORM character removed** (2026-02-07)
  - Removed all ASCII art, popup, CSS, commands, and dialogue
  - `setNormState()` left as no-op stub for safety (40+ calls throughout code)
- **Sidebar taskbar** (2026-02-06)
  - WindowRegistry tracks 11 popup windows, shows discovered ones in sidebar
  - Click taskbar entry to toggle window open/closed
  - Live status: SECRETS: X/10
- **HintEngine** (2026-02-06)
  - Idle detection (30s threshold), contextual hints
  - Shows hints as terminal ghost text
  - Tracks history to avoid repeats
- **Old player removed** — inline `#player-bar` eliminated, fully using popup PLAYER.EXE
- Removed dead code: `addProtocol()`, `syncProtocols()`, `knownProtocols`
- **Tier/Paranoia/Glitch system removed** (2026-02-11)
  - Removed tier progression (0-4) — all commands available from start
  - Removed paranoia system — no more increasing glitch frequency
  - Removed dynamic glitch effects: `triggerGlitch()`, glitch overlay, random glitches, dead pixels, ambient corruption, RGB split
  - Removed corruption utilities: `corruptString()`, `scrambleText()`, `partialRedact()`, `printCorrupt()`
  - Removed corrupted whispers system (atmospheric messages)
  - Removed reality break easter egg (`reality`/`wake`/`truth` commands)
  - Removed zoom-out 3D perspective effect
  - Kept: CRT cosmetics (scanlines, flicker, glow), melt commands, screensaver, secrets system
  - All `printCorrupt()` calls replaced with `printLine()`
  - Help shows all commands immediately
  - HintEngine simplified (no tier-based hints)

## Known Issues & Common Bugs
<!-- Document recurring problems here -->
- [No known issues yet — add as they're discovered]

## Quirks & Gotchas
<!-- Non-obvious behavior to remember -->
- The file is served directly from filesystem (no server) — all paths are relative
- Audio files are large WAVs (~570 MB total) — intentional for quality
- `eval()` in calculator is intentional for retro feel, not a security concern
- NORM/PIXL-BOY character was fully removed
- **No tier/paranoia system** — all commands available immediately, no dynamic glitch effects
- **WindowRegistry**: Windows are "discovered" on first open and persist in sidebar taskbar
- **SFX path**: `./redacted_assets/sfx/` with subdirs ui/, glitch/, scanner/, ambient/, easter_eggs/
- HTML comments at end of file contain ARG hints — don't remove them
- **Scanner system** (sonar ping style):
  - **Two-parameter detection**: Need BOTH correct frequency AND amplitude to lock signal
  - **SIGNAL**: 97.7 MHz @ amplitude 70 (±0.5 MHz, ±10 amp tolerance)
  - **BENEATH**: 108.0 MHz @ amplitude 85 (±0.3 MHz, ±8 amp tolerance)
  - **VOID**: 115.3 MHz @ amplitude 45 (±0.8 MHz, ±15 amp tolerance)
  - **Echo power**: 0-100% shows how close you are (>90% = locked)
  - **Hints**: Echo display tells which knob to adjust
  - **Knobs**: Drag to rotate - Frequency maps 0-360° to 80-120 MHz, Amplitude to 0-100
  - **Visual feedback**: Ping waves expand, echoes appear as green dots at signal positions

## Lessons Learned
<!-- What worked, what didn't -->
- [Add lessons as you discover them]

## Troubleshooting
<!-- Common problems and solutions -->
- **Audio not loading**: Check relative paths in CONFIG object (`./redacted_assets/audio/`)
- **Gallery images not showing**: Verify unlock codes are correct in state management
- **Terminal not responding**: Check event listeners on input element
- **Draggable windows stuck**: Check z-index management in popup system
