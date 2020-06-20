import Cocoa

final class DocumentView: NSView {
    
    override class var isCompatibleWithResponsiveScrolling: Bool { true }
    
    override var isFlipped: Bool { true }
    
    override func draw(_ dirtyRect: NSRect) {
        NSColor.orange.set()
        dirtyRect.fill()
    }
    
}
