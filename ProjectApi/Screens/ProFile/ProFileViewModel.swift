//
//  ProFileViewModel.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import Foundation

class ProFileViewModel: ObservableObject {
    
    enum Result {
        case navigationBackToList
        case navigationBack
    }
    var netWork = ApiModel()

    var onResult: ((Result) -> Void)?
    
    func navigationBack() {
        onResult?(.navigationBackToList)
        netWork.getList()
    }
    
    func navigationBackTO() {
        onResult?(.navigationBackToList)
        netWork.getList()
    }
}
