# Ongoing Issues with SwiftUI Animations in UIKit Context

- Platform: iOS
- Area: SwiftUI
- Type: Incorrect/Unexpected Behavior
- Build: iOS 18 Seed 3 (22A5307f)

Since iOS 16 betas, I have been experiencing persistent issues with SwiftUI animations when integrating SwiftUI views within UIKit contexts. I filed several feedbacks (FB11356997, FB13206351, FB13228246), which all seem to be related. The issue spans using `UIPropertyAnimator` directly with a `UIHostingController`, toggling keyboard animations, and switching sheet detents.

After conducting tests in the Simulator with iOS 18 β3 in Xcode 16 β3, I noticed that the issues still remain unresolved, which severely impacts the smoothness and reliability of animations, degrading the user experience. The introduction of new `SwiftUI.Animation`-related APIs in UIKit at WWDC 2024 didn't make any difference.

I am seeking possible workarounds or confirmation if using UIKit exclusively is the only reliable solution for proper animation behavior as of now. Thank you for your attention to these ongoing concerns.
