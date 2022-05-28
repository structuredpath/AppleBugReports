# Focus in StoreKit Purchase Alert on macOS

Area: StoreKit
Type: Incorrect/Unexpected Behavior

While implementing the purchase UI in my application, I noticed an unexpected behavior regarding the focus of the purchase alert on macOS Monterey.

When triggering a purchase via the StoreKit framework, an alert originating in a different process is brought on screen. However, the alert window is not made key as my application keeps the focus. This results in the primary button in the alert not being highlighted. One has to first interact with the alert to move the focus there. This appearance might confuse users as it’s not clear enough that the purchase flow continues in the alert.

Similarly, when the last alert is shown, and the purchase flow ends, the focus is not returned back to the application.

See the attached recording for an example from a local session in my application (with Xcode StoreKit testing enabled). However, this behavior can be observed with any 3rd party app from the Mac App Store that offers in-app purchases.
