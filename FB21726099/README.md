# Liquid Glass toolbar item glitch after light/dark mode switch

- Platform: iOS
- Area: SwiftUI
- Type: Incorrect/Unexpected Behavior
- Build: iOS 26.2 (23C55)

## Summary

When placing glass-styled toolbar items in the navigation bar with visible toolbar background and color applied, they don't correctly update their appearance when switching between light/dark mode. They sample from the toolbar background only initially, but after a mode switch, they sample the content view's background instead (e.g. a colored background behind a `List`).

## Steps to Reproduce

1. Set system to light mode with Liquid Glass set to Clear
2. Run the attached Xcode project
3. Observe the toolbar items (correct appearance with white toolbar background)
4. Switch to dark mode via Settings or Control Center
5. Observe the toolbar items (incorrect glass appearance, sampling yellow content background instead of black toolbar background)

## Expected Behavior

Toolbar items should sample their glass appearance from the toolbar background color set via `.toolbarBackground(…)`, not from content views behind them.

## Actual Behavior

After switching to dark mode, the toolbar items get incorrect glass appearance, by sampling the yellow background extending into the navigation bar area.

The bug only manifests when switching between light and dark mode. The initial appearance on app launch is correct. Killing and relaunching the app restores the correct appearance until the next dark mode switch. (It works the same for the light mode when using a darker background color.)

See the attached Simulator recordings demonstrating the issue when starting in light mode and dark mode. The mode is switched using Cmd+Shift+A.

| Starting in Light Mode | Starting in Dark Mode |
|------------------------|----------------------|
| <video width="300" src="https://github.com/user-attachments/assets/090ca91f-1a12-45c0-bde8-bb128c0ac58e"></video> | <video width="300" src="https://github.com/user-attachments/assets/5ec6da01-678d-49f3-b6f5-04ee54990490"></video> |
