# Glitchy animation in the safe area of a List during keyboard dismissal

- Platform: iOS
- Area: SwiftUI Framework
- Type: Incorrect/Unexpected Behavior
- Build: iOS 17 RC Seed (21A329)

## Summary

During keyboard dismissal within a SwiftUI `List` that extends into a device's safe area (particularly seen on devices with a home indicator), a glitchy animation occurs. It seems that when the keyboard animates away, the `List` appears as though the safe area is not populated. Only upon the completion of the animation does the List properly extend into the safe area, as demonstrated by a red background in the attached recording.

This behavior can be observed on both the iOS 17 simulator and on physical devices, and reports suggest it was also present in iOS 16.

This issue might be related to these feedbacks related to animation issues I previously reported: FB11356997 and FB13206351

## Issue Reproduction

### Steps to Reproduce

1. Run the attached Xcode project.
2. Tap into the text field at the top to show the keyboard.
3. Tap the "Hide" button next to the text field to hide the keyboard.
4. Observe the issue with the animation in the bottom safe area of the list.

### Expected Result

The `List` should animate alongside the keyboard, smoothly reaching the screen's bottom edge without any disruptions.

### Actual Result

The `List` animates to a state excluding the safe area, and upon the animation’s completion, abruptly expands into the safe area.

## Code Sample

```swift
struct ContentView: View {
    
    @FocusState
    private var isFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                TextField("", text: .constant(""))
                    .border(.black)
                    .focused(self.$isFocused)
                
                Button("Hide") {
                    self.isFocused = false
                }
                .buttonStyle(.bordered)
            }
            .padding()
            
            List {
                ForEach(0..<50, id: \.self) { i in
                    Text("Row \(i)")
                }
            }
        }
        .background(.red)
    }
    
}
```

## Demo Recording

<video width="300" src="https://github.com/structuredpath/AppleBugReports/assets/533299/0017d489-a11a-46a1-afd5-7367763c040c"></video>

### Related Links

- [Stack Overflow: SwiftUI List Visual Bug with Keyboard and Safe Area](https://stackoverflow.com/q/74248686/670119)

---

Thanks for getting back to me.

The glitchy animation is indeed gone now. However, when hiding the keyboard, it now disappears instantly without any animation. This is new behavior and not expected. The keyboard should animate away when dismissed, so the issue is still not resolved.

Other developers have reported this specific issue with the missing hide animation here:
- https://developer.apple.com/forums/thread/798476
- https://github.com/facebook/react-native/issues/53626

Tested in the Simulator of Xcode 26.1 beta 3 on macOS Sequoia 15.7.1.

I had also hoped this would address the broader animation issues I originally reported in FB14265721, which have been around since iOS 17. That does not seem to be the case. It is becoming increasingly frustrating to see regressions like this persist across major iOS versions while new ones are introduced.

<video width="300" src="https://github.com/user-attachments/assets/048dd1c0-3cb7-494d-a18e-cfac2cbe649d"></video>
