# Rendering issue in scroll view with enabled layer-backing and responsive scrolling

Area: AppKit
Type: Incorrect/Unexpected Behavior

Our canvas-based app Diagrams (https://diagrams.app) uses an NSScrollView with enabled layer-backing and responsive scrolling. Its document view renders the canvas contents in a standard way using draw(_:). While working on the app, we noticed that if left in the background for a longer period of time and then brought to the foreground, the tiles outside the visible rectangle of the document view were no longer rendered when scrolling around. To trigger a re-render, it was necessary to interact with that part of the document view.

This issue was very hard to reproduce, but we were able to track it and reach the exact state after a simulation of memory pressure. However, it only occurred on older computers.

A list of computers where we could reproduce the issue:
- MacBookAir6,2 (8 GB RAM, macOS 10.15.5)
- MacBookPro11,2 (16 GB RAM, macOS 10.15.5)

A list of computers where we could NOT reproduce the issue:
- MacBookPro12,1 (8 GB RAM, macOS 10.14.6)
- MacBookPro16,1 (32 GB RAM, macOS 10.15.5)

Please see the attached Xcode project with a minimal example and the screenshots showing the expected and actual results after the final step.

Steps:
1. Open the attached Xcode project ResponsiveScrollingMemoryRenderingIssue on a Mac with a small amount of RAM (max 8 GB).
2. Build and run the sample app.
3. Scroll around a bit in the sample app.
4. Open Terminal.
5. Run the command `sudo memory_pressure -S -l critical` to simulate a memory pressure of a critical level.
6. Bring the sample app to the foreground.
7. Scroll a bit in the sample app again.

Expected:
The document view is wholly filled with orange color even when scrolling around after returning to the app after experiencing memory pressure.

Actual:
The document view is wholly filled with orange color until memory pressure occurs. Afterward, only the currently visible rectangle is filled with an orange color, and all other parts lying outside of the visible area after the app is brought to the front are rendered white, which is the background color of the scroll view.
