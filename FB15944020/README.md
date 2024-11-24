# App window focus bug with context menu on macOS 14 and 15

- Platform: macOS
- Area: AppKit
- Type: Incorrect/Unexpected Behavior
- Build: 15.1 Seed 6 (24B5070a)

When dismissing a context menu by clicking in an app’s window while the app is _inactive_, the app activates but its window doesn’t properly gain focus, leaving it in a broken state where text fields lack a cursor, use the inactive selection color, and the app reports no key or main window.

Switching to another app and back seems to be the only way to exit this broken state.

The issue occurs on macOS 14.6 Sonoma and macOS 15.1 Sequoia but works correctly on macOS 12.7 Monterey, where the app’s window gains focus after the second click.

## Steps to reproduce:

1. Open an app (e.g. Keynote) and switch to another app (e.g. TextEdit) to make it inactive.
2. Right-click in the app’s window to open a context menu. → The app correctly isn’t activated.
3. Click the app’s window to dismiss the context menu. → The app gets correctly activated.
4. Interact with the app’s window and try entering text fields.

## Expected behavior:

The app focuses the clicked window, showing a visible cursor in text fields, with active selection color.

## Actual behavior:

The app makes the clicked window appear as focused, but it actually doesn’t gain focus. Text fields lack a cursor, and selection appears in the inactive color.

## Additional information:

This issue may be related to changes in menu handling introduced in macOS 14.

Attached are two recordings: one demonstrating the issue in Keynote and another showing it in my app, Diagrams, where I print the responder chain for each step.
