import AppKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ notification: Notification) {
        let styleMask: NSWindow.StyleMask = [
            .titled,
            .closable,
            .miniaturizable,
            .resizable
        ]
        
        let window = NSWindow(
            contentRect: .zero,
            styleMask: styleMask,
            backing: .buffered,
            defer: false
        )
        
        window.title = "Titlebar Separator Issue"
        window.subtitle = "Resize the window and observe the separator"
        
        window.titlebarSeparatorStyle = .shadow
        
        window.toolbar = NSToolbar()
        window.contentViewController = ScrollViewController()
        
        window.center()
        window.orderFront(nil)
    }

}

class ScrollViewController: NSViewController {
    override func loadView() {
        let scrollView = NSScrollView()
        
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
        
        self.view = scrollView
    }
}
