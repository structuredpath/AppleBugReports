import SwiftUI

struct ContentView: View {
    
    @FocusState
    private var isFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                TextField("", text: .constant(""))
                    .border(.black)
                    .focused(self.$isFocused)
                
                Button("Hide") {
                    self.isFocused = false
                }
                .buttonStyle(.bordered)
            }
            .padding()
            
            List {
                ForEach(0..<50, id: \.self) { i in
                    Text("Row \(i)")
                }
            }
        }
        .background(.red)
    }
    
}
