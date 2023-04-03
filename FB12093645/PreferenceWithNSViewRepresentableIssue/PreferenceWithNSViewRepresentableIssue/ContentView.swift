import SwiftUI

struct ContentView: View {
    
    var body: some View {
        HStack {
            // Case 1 (SwiftUI first, NSViewRepresentable view second)
            VStack {
                Color.red
                    .preference(
                        key: SomePreferenceKey.self,
                        value: "Value from Case 1"
                    )
                
                SomeNSViewRepresentable()
            }
            .onPreferenceChange(SomePreferenceKey.self) {
                print($0)
            }
            
            // Case 2 (NSViewRepresentable first, SwiftUI view second)
            VStack {
                SomeNSViewRepresentable()
                
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

struct SomeNSViewRepresentable: NSViewRepresentable {
    
    func makeNSView(context: Context) -> NSView {
        NSView()
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {}
    
}

struct SomePreferenceKey: PreferenceKey {
    
    static var defaultValue = "Default Value"
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
    
}
