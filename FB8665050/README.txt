# Broken Manual Sorting of Schemes in Xcode 12

Area: Xcode
Type: Incorrect/Unexpected Behavior
Xcode Version: 12 β6 (12A8189n)

When sorting schemes in the schemes editor of Xcode 12 via drag and drop, the schemes editor's table isn't updated, although the drags do affect the underlying order. To refresh the contents of the list, it's necessary to reload the whole Xcode project. See the animation in my tweet: https://twitter.com/lukaskubanek/status/1303976042131009538. Tested on macOS 10.15.6 (19G2021).

Steps:
1. Open an Xcode project/workspace with multiple schemes.
2. Click on the schemes control and select "Manage schemes..."
3. Drag a scheme to another position in the list within the schemes editor.

Expected:
The dragged scheme is shown at its target position in the list, and this new order is reflected in the schemes selection control when opening it again.

Actual:
The dragged scheme stays at its original position in the list, although the operation alters the underlying order causing the schemes selection control to correctly show the updated order.
