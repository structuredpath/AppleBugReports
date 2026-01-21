import SwiftUI

struct ContentView: View {
    @State private var sheetDetent = PresentationDetent.bar
    
    var body: some View {
        Color.red
            .ignoresSafeArea()
            .sheet(isPresented: .constant(true)) {
                Color.clear
                    .presentationDetents([.bar, .large], selection: $sheetDetent)
                    .presentationDragIndicator(.visible)
                    .presentationBackgroundInteraction(.enabled)
                    .interactiveDismissDisabled()
            }
    }
}

extension PresentationDetent {
    static let bar = Self.height(100)
}

#Preview {
    ContentView()
}
