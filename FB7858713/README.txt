# Incorrect background color in view-based NSMenuItem with enabled "Reduce transparency" on macOS Catalina

Area: AppKit
Type: Incorrect/Unexpected Behavior

When displaying an NSMenuItem with a transparent custom view in an NSMenu while having the "Reduce transparency" accessibility option enabled, the view has a different background color than the upper and lower segments of the menu, as well as separators and other text-based menu items.

Steps:
1. Enable "Reduce transparency" accessibility option in System Preferences > Accessibility > Display.
2. Run the Mac app from the attached Xcode project MenuItemViewWithReducedTransparency.
3. Click the pop-up button in the window.

Expected:
The view-based menu item, as well as other parts of the menu, have the same background color.

Actual:
The view-based menu item has a different color than the other parts of the menu. See attached screenshot.

The described problem occurs on macOS 10.15.5 (19F101), see the attached sysdiagnose file. There is no issue when "Reduce transparency" is disabled, see second attached screenshot. Moreover, on macOS 11.0 (first beta), everything works fine.
