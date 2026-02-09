SOUND EFFECTS LIBRARY
=====================

Organized by category for easy management.

Folder Structure:
-----------------
ui/           - Button clicks, menu sounds, typing
glitch/       - Static, corruption, error sounds
scanner/      - Ping, lock, echo, radar beeps
ambient/      - Background loops, room tone
easter_eggs/  - Hidden sound effects

Naming Convention:
------------------
[category]_[description]_[variant].mp3

Examples:
  ui_click_01.mp3
  ui_click_02.mp3
  glitch_heavy_01.mp3
  scanner_ping_01.mp3
  scanner_lock_success.mp3
  ambient_terminal_hum.mp3

Recommended Format:
-------------------
- MP3 (128-192kbps) for compatibility
- WAV for high quality (will be larger)
- Keep files SHORT (< 2 seconds for most UI sounds)
- Normalize volume levels across all SFX

Usage in Code:
--------------
playSFX('ui_click_01')
playSFX('glitch_heavy_01', 0.5)  // volume override
playSFX('scanner_ping_01')

See redacted_player.html for the SFX system implementation.
