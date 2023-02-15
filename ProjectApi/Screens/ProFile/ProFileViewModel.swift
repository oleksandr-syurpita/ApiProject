//
//  ProFileViewModel.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import Foundation

class ProFileViewModel: ObservableObject {
    
    var listResponses = DataResponses(data: [""], status: "")
    var apiService: UserService
    var list: [DataResponses] = []
    var errorText = ""
    
    @Published var users = [UserData]()
    @Published var errorHandler = false
    
    init(apiService: UserService){
        self.apiService = apiService
    }
    
    enum Result {
        case navigationBackToList
        case navigationBack
    }

    var onResult: ((Result) -> Void)?
    
    func navigationBack() {
        onResult?(.navigationBackToList)
    }
    
    func navigationBackTO() {
        onResult?(.navigationBackToList)
    }
    
     func createList() {
        apiService.getList { result in
            switch result {
            case .success(let data):
                    self.listResponses = data
                for string in self.listResponses.data {
                        self.apiService.getUser(url: string) { userData in
                            self.users.append(userData)
                        }
                    }
            case .failure(let error):
                if error == .error {
                    self.errorText = "Error alert"
                    self.errorHandler = true
                }
            }
        }
    }
}
