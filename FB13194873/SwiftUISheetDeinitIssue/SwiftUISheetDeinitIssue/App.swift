import SwiftUI

// ============================================================================ //
// MARK: - App
// ============================================================================ //

@main
struct SwiftUISheetDeinitIssueApp: App {
    var body: some Scene {
        WindowGroup {
            CaseE_ContentView()
        }
    }
}

// ============================================================================ //
// MARK: - Case A: @StateObject (Works!)
// ============================================================================ //

struct CaseA_ContentView: View {
    @State var isPresented = false
    
    var body: some View {
        Button("Show Sheet") {
            self.isPresented = true
        }
        .sheet(isPresented: $isPresented) {
            CaseA_SheetView()
        }
    }
}

struct CaseA_SheetView: View {
    @StateObject var model = CaseA_SheetViewModel()
    
    var body: some View {
        Text("Sheet")
    }
}

final class CaseA_SheetViewModel: ObservableObject {
    init() { print("\(Self.self).\(#function)") }
    deinit { print("\(Self.self).\(#function)") }
}

// ============================================================================ //
// MARK: - Case B: @ObservedObject & Inline Model Creation (Doesn't Work!)
// ============================================================================ //

struct CaseB_ContentView: View {
    @State var isPresented = false
    
    var body: some View {
        Button("Show Sheet") {
            self.isPresented = true
        }
        .sheet(isPresented: $isPresented) {
            CaseB_SheetView(model: CaseB_SheetViewModel())
        }
    }
}

struct CaseB_SheetView: View {
    @ObservedObject var model: CaseB_SheetViewModel
    
    init(model: CaseB_SheetViewModel) {
        self.model = model
    }
    
    var body: some View {
        Text("Sheet")
    }
}

final class CaseB_SheetViewModel: ObservableObject {
    init() { print("\(Self.self).\(#function)") }
    deinit { print("\(Self.self).\(#function)") }
}

// ============================================================================ //
// MARK: - Case C: @ObservedObject + @State in Parent (Doesn't Work!)
// ============================================================================ //

struct CaseC_ContentView: View {
    @State var sheetViewModel: CaseC_SheetViewModel?
    
    var body: some View {
        Button("Show Sheet") {
            self.sheetViewModel = CaseC_SheetViewModel()
        }
        .sheet(item: self.$sheetViewModel) { model in
            CaseC_SheetView(model: model)
        }
    }
}

struct CaseC_SheetView: View {
    @ObservedObject var model: CaseC_SheetViewModel
    
    init(model: CaseC_SheetViewModel) {
        self.model = model
    }
    
    var body: some View {
        Text("Sheet")
    }
}

final class CaseC_SheetViewModel: ObservableObject, Identifiable {
    init() { print("\(Self.self).\(#function)") }
    deinit { print("\(Self.self).\(#function)") }
}

// ============================================================================ //
// MARK: - Case D: Content @StateObject + Sheet @ObservedObject (Doesn't Work!)
// ============================================================================ //

struct CaseD_ContentView: View {
    @StateObject var model = CaseD_ContentViewModel()
    
    var body: some View {
        Button("Show Sheet") {
            self.model.sheetViewModel = CaseD_SheetViewModel()
        }
        .sheet(item: self.$model.sheetViewModel) { model in
            CaseD_SheetView(model: model)
        }
    }
}

final class CaseD_ContentViewModel: ObservableObject, Identifiable {
    @Published
    var sheetViewModel: CaseD_SheetViewModel?
}

struct CaseD_SheetView: View {
    @ObservedObject var model: CaseD_SheetViewModel
    
    init(model: CaseD_SheetViewModel) {
        self.model = model
    }
    
    var body: some View {
        Text("Sheet")
    }
}

final class CaseD_SheetViewModel: ObservableObject, Identifiable {
    init() { print("\(Self.self).\(#function)") }
    deinit { print("\(Self.self).\(#function)") }
}

// ============================================================================ //
// MARK: - Case E: @Observable
// ============================================================================ //

struct CaseE_ContentView: View {
    @State
    var sheetViewModel: CaseE_SheetViewModel?
    
    var body: some View {
        Button("Show Sheet") {
            self.sheetViewModel = CaseE_SheetViewModel()
        }
        .sheet(item: self.$sheetViewModel) { model in
            CaseE_SheetView(model: model)
        }
    }
}

struct CaseE_SheetView: View {
    let model: CaseE_SheetViewModel
    
    init(model: CaseE_SheetViewModel) {
        self.model = model
    }
    
    var body: some View {
        Text("Sheet")
    }
}

@Observable
final class CaseE_SheetViewModel: Identifiable {
    init() { print("\(Self.self).\(#function)") }
    deinit { print("\(Self.self).\(#function)") }
}

// ============================================================================ //
// MARK: - Case F
// ============================================================================ //

struct CaseF_ContentView: View {
    @State
    var sheetViewModel: CaseF_SheetViewModel?
    
    var body: some View {
        Button("Show Sheet") {
            self.sheetViewModel = CaseF_SheetViewModel()
        }
        .sheet(item: self.$sheetViewModel) { model in
            CaseF_SheetView(model: model)
        }
    }
}

struct CaseF_SheetView: View {
    @Environment(\.dismiss) private var dismiss
    
    let model: CaseF_SheetViewModel
    
    init(model: CaseF_SheetViewModel) {
        self.model = model
    }
    
    var body: some View {
        VStack {
            Text("Sheet")
            Button("Dismiss") { self.dismiss() }
        }
        .onDisappear(perform: {
            print("onDisappear")
        })
    }
}

@Observable
final class CaseF_SheetViewModel: Identifiable {
    init() { print("\(Self.self).\(#function)") }
    deinit { print("\(Self.self).\(#function)") }
}

// ============================================================================ //
// MARK: - Case G
// ============================================================================ //

struct CaseG_ContentView: View {
    @State var isPresented = false
    
    var body: some View {
        Button("Show Sheet") {
            self.isPresented = true
        }
        .sheet(isPresented: $isPresented) {
            CaseG_SheetView(model: CaseG_SheetViewModel())
        }
    }
}

struct CaseG_SheetView: View {
    @StateObject var model: CaseG_SheetViewModel
    
    init(model: CaseG_SheetViewModel) {
        self._model = StateObject(wrappedValue: model)
    }
    
    var body: some View {
        Text("Sheet")
    }
}

final class CaseG_SheetViewModel: ObservableObject {
    init() { print("\(Self.self).\(#function)") }
    deinit { print("\(Self.self).\(#function)") }
}
