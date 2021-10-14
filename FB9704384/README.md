# The "Markup" shortcut-action-window doesn't close automatically when finishing & thus overlaps other windows

Area: Shortcuts
Type: Incorrect/Unexpected Behavior

Is this a shortcut issue with Siri or the Shortcuts app?: Shortcuts app
What type of shortcut issue are you seeing?: Running a shortcut

## Description
Please take a look at the attached “Shortcut Setup.png” or use this list to recreate the shortcut:
### Shortcut Setup
1. Take Screenshot
2. Make PDF from Screenshot
3. Mark up PDF
4. Print Markup Result

### Actual Result
The window opened by the “Markup” action doesn’t close automatically when finishing the editing. This is unintuitive and leads to confusion what happens next. Besides that the markup-window also overlaps other windows/panels like the print dialog that gets triggered in the next step by the Shortcut setup mentioned listed above. Closing the markup-window via the “x” in the upper left corner stops the shortcut, which is also unexpected. 

Please take a look at the attached Screen Recording to see this issue in action.

### Expected
1. As a user I’d expect the markup window to automatically close after I’ve finished editing the image/PDF.
2. Also when closing the markup window I’d expect the shortcut to continue with the missing steps, instead of stopping without warning.