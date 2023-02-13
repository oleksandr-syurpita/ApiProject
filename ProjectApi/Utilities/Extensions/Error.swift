//
//  Error.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 10.02.2023.
//

import Foundation
import SwiftUI

extension View {
    func alertCustom(isPresented: Binding<Bool>, content: @escaping () -> Alert) -> some View {
        return self.modifier(InspectableAlert(isPresented: isPresented, popupBuilder: content))
    }
}

struct InspectableAlert: ViewModifier {
    
    @Binding var isPresented: Bool
    let popupBuilder: () -> Alert
    let onDismiss: (() -> Void)? = nil
    
    func body(content: Self.Content) -> some View {
        content.alert(isPresented: $isPresented, content: popupBuilder)
    }
}

class ErroHandler: ObservableObject{
   @Published var error = ""
   @Published var showError = false 
}
