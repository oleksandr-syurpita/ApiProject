//
//  ProjectApiApp.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import SwiftUI

@main
struct ProjectApiApp: App {
    var body: some Scene {
        WindowGroup {
            MainListCoordinatorView(coordinator: MainListCoordinator(viewModel: MainListViewModel(apiService: ApiModel())))
        }
    }
}
