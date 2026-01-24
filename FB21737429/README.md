# Shadow clipping during zoom transition from sheet to toolbar item

- Platform: iOS
- Area: SwiftUI
- Type: Incorrect/Unexpected Behavior
- Build: iOS 26.3 Seed 2 (23D5103d)

## Summary

When dismissing a sheet that uses `.navigationTransition(.zoom(sourceID:in:))` with a toolbar item as the transition source (bottom bar or navigation bar), the shadow around the toolbar item the sheet is morphing into gets clipped at a square region offset from the button.

## Steps to Reproduce

1. Run the attached Xcode project in light mode (device or simulator)
2. Tap the square button in the bottom right toolbar
3. Tap the dimmed area above the sheet
4. Observe the transition animation at the toolbar item

## Expected Behavior

The zoom transition should animate smoothly from the sheet to the toolbar item, with the shadow extending naturally without any clipping.

## Actual Behavior

The shadow around the toolbar item is clipped at a square region offset from the button, creating a harsh visual cutoff during the animation. See the attached screenshot highlighting the source element and the recording demonstrating the clipping artifact.

<img width="300" src="/FB21737429/Screenshot.png">
