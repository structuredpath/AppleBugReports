# SwiftUI sheets not correctly deinitializing associated instances

- Platform: iOS
- Area: SwiftUI Framework
- Type: Incorrect/Unexpected Behavior
- Build: iOS 17 RC Seed (21A329)

## Summary

When a SwiftUI sheet is dismissed (e.g. by swiping down or clearing the binding responsible for its presentation), instances associated with the view, such as view models, are not being deinitialized as expected. These objects seem to be held internally by SwiftUI, which might lead to memory leaks and incorrect behavior in expecting the instances to be released (e.g. long-living tasks).

## Issue Reproduction

### Steps to Reproduce

1. Create a SwiftUI view with a sheet presentation.
2. Attach a view model (or other object instance) to the sheet's content view in its initializer—either via `@ObservedObject` or the new `@Observable` macro.
3. Implement a `deinit` method in the view model (or object instance) for tracking.
4. Present and then dismiss the sheet by swiping down.

### Expected Result

The `deinit` method in the associated instance should be called, indicating that the object has been deinitialized and memory has been reclaimed.

### Actual Result

The `deinit` method is not called, suggesting that the object remains in memory. This can be further confirmed by creating a snapshot of the memory graph.

## Code Sample

### Example Using `@ObservableObject`

```swift
struct ContentView: View {
    @StateObject var model = ContentViewModel()
    
    var body: some View {
        Button("Show Sheet") {
            self.model.sheetViewModel = SheetViewModel()
        }
        .sheet(item: self.$model.sheetViewModel) { model in
            SheetView(model: model)
        }
    }
}

final class ContentViewModel: ObservableObject, Identifiable {
    @Published
    var sheetViewModel: SheetViewModel?
}

struct SheetView: View {
    @ObservedObject var model: SheetViewModel
    
    init(model: SheetViewModel) {
        self.model = model
    }
    
    var body: some View {
        Text("Sheet")
    }
}

final class SheetViewModel: ObservableObject, Identifiable {
    init() { print("\(Self.self).\(#function)") }
    deinit { print("\(Self.self).\(#function)") }
}
```

### Example Using `@Observable` Macro

```swift
struct ContentView: View {
    @State
    var sheetViewModel: SheetViewModel?
    
    var body: some View {
        Button("Show Sheet") {
            self.sheetViewModel = SheetViewModel()
        }
        .sheet(item: self.$sheetViewModel) { model in
            SheetView(model: model)
        }
    }
}

struct SheetView: View {
    let model: SheetViewModel
    
    init(model: SheetViewModel) {
        self.model = model
    }
    
    var body: some View {
        Text("Sheet")
    }
}

@Observable
final class SheetViewModel: Identifiable {
    init() { print("\(Self.self).\(#function)") }
    deinit { print("\(Self.self).\(#function)") }
}
```

## Environment

- iOS 17
- Xcode 15 RC
- iOS Simulator / iPhone SE 3rd Gen / iPhone 12 / iPhone 13 mini

## Related Links

- [Accompanying Stack Overflow Post](https://stackoverflow.com/questions/77098992/swiftui-sheets-not-correctly-deinitializing-associated-instances)
- [Confirmation by Point-Free team](https://pointfreecommunity.slack.com/archives/C04L7QT8L2Y/p1694628396518809?thread_ts=1694628096.065059&cid=C04L7QT8L2Y)
- [Confirmation by Apple on their forums](https://developer.apple.com/forums/thread/737967?answerId=767599022#767599022)
- Further references:
  - [SwiftUI Sheet never releases object from memory](https://stackoverflow.com/questions/77227252/swiftui-sheet-never-releases-object-from-memory)
  - [SwiftUI View leaks in iOS 17](https://stackoverflow.com/questions/77153299/swiftui-view-leaks-in-ios-17)
  - [Sergey Pershenkov on Mastodon](https://mas.to/@okla/110915814130579266)
  - [@schornon on GitHub](https://github.com/schornon/PresentationDetentsLeak/issues/1)
