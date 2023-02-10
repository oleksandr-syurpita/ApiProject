//
//  MainListCoordinatorView.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import SwiftUI
import SwiftUINavigation

struct MainListCoordinatorView: View {
    
    @ObservedObject var coordinator: MainListCoordinator

    var body: some View {
        NavigationView {
            ZStack {
                MainList(netWork: .init(), mainListViewModel: coordinator.viewModel)
                    .navigationBarHidden(true)
                NavigationLink(
                    unwrapping: $coordinator.route,
                    case: /MainListCoordinator.Route.navigationProFile,
                    destination: {(coordinator: Binding<ProFileCoordinator>) in
                    ProFileCoordinatorView(
                        coordinator: coordinator.wrappedValue).navigationBarBackButtonHidden(true)
                }, onNavigate: {_ in}) {}
            }
        }
    }
}
