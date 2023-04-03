# Faulty Preference Value Propagation with NSViewRepresentable and UIViewRepresentable in Stacks

- Area: SwiftUI Framework
- Type: Incorrect/Unexpected Behavior

I’m encountering an issue related to preference value propagation when using `NSViewRepresentable` (macOS) and `UIViewRepresentable` (iOS) views within stacks in SwiftUI. The problem arises when a combination of SwiftUI views and `NSViewRepresentable` or `UIViewRepresentable` views are present in the same stack. If a SwiftUI view that sets a preference value is followed by an `NSViewRepresentable` or `UIViewRepresentable` view within the stack, the preference value propagation is incorrect.

Two sample projects illustrating this issue are attached to this report: _PreferenceWithNSViewRepresentableIssue_ (macOS) and _PreferenceWithUIViewRepresentableIssue_ (iOS). In both projects, we have two cases:

1. A `VStack` containing a SwiftUI view (`Color.red`) that sets a preference value, followed by an `NSViewRepresentable` or `UIViewRepresentable` view (`SomeNSViewRepresentable` or `SomeUIViewRepresentable`).
2. A `VStack` with an `NSViewRepresentable` or `UIViewRepresentable` view (`SomeNSViewRepresentable` or `SomeUIViewRepresentable`) followed by a SwiftUI view (`Color.red`) that sets a preference value.

The expected output when running the example code should display the preference values set in both cases as follows:

Value from Case 2
Value from Case 1

However, the preference value for Case 1 is not propagated correctly, and the default value is printed instead. The actual output is:

Value from Case 2
Default Value

Tested with Xcode 14.2 and 14.3.
