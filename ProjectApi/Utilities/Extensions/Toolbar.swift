//
//  Toolbar.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import Foundation
import SwiftUI

extension View {
    
    func createTolbarProFileScreen(dismiss: (() -> Void)?, text: String) -> some View {
        self.toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {dismiss?()}) {
                   Image(systemName: "arrow.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
            }
            ToolbarItem(placement: .principal) {
                Text(text)
                    .font(.title)
                    .fontWeight(.medium)
            }
        })
    }
}
