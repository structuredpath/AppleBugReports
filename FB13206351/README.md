# Glitchy animation when programmatically switching detents in SwiftUI

- Platform: iOS
- Area: SwiftUI Framework
- Type: Incorrect/Unexpected Behavior
- Build: iOS 17 RC Seed (21A329)

## Summary

In iOS 16, several new APIs for configuring sheet presentation were introduced, including the ability to set detents. When a sheet is configured with multiple detents, users can either drag or tap the handle to resize it and make it snap to one of the available detents. Additionally, it’s possible to provide a binding for the currently selected detent. While this binding correctly reports the current value, when changing it, i.e. programmatically setting the current detent, the animation of the content view is glitchy. It seems that the view is immediately resized to its final size and only its enclosing sheet animates. This issue might be related to FB11356997.

## Issue Reproduction

### Steps to Reproduce

1. Run the attached Xcode project.
2. Tap the “Toggle Sheet Detent” button repeatedly.
3. Observe the issue with the animation of the sheet’s content, i.e. the yellow region.

### Expected Result

The yellow content view inside the sheet smoothly animates to its final position, similar to tapping the drag indicator.

### Actual Result

The yellow content view immediately changes its size to its final value, leading to a broken animation and also showing a white background when transitioning from the large to the small detent.

## Code Sample

```swift
struct ContentView: View {
    
    @State
    private var selectedDetent = PresentationDetent.height(100)
    
    var body: some View {
        Color.red
            .ignoresSafeArea()
            .sheet(isPresented: .constant(true)) {
                Color.yellow
                    .overlay {
                        Button("Toggle Sheet Detent") {
                            if self.selectedDetent == .height(100) {
                                self.selectedDetent = .large
                            } else {
                                self.selectedDetent = .height(100)
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    .ignoresSafeArea()
                    .presentationDetents(
                        [.height(100), .large],
                        selection: self.$selectedDetent
                    )
                    .interactiveDismissDisabled()
            }
    }
    
}
```

## Demo Recording

<video width="300" src="https://github.com/structuredpath/AppleBugReports/assets/533299/2f6c5e8f-36d6-47f6-9f00-2fd0e14d14de">

## Environment

- iOS 17
- Xcode 15 RC
- iOS Simulator / iPhone SE 3rd Gen / iPhone 12 / iPhone 13 mini
