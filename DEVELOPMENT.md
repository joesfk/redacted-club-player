# REDACTED CLUB PLAYER - DEVELOPMENT GUIDE
**Game Flow & Systems Documentation**

---

## TABLE OF CONTENTS
1. [Game Progression Overview](#game-progression-overview)
2. [Tier System](#tier-system)
3. [Signal Frequencies](#signal-frequencies)
4. [Unlock Chains](#unlock-chains)
5. [Secret Codes](#secret-codes)
6. [Commands Reference](#commands-reference)
7. [State Management](#state-management)
8. [Testing Shortcuts](#testing-shortcuts)

---

## GAME PROGRESSION OVERVIEW

```
┌─────────────────────────────────────────────────────────────┐
│                      PLAYER JOURNEY                         │
└─────────────────────────────────────────────────────────────┘

START (Tier 0)
    │
    ├─> Type "help" to see commands
    ├─> Type "files" or "ls" → Unlocks Tier 1, adds LS secret
    └─> Read manifest/system/frequencies logs → adds CAT secrets
                │
                ▼
         ─────────────
         │  TIER 1   │ Basic exploration unlocked
         ─────────────
                │
                ├─> Files visible, read commands work
                └─> Progress to Tier 2 by reading files
                            │
                            ▼
                     ─────────────
                     │  TIER 2   │ Scanner & Player unlocked
                     ─────────────
                            │
                            ├─> "scan" command available
                            ├─> "player" command available
                            ├─> "tune" command available
                            └─> Find signals at 97.7 & 108.0 MHz
                                        │
                                        ▼
                                 ─────────────
                                 │  TIER 3   │ Advanced commands
                                 ─────────────
                                        │
                                        ├─> "source" command available
                                        ├─> "whoami" command available
                                        ├─> "ping" command available
                                        └─> Decode keys to unlock tracks
                                                    │
                                                    ▼
                                             ─────────────
                                             │  TIER 4   │ Master unlock
                                             ─────────────
                                                    │
                                                    └─> All tracks unlocked
                                                        All secrets found
```

---

## TIER SYSTEM

### Tier 0 (Start)
**Available:**
- Basic commands: help, clear, status
- Navigation: files, ls, read, cat
- Easter eggs: donut, calc, notepad, matrix, snake

**Locked:**
- Player, scanner, tune, decode

**Progression:**
- Use "files" or "ls" → triggers checkTier()
- Read any file → triggers checkTier()
- Tier increases when conditions met

---

### Tier 1 (Basic Exploration)
**Requirements:**
- state.hasUsedLs = true (typed "files" or "ls")

**Available:**
- All Tier 0 commands
- search/grep commands
- File reading (manifest.log, system.log, frequencies.log)

**Locked:**
- Player, scanner, advanced commands

**Progression:**
- Read files to discover hints
- Read frequencies.log to learn about 97.7 & 108.0 MHz

---

### Tier 2 (Scanner Access)
**Requirements:**
- state.hasUsedLs = true
- state.hasReadFile = true (read any log file)

**Available:**
- scan command → Opens SCANNER.EXE
- player command → Opens PLAYER.EXE popup
- tune [frequency] → Direct frequency tuning
- decode [key] → Unlock tracks

**Locked:**
- Advanced meta commands (source, whoami, ping)

**Progression:**
- Use scanner to find signals
- Lock onto 97.7 MHz & 108.0 MHz
- Get unlock codes: SIGNAL, BENEATH
- Use decode to unlock tracks

---

### Tier 3 (Advanced Access)
**Requirements:**
- Tier 2 unlocked
- Signals discovered
- Progress through scanner mechanics

**Available:**
- source → Shows partial master code hint
- whoami → Meta command
- ping → Network simulation
- secrets → Lists found secrets

**Locked:**
- Nothing specific, but full completion requires Tier 4

**Progression:**
- Find all signals
- Discover master code: OMNISCIENT
- Use decode OMNISCIENT

---

### Tier 4 (Master Unlock)
**Requirements:**
- decode OMNISCIENT command used

**Available:**
- All tracks unlocked
- All systems accessible
- Full game completion

---

## SIGNAL FREQUENCIES

### SIGNAL 1: SIGNAL
```
Frequency:  97.7 MHz
Amplitude:  70
Tolerance:  ±1.5 MHz (freq), ±12 (amp)
Unlock:     SIGNAL
Track:      RC-005 "ONE LAST DRINK"
Type:       FM transmission
Details:    10kHz BW, Gain 65-75, Band-pass filter, SNR >12dB
```

### SIGNAL 2: BENEATH
```
Frequency:  108.0 MHz
Amplitude:  85
Tolerance:  ±1.5 MHz (freq), ±12 (amp)
Unlock:     BENEATH
Track:      RC-006 "SUNDEE ARVO"
Type:       SSB transmission
Details:    5kHz BW, Gain 80-95, Low-pass filter, SNR >8dB
```

### SIGNAL 3: VOID
```
Frequency:  115.3 MHz
Amplitude:  45
Tolerance:  ±2.0 MHz (freq), ±15 (amp)
Unlock:     VOID
Track:      (Future/placeholder)
Type:       Digital transmission
Details:    25kHz BW, Gain 45-60, Notch filter, SNR >6dB
```

### Scanner Mechanics
```
1. Open scanner: "scan" command
2. Adjust knobs:
   - Frequency: 80-120 MHz (drag to rotate)
   - Amplitude: 0-100 (drag to rotate)
3. Click "PING" button
4. Watch echoes appear:
   - Distance from center = frequency match
   - Echo power (0-100%) shown in ECHOES window
5. Adjust based on hints:
   - "Adjust FREQUENCY"
   - "Adjust AMPLITUDE"
   - "Adjust BOTH"
   - "Almost there!"
6. When power >90% → "LOCK" button enables
7. Click "LOCK" to lock signal
8. Terminal shows unlock code
9. Use "decode [code]" to unlock track
```

---

## UNLOCK CHAINS

### Track Unlock Flow
```
START
  │
  ├─ RC-001: CASINO (visible, unlocked from start)
  ├─ RC-002: DRUNK N STUMBLIN (visible, unlocked)
  ├─ RC-003: DESTROY ARCHITECTURE (visible, unlocked)
  └─ RC-004: COULD BE WORSE (visible, unlocked)
            │
            ▼
   ┌──────────────────┐
   │ Scanner unlocks  │
   └──────────────────┘
            │
            ├─> Find 97.7 MHz @ amp 70
            │   └─> Lock signal → reveals "SIGNAL"
            │       └─> decode SIGNAL
            │           └─> RC-005: ONE LAST DRINK (unlocked)
            │
            └─> Find 108.0 MHz @ amp 85
                └─> Lock signal → reveals "BENEATH"
                    └─> decode BENEATH
                        └─> RC-006: SUNDEE ARVO (unlocked)
                                │
                                ▼
                        ┌──────────────────┐
                        │ Find master code │
                        └──────────────────┘
                                │
                                ├─> Read source code: "source" command
                                │   └─> Partial hint: "OMNISCIENT is the word..."
                                │
                                └─> decode OMNISCIENT
                                    └─> RC-007: GG (secret track unlocked)
                                        └─> ALL TRACKS UNLOCKED
```

### Radar Unlock
```
Scanner opened (Tier 2)
    │
    └─> Lock FIRST signal (any frequency)
        └─> state.radarUnlocked = true
            └─> RADAR toggle button enables
                └─> Can open RADAR.EXE window
                    └─> Click on radar to position cursor
```

---

## SECRET CODES

### Gallery PIN Codes
```
1337  → "RECORDING SESSION" image
9775  → "FREQUENCY MAP" image
1984  → "LIVE PERFORMANCE" image
0420  → "ALBUM ART" image
```

### Konami Code
```
Sequence: ↑ ↑ ↓ ↓ ← → ← → B A
Result:   Unlocks "BEHIND THE SCENES" gallery image
```

### Hidden Commands
```
REDACTED           → Jurassic Park error (shows jpark.gif for 10s)
                     "Uh uh uh! You didn't say the magic word!"
                     (For testers who bypass progression)

OMNISCIENT         → Master unlock code
                     Unlocks all tracks, sets tier to 4

reality/wake/truth → Zoom out effect (meta easter egg)
                     Reveals terminal is in server room
                     Shows "TERMINAL 07 - SERVER RACK 3B"
```

### Secret Tracking
```javascript
// Secrets are added via addSecret(code)
// Tracked in CONFIG.secrets.codesFound array
// Total: 10 secrets

Secrets:
1. LS              → Used "files" or "ls" command
2. CAT_MANIFEST    → Read manifest.log
3. CAT_SYSLOG      → Read system.log
4. CAT_FREQ        → Read frequencies.log
5. SOURCE          → Used "source" command
6. MASTER_KEY      → Used OMNISCIENT master unlock
7. REALITY_CHECK   → Used reality/wake/truth command
8-10. (PIN codes, Konami, gallery unlocks)
```

---

## COMMANDS REFERENCE

### Navigation & Files
```
help          - Show all commands
clear         - Clear terminal output
files / ls    - List directory contents (triggers Tier 1)
read [file]   - Read log files (manifest, system, frequencies)
cat [file]    - Alias for read
status        - Show system status (tier, tracks, secrets)
```

### Player
```
player        - Open PLAYER.EXE popup
music         - Alias for player
play [n]      - Play track by number
pause         - Pause playback
stop          - Stop playback
next          - Next track
prev          - Previous track
vol [0-100]   - Set volume
format        - Toggle WAV/MP3 format
```

### Scanner (Tier 2+)
```
scan          - Open SCANNER.EXE
tune [freq]   - Tune to specific frequency (97.7 or 108.0)
decode [key]  - Decode unlock key (SIGNAL, BENEATH, OMNISCIENT)
```

### Advanced (Tier 3+)
```
source        - Show partial master code hint
secrets       - List found secrets
whoami        - Identity query (meta command)
ping          - Network ping simulation
search [term] - Search system logs
grep [term]   - Alias for search
```

### Mini-games & Tools
```
snake         - Open SNAKE.EXE game
calc          - Open CALC.EXE calculator
notepad       - Open NOTEPAD.EXE
matrix        - Open MATRIX.EXE screensaver
donut         - Open DONUT.EXE (spinning ASCII donut)
pincode / pin - Open SECURE.EXE (PIN code entry)
gallery       - Open GALLERY.EXE
photos        - Alias for gallery
```

### Easter Eggs
```
gandalf       - Toggle PIXL-BOY character visibility
divine        - Get hints from PIXL-BOY
hint          - Context-aware hints
donut         - Feed donut to PIXL-BOY (makes him happy)

REDACTED      - Jurassic Park error message
reality       - Meta zoom-out effect
wake          - Alias for reality
truth         - Alias for reality

echo [text]   - Echo text (special behavior with "redacted")
rm            - Permission denied + paranoia
sudo          - Nice try + paranoia
exit          - "There is no exit."
quit          - "You can't leave."
```

---

## STATE MANAGEMENT

### Core State Object
```javascript
let state = {
  // Playback
  currentTrack: -1,
  isPlaying: false,

  // Progression
  tier: 0,                    // 0-4, progression level
  discovered: new Set(),      // Unlocked track IDs
  wrongAttempts: 0,           // Failed decode attempts
  paranoia: 0,                // Affects glitch intensity

  // Flags
  bootComplete: false,
  playerVisible: false,
  headerRevealed: false,
  welcomeDismissed: false,
  sidebarOpen: false,
  playerOpened: false,
  radarUnlocked: false,

  // Progress tracking
  hasUsedLs: false,           // Triggers Tier 1
  hasReadFile: false,         // Triggers Tier 2
  hasScanned: false,
  hasTuned: false,

  // UI
  commandHistory: [],
  historyIndex: -1,
  glitchCount: 0
}
```

### Config Object
```javascript
const CONFIG = {
  artist: 'REDACTED CLUB',
  format: 'wav',              // 'wav' or 'mp3'
  audioPath: './redacted_assets/audio/',

  tracks: [
    // 7 tracks total (see Track Unlock Flow above)
  ],

  secrets: {
    codesFound: [],           // Array of found secret codes
    totalCodes: 10,           // Total secrets in game
    masterCode: 'OMNISCIENT'  // Changed from 'REDACTED'
  }
}
```

### Scanner State
```javascript
let scannerState = {
  frequency: 97.7,            // 80-120 MHz
  amplitude: 50,              // 0-100
  scanning: false,
  lockedSignals: [],          // Array of locked signal objects
  canvas: null,
  radarCanvas: null,
  ctx: null,
  radarCtx: null,
  animationFrame: null
}
```

---

## TESTING SHORTCUTS

### Quick Unlock All
```javascript
// In browser console:
COMMANDS.unlockAll()  // Uses OMNISCIENT master code
// OR type in terminal:
decode OMNISCIENT
```

### Set Tier Directly
```javascript
// In browser console:
state.tier = 4
checkTier()
```

### Unlock Specific Track
```javascript
// In browser console:
state.discovered.add('RC-005')  // ONE LAST DRINK
state.discovered.add('RC-006')  // SUNDEE ARVO
state.discovered.add('RC-007')  // GG (secret)
```

### Add All Secrets
```javascript
// In browser console:
addSecret('LS')
addSecret('CAT_MANIFEST')
addSecret('CAT_SYSLOG')
addSecret('CAT_FREQ')
addSecret('SOURCE')
addSecret('MASTER_KEY')
addSecret('REALITY_CHECK')
```

### Unlock Radar
```javascript
// In browser console:
state.radarUnlocked = true
document.getElementById('radar-toggle-btn').style.background = 'rgba(0,255,65,0.1)'
document.getElementById('radar-toggle-btn').textContent = '📡 RADAR'
```

### Test Signal Lock
```javascript
// In browser console:
scannerState.frequency = 97.7
scannerState.amplitude = 70
// Then click PING and LOCK in scanner
```

---

## WALKTHROUGH (SPOILERS)

### Minimum Steps to Complete
```
1.  help
2.  files
3.  read manifest
4.  read system
5.  read frequencies
6.  scan
7.  [Adjust knobs to 97.7 MHz, amp 70]
8.  [Click PING until power >90%]
9.  [Click LOCK]
10. decode SIGNAL
11. [Adjust knobs to 108.0 MHz, amp 85]
12. [Click PING until power >90%]
13. [Click LOCK]
14. decode BENEATH
15. source
16. decode OMNISCIENT
17. player
```

### All Gallery Unlocks
```
1. pincode → Enter 1337
2. pincode → Enter 9775
3. pincode → Enter 1984
4. pincode → Enter 0420
5. Press: ↑ ↑ ↓ ↓ ← → ← → B A
```

### All Easter Eggs
```
1. donut
2. reality (or wake/truth)
3. REDACTED
4. gandalf
5. divine
6. snake
7. calc
8. notepad
9. matrix
```

---

## FILE STRUCTURE

```
redacted_club_project/
├── redacted_player.html          # Main game file (~3000 lines)
├── README.txt                     # User guide (with spoilers section)
└── redacted_assets/
    ├── audio/
    │   ├── Casino.wav
    │   ├── DnS.wav
    │   ├── DA.wav
    │   ├── Could Be 5.wav
    │   ├── One Last Drink 2.wav
    │   ├── Sundee Arvo.wav
    │   └── GG.wav                # Secret track
    ├── gallery/
    │   ├── [6 unlockable images]
    │   └── source.pdn            # Paint.NET source
    └── images/
        └── GIFs/
            └── jurassic-park.gif  # REDACTED easter egg
```

---

## KNOWN ISSUES & QUIRKS

- **Play/Pause Button**: Now fixed - properly toggles state
- **Radar Accuracy**: Intentionally imperfect for difficulty
- **REDACTED Code**: Shows Jurassic Park error, doesn't unlock anything
- **Master Code**: Changed from REDACTED → OMNISCIENT
- **Format Toggle**: WAV files exist, MP3 placeholders
- **Zoom Effect**: Works but needs custom server room assets

---

## NEXT STEPS / TODO

- [ ] Create number station audio files for signals
- [ ] Add spectrogram messages in signal audio
- [ ] Design custom server room background for zoom effect
- [ ] Additional gallery images
- [ ] More easter eggs?
- [ ] Achievement system?

---

**Last Updated:** 2026-02-06
**Version:** 1.0 (Sonar Scanner Build)
