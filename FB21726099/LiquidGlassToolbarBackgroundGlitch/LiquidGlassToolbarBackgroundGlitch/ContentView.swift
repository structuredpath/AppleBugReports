import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        NavigationStack {
            ZStack {
                Color.yellow
                    .ignoresSafeArea()

                List {
                    ForEach(0..<20) { i in
                        Text("Item \(i)")
                            .listRowBackground(Color.clear)
                    }
                }
                .listStyle(.plain)
            }
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbarBackground(colorScheme == .dark ? .black : .white, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {} label: {
                        Image(systemName: "diamond")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {} label: {
                        Image(systemName: "diamond")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
