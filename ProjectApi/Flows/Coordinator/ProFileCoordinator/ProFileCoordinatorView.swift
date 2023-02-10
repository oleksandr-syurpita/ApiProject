//
//  ProFileCoordinatorView.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import SwiftUI
import SwiftUINavigation

struct ProFileCoordinatorView: View {
    @ObservedObject  var coordinator: ProFileCoordinator
    var body: some View {
        NavigationView {
            ZStack {
                ProFileView(
                    viewModel: coordinator.viewModel,
                    user: coordinator.user
                )
            }
        }
    }
}
