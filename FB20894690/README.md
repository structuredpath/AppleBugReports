# Multiline selection fails with Shift + Arrow Up in TextKit 2

- Platform: macOS
- Technology: AppKit
- Type: Incorrect/Unexpected Behavior
- Build: macOS 15.7.2 (24G325)
- Occurs on: Device

When extending a text selection upward within a multiline paragraph using `Shift + ↑`, the interaction sometimes doesn’t work. This occurs under specific circumstances, typically when starting at the end of a wrapped paragraph and first selecting its last line. The behavior can be reproduced in TextEdit, Version 1.20 (409), whose `NSTextView` is likely backed by TextKit 2. By contrast, the same interaction works correctly in my own app Diagrams, which uses an `NSTextView` backed by TextKit 1 components.

## Steps to reproduce:

1. Open TextEdit or another TextKit 2–based text editor.
2. Enter a multiline paragraph.
3. Place the insertion point at the end of the last line.
4. Press `Command + Shift + ←` to fully select the last line.
5. Press `Shift + ↑` to extend the selection upward.

## Expected behavior:

The penultimate line should be added to the selection (both the last and penultimate lines selected).

## Actual behavior:

Nothing happens. Only the last line remains selected.

## Additional information:

- Reproducible on macOS Sequoia 15.7.1 (24G231).
- Not reproducible in TextKit 1–based editors.

A short screen recording demonstrating the issue in TextEdit is attached.

<video width="300" src="https://github.com/user-attachments/assets/35142ace-7f1e-459a-821d-5f4c17b95e27"></video>
