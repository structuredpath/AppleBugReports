# Enrich NSScrollView responsive scrolling API to allow for programmatic cancellation

Area: AppKit
Type: Application Slow/Unresponsive

This feedback is a fresh update to FB6108756, which was converted from the Radar 51328335 in June 2019 and got very long due to some problems with the newly introduced Feedback Assistant platform.

In macOS Mavericks, the responsive scrolling architecture for NSScrollView introduced a smart way for generating overdraws, and it decoupled the handling of incoming scroll events from the main event look into a dedicated loop. This feature was presented in session 215 of WWDC 2013.

Due to the differences in the event handling model, the scroll events no longer go through the scrollWheel(with:) method of NSScrollView. In fact, if this method gets overridden in an NSScrollView subclass or the document view, the responsive scrolling architecture gets disabled, and the scrolling falls back to the legacy model.

The usage of responsive scrolling can be enforced by returning true from isCompatibleWithResponsiveScrolling. In that case, scrollWheel(with:) is called at least once, providing a hook. Once the event is passed to super, the responsive scrolling event loop is entered, and it’s no longer possible to access the scroll events, nor is it possible to control the event loop in any way.

It is common for diagramming applications to interpret scroll events with pressed Command modifier key as magnification events. Even if it’s possible to observe the change of the modifier key, there is no way to exit the responsive scrolling interaction programmatically. Such an API would be very handy in order to switch from scrolling into magnification and back fluidly.

Please see the attached sample code.

Steps:
1. Run the Mac app from the attached Xcode project ResponsiveScrollingModifierMagnification.
2. Move the mouse to the scroll view, press and hold the command key and begin scrolling (with a single finger on a Magic Mouse or with two fingers on a trackpad).
3. Without lifting the fingers, release the command key and continue the scroll gesture.
4. Press and hold the command key again and continue the scroll gesture.

Expected:
1. The Mac app is launched.
2. The scroll view is not scrolled. Instead, the messages for handling the scroll event as magnification are printed.
3. The actual scrolling starts and goes on.
4. The scrolling stops and the messages for handling the scroll event as magnification are printed again.

Actual:
1. ✔︎
2. ✔︎
3. ✔︎
4. The scrolling does not stop, and there is no API to achieve it.

—————

In the previous feedback (FB6108756), you suggested to opt-out from the compatibility with responsive scrolling and to handle the scroll events ourself. According to your statement, it should still be possible to take advantage of the overdraw functionality. 

We tried disabling responsive scrolling, but we ended up with a sluggish scrolling experience. We linked some videos in the mentioned feedback, but now, we’re providing an ad-hoc version of our app, Diagrams (https://diagrams.app). One binary has responsive scrolling enabled (the default) and the other disabled.

You offered to profile the binaries to see what causes the performance issues, and we’d like to ask you to do so. We’d like to learn how to improve the scrolling performance with disabled responsive scrolling OR how to terminate scrolling while handling scroll events on the detached queue (as previously requested).
