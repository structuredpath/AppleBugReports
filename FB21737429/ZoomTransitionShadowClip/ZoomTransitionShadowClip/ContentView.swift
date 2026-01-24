import SwiftUI

struct ContentView: View {
    @State private var isSheetPresented = false
    @Namespace private var namespace

    var body: some View {
        NavigationStack {
            Color.clear
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Spacer()
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            isSheetPresented = true
                        } label: {
                            Image(systemName: "square")
                        }
                        .matchedTransitionSource(id: "sheet", in: namespace)
                    }
                }
                .sheet(isPresented: $isSheetPresented) {
                    Color.clear
                        .navigationTransition(.zoom(sourceID: "sheet", in: namespace))
                        .presentationDetents([.medium])
                }
        }
    }
}

#Preview {
    ContentView()
}
