# Preventing expired TestFlight apps from launching

Area: TestFlight
Type: Suggestion
TestFlight used on: macOS, App Store Connect

TestFlight is a great way for distributing beta versions and, since Fall 2021, it's also available for Mac apps. As stated in App Store Connect documentation (https://help.apple.com/app-store-connect/#/dev82e9b4303), each beta build expires 90 days after the upload, and it can be expired manually by the developer. While the expiration prevents testers from installing the builds, they can further use already installed builds indefinitely.

This behavior opens up space for circumventing the payment for the production app in the Mac App Store. To prevent this, an additional in-app expiration has to be built, which adds additional work for the developer. We'd like to see a built-in mechanism to prevent expired builds from launching. A dialog with the appropriate message could be shown when running the app that forwards the user to the TestFlight app.

A decent in-between solution could be introducing a check for the expired state of the build from within the application. While this would still require a custom expiration implementation, it would be much simpler.
