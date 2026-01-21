# Liquid Glass sheet material clips during detent transitions

- Platform: iOS
- Area: SwiftUI
- Type: Incorrect/Unexpected Behavior
- Build: iOS 26.2 (23C55)

## Summary

When a sheet is presented with `.large` and a custom smaller detent (e.g. `.height(100)`), tapping the drag indicator to transition from large to the smaller detent causes a visual glitch. The Liquid Glass background material clips incorrectly mid-animation, showing the upper portion with normal transparency and the lower portion becoming nearly fully transparent.

## Steps to Reproduce

1. Run the attached Xcode project
2. Drag the sheet up to large detent
3. Tap the drag indicator (not drag, just tap)

## Expected Behavior

Smooth animation of sheet and background material from large to smaller detent.

## Actual Behavior

Background material clips mid-animation. The upper portion retains normal appearance while lower portion becomes nearly fully transparent before snapping to final state.

## Notes

- Dragging the indicator works correctly.
- Only tapping or programmatic detent changes exhibit the glitch.
- Running in Simulator with Slow Animations (Debug → Slow Animations) clearly shows the bug. See attached recording.
- Occurs on iOS 26.2 with Xcode 26.2 (17C55), Simulator and device.
- Possibly related to FB13206351, which I reported a while back (glitchy animation when programmatically switching detents).

## Code Sample

```swift
struct ContentView: View {
    @State private var sheetDetent = PresentationDetent.bar

    var body: some View {
        Color.red
            .ignoresSafeArea()
            .sheet(isPresented: .constant(true)) {
                Color.clear
                    .presentationDetents([.bar, .large], selection: $sheetDetent)
                    .presentationDragIndicator(.visible)
                    .presentationBackgroundInteraction(.enabled)
                    .interactiveDismissDisabled()
            }
    }
}

extension PresentationDetent {
    static let bar = Self.height(100)
}
```

## Demo Recording

<video width="300" src="https://github.com/user-attachments/assets/a8ec53eb-3b8b-48d9-89a2-8327bb54cf50"></video>
