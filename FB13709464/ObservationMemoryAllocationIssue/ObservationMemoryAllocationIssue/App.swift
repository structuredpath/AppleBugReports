import SwiftUI

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView(model: ContentModel())
        }
    }
}

@Observable
class ContentModel {
    var flag = false
}

struct ContentView: View {
    let model: ContentModel
    
    @State
    private var count = 0
    
    var body: some View {
        // Access a property on the observable object in the view body.
        let _ = self.model.flag
        
        ZStack {
            Text("\(self.count)")
                .font(.largeTitle)
        }
        .task {
            for i in 0..<10_000_000 {
                do {
                    try await Task.sleep(for: .milliseconds(10))
                    self.count = i
                } catch {}
            }
        }
    }
}
