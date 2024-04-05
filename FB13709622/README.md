# Persistent memory allocation issue in NSWindow's event logging

- Platform: macOS
- Area: Core Graphics
- Type: Incorrect/Unexpected Behavior

## Summary

We are experiencing an issue with persistent memory allocation in the internals of `NSWindow` when receiving a high volume of events that target that window. Even when configuring the window with `ignoresMouseEvents` set to `true` and `acceptsMouseMovedEvents` to `false` and not doing any event handling, it seems the window still receives mouse move events at a lower level. According to our tests, the issue appears to be linked to the internal logging of these incoming events, namely the routine called `CGSEventLogEvent`. See the attached screenshot of the Heaviest Stack Trace from an Instruments session.

![](/FB13709622/CGSEventLogEvent.png)

## Issue Reproduction

1. Create an `NSWindow` and configure it according to the description from above.
2. Expose the window to a high volume of mouse move events.
3. Observe the memory allocation in relation to `CGSEventLogEvent` in Instruments.

## Environment

Tested in Xcode 15.3 on macOS 14.4.1 Sonoma in both the debug mode and release mode with an attached debugger.
