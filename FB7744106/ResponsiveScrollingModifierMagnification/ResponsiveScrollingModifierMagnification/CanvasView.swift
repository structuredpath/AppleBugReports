import Cocoa

internal final class CanvasView: NSView {
    
    // ======================================================= //
    // MARK: - Configuration
    // ======================================================= //
    
    override var acceptsFirstResponder: Bool { true }
    
    override static var isCompatibleWithResponsiveScrolling: Bool { true }
    
    // ======================================================= //
    // MARK: - Event Handling
    // ======================================================= //
    
    override func scrollWheel(with event: NSEvent) {
        if event.modifierFlags.contains(.command) {
            print("Handling scroll event as magnification (time=\(event.timestamp))")
        } else {
            print("Passing initial scroll event to super to trigger responsive scrolling")
            super.scrollWheel(with: event)
        }
    }
    
    private var _previousFlagsChangedEvent: NSEvent?
    
    override func flagsChanged(with event: NSEvent) {
        let commandWasPressed = _previousFlagsChangedEvent?.modifierFlags.contains(.command) ?? false
        let commandIsPressed = event.modifierFlags.contains(.command)
        
        defer { _previousFlagsChangedEvent = event }
        
        switch (commandWasPressed, commandIsPressed) {
        case (false, true):
            // Transition: scrolling -> magnification
            //
            // The scrolling which is being tracked on the separate loop has to be stopped in order
            // to route the next scroll events through scrollWheel(with:) again.
            print("Pressed CMD")
        case (true, false):
            // Transition: magnification -> scrolling
            //
            // Since the next scroll event goes though scrollWheel(with:) the scrolling is correctly
            // picked up.
            print("Unpressed CMD")
        default:
            break
        }
    }
    
    // ======================================================= //
    // MARK: - Drawing
    // ======================================================= //
    
    override func draw(_ dirtyRect: NSRect) {
        NSColor.white.set()
        dirtyRect.fill()
        
        let string = Array(repeating: "Buttery smooth scrolling.", count: 500)
            .joined(separator: " ")
        
        NSString(string: string).draw(
            in: bounds,
            withAttributes: [
                NSAttributedString.Key.foregroundColor: NSColor.lightGray
            ]
        )
    }
    
}
