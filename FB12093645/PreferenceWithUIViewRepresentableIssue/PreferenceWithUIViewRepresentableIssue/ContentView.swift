import SwiftUI

struct ContentView: View {
    
    var body: some View {
        HStack {
            // Case 1 (SwiftUI first, UIViewRepresentable view second)
            VStack {
                Color.red
                    .preference(
                        key: SomePreferenceKey.self,
                        value: "Value from Case 1"
                    )
                
                SomeUIViewRepresentable()
            }
            .onPreferenceChange(SomePreferenceKey.self) {
                print($0)
            }
            
            // Case 2 (UIViewRepresentable first, SwiftUI view second)
            VStack {
                SomeUIViewRepresentable()
                
                Color.red
                    .preference(
                        key: SomePreferenceKey.self,
                        value: "Value from Case 2"
                    )
            }
            .onPreferenceChange(SomePreferenceKey.self) {
                print($0)
            }
        }
    }
    
}

struct SomeUIViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        UIView()
    }
    
    func updateUIView(_ nsView: UIView, context: Context) {}
    
}

struct SomePreferenceKey: PreferenceKey {
    
    static var defaultValue = "Default Value"
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
    
}
