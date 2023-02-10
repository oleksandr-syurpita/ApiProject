//
//  MainListViewModel.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import Foundation

class MainListViewModel: ObservableObject {
    
    enum Result {
        case navigationDetal(user: UserData)
        case nabigationBack
    }
    
     var netWork = ApiModel()

    var onResult:((Result) -> Void)?
    
    func navigationDetal(user: UserData) {
        onResult?(.navigationDetal(user: user))
    }
}
