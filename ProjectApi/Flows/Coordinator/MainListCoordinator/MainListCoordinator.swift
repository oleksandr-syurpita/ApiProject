//
//  MainListCoordinator.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import Foundation

class MainListCoordinator: ObservableObject {
    
    enum Route {
        case navigationProFile(coordinator: ProFileCoordinator)
    }
    
    @Published var route: Route?
    var viewModel: MainListViewModel
    
    init(viewModel: MainListViewModel) {
        self.viewModel = viewModel
        viewModel.onResult = {[weak self] result in
            switch result {
            case .navigationDetal(let user):
                self?.moveToProfile(user: user)
            case .nabigationBack:
                self?.route = nil
            }
        }
    }
  
    func moveToProfile(user: UserData) {
        let coordinator = ProFileCoordinator(viewModel: ProFileViewModel(apiservice: ApiModel()), user: user)
        coordinator.onResult = {[weak self] result in
            switch result {
            case .navigationBack:
                self?.route = nil
            }
        }
        self.route = .navigationProFile(coordinator: coordinator)
    }
}
