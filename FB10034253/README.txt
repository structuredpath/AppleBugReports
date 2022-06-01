# Incorrect baseline alignment of SwiftUI Button on macOS

Area: SwiftUI Framework
Type: Incorrect/Unexpected Behavior

I run into a layout issue while trying to replicate the layout of controls from the Network preference pane for configuring WiFi as shown in "WiFi Settings.png." When placing a regular (non-plain) SwiftUI Button in an HStack along with other controls like Text and setting the vertical alignment to .firstTextBaseline, the button isn't positioned correctly. The following code example produces the result shown in "SwiftUI Baseline Alignment.png." It clearly illustrates that the baseline alignment doesn't get picked up by the regular Button.

HStack(alignment: .firstTextBaseline) {
    Text("Text")
    
    Text("Large Text")
        .font(.title)
    
    Button {} label: {
        Text("Button")
    }
    
    Button {} label: {
        Text("Borderless")
    }
    .buttonStyle(.borderless)
    
    Button {} label: {
        Text("Plain")
    }
    .buttonStyle(.plain)
    
    Toggle("Toggle", isOn: .constant(true))
    
    Picker("Picker", selection: .constant(0)) {
        Text("One").tag(0)
        Text("Two").tag(1)
        Text("Three").tag(2)
    }
    .pickerStyle(.radioGroup)
}
.padding()
