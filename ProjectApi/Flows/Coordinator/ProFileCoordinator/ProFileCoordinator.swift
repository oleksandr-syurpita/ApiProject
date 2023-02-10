//
//  ProFileCoordinator.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import Foundation
import SwiftUI

class ProFileCoordinator: ObservableObject {

    enum Result {
        case navigationBack
    }
    
    var onResult: ((Result) -> Void)?
    var viewModel: ProFileViewModel
    var user: UserData
    
    init(viewModel: ProFileViewModel,user: UserData) {
        self.viewModel = viewModel
        self.user = user
        viewModel.onResult = { [weak self] result in
            switch result {
            case .navigationBackToList:
                self?.onResult?(.navigationBack)
            case .navigationBack:
                self?.onResult = nil
            }
        }
    }
}
