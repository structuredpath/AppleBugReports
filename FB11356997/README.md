# Severe regression with animating `UIHostingController` using UIKit animation techniques

- Area: SwiftUI Framework
- Type: Incorrect/Unexpected Behavior

When wrapping a SwiftUI view into a `UIHostingController`, embedding it into a UIKit context, and animating the wrapping `UIView` using UIKit animation techniques (e.g. `UIViewPropertyAnimation`), the hosted SwiftUI view is not animated correctly. This behavior seems to be a regression in the current betas of iOS 16 (observed with β6 and β7) as it works perfectly fine with iOS 15.6.

The faulty behavior is demonstrated in the attached sample project. It uses the UIKit app lifecycle and contains a single `UIViewController`. The view controller embeds a container view which in turn embeds the view of a `UIHostingController`. The container view uses the old-fashioned frame layout, and the hosting controller’s view is embedded using Auto Layout. We applied coloring to help visualize the issue. The background of the hosting controller’s view is set to gray, and the SwiftUI view is colored red.

When applying a spring animation to the height of the container view via `UIViewPropertyAnimator`, the expected outcome is that the red rectangle (SwiftUI view) bounces, and the gray background (`UIHostingController`’s view) is not visible at all. This is exactly what happens on iOS 15.6, as shown in the attached video.

However, on iOS 16 β7, the height of the red rectangle (SwiftUI view) jumps immediately to the final value, and the gray background (`UIHostingController`’s view) performs the animation in the background. This is shown in the second video. Also, see the results side-by-side in the third video.

| iOS 15.6 | iOS 16 β7 | Comparison |
| --- | --- | --- |
| <video src="https://user-images.githubusercontent.com/533299/186359528-071c5862-e349-4cbd-9e47-a4c22ef5e647.mp4"> | <video src="https://user-images.githubusercontent.com/533299/186359609-122c80f6-19a1-49d6-b8c2-35725ee6bc92.mp4"> | <video src="https://user-images.githubusercontent.com/533299/186359622-712b6fe2-3585-4bdf-87ea-78963a548b49.mov"> |

For such a simple example, there are workarounds we could employ. For instance, we could move the whole animation into the SwiftUI context. However, there are spots in UIKit where this isn’t viable, like using the `UIHostingController` with the `UISheetPresentationController`.

We believe this is a severe regression that should be addressed before releasing the current iteration of SwiftUI as part of iOS 16.
