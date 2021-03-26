# Titlebar separator glitches in an NSWindow with a toolbar and scroll view

Area: AppKit
Type: Incorrect/Unexpected Behavior

When programmatically creating an NSWindow, populating it with an empty NSToolbar and NSScrollView as its content view, and setting its titlebarSeparatorStyle to .shadow or .line, the separator gets rendered at wrong positions when resizing the window.

Steps:
1. Run the Mac app from the attached Xcode project TitlebarSeparatorScrollViewTest.
2. Drag the window at the lower-right corner and quickly resize it to a different size.

Expected:
The titlebar separator stays attached to the toolbar during the whole interaction.

Actual:
The titlebar separator jumps to random vertical offsets and settles into its final position only after performing yet another action (e.g. moving the window or bringing it to the foreground).

See the attached video to view the glitch in action. The described problem occurs on macOS 11.2.3 (20D91). See the attached sysdiagnose file.
