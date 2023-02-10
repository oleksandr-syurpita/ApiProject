//
//  View.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import Foundation
import SwiftUI

extension View {
    
    func createButton(text: String, detail: String) -> some View {
        VStack {
            HStack {
                Text(text)
                Spacer()
                Text(detail)
                    .font(.system(size: 15, weight: .bold))
                    .font(.callout)
            }
            Divider()
                .frame( width: .infinity, height: 1)
                .background(Color.black)
        }
    }
}
