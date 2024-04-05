# Persistent memory allocation issue in Observation framework

- Platform: macOS
- Area: Observation Framework
- Type: Incorrect/Unexpected Behavior

## Summary

We have identified a memory allocation issue when using the Observation framework with SwiftUI. Through detailed analysis using Xcode’s Memory Graph and Instruments, we observed a correlation between memory growth and the number of evaluations of SwiftUI view bodies. The results hint at the retention of Observation-related objects that are referenced from the `ObservationTracking._installTracking(_:willSet:didSet:)` method. The issue is particularly noticeable during frequent view updates.

## Code

```swift
import SwiftUI

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView(model: ContentModel())
        }
    }
}

@Observable
class ContentModel {
    var flag = false
}

struct ContentView: View {
    let model: ContentModel
    
    @State
    private var count = 0
    
    var body: some View {
        // Access a property on the observable object in the view body.
        let _ = self.model.flag
        
        ZStack {
            Text("\(self.count)")
                .font(.largeTitle)
        }
        .task {
            for i in 0..<10_000_000 {
                do {
                    try await Task.sleep(for: .milliseconds(10))
                    self.count = i
                } catch {}
            }
        }
    }
}
```

## Issue Reproduction

### In Xcode

1. Open the attached project `ObservationMemoryAllocationIssue` in Xcode.
2. Run the app in debug mode (default scheme).
3. Switch to the debug session view and observe how the memory grows (~0.1/s on a MacBook Pro 16“ 2021 with M1 Pro).
4. Pause the execution and create a memory snapshot via „Debug Memory Graph“.
5. Search for entries related to the Observation framework in the list within the Debug navigator (see attached screenshot).
6. Compare the number of allocated objects with the number of SwiftUI view’s body evaluations.

![](/FB13709464/screenshot-memory-graph.png)

### In Xcode & Instruments

1. Open the attached project `ObservationMemoryAllocationIssue` in Xcode.
2. Profile the app in release mode (default scheme) using the Allocation instrument.
3. Let the app run for a while.
4. Select a phase after the app initialization.
5. Inspect the heaviest stack trace that refers to `ObservationTracking._installTracking(_:willSet:didSet:)` (see attached screenshot).

![](/FB13709464/screenshot-instruments.png)

## Environment

Tested in Xcode 15.3 on macOS 14.4.1 Sonoma in both the debug mode and release mode with an attached debugger.