import SwiftUI

struct ContentView: View {
    
    @State
    private var selectedDetent = PresentationDetent.height(100)
    
    var body: some View {
        Color.red
            .ignoresSafeArea()
            .sheet(isPresented: .constant(true)) {
                Color.yellow
                    .overlay {
                        Button("Toggle Sheet Detent") {
                            if self.selectedDetent == .height(100) {
                                self.selectedDetent = .large
                            } else {
                                self.selectedDetent = .height(100)
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    .ignoresSafeArea()
                    .presentationDetents(
                        [.height(100), .large],
                        selection: self.$selectedDetent
                    )
                    .interactiveDismissDisabled()
            }
    }
    
}
