//
//  MainListViewModel.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import Foundation

class MainListViewModel: ObservableObject {
    
    
    var listRespons = DataRespons(data: [""], status: "")
    var apiService: ApiModel
    var list: [DataRespons] = []
    @Published var users = [UserData]()
    @Published var erroHandler = false
    @Published var errorText = ""

    init(apiService: ApiModel) {
        self.apiService = apiService
    }

    enum Result {
        case navigationDetal(user: UserData)
        case nabigationBack
    }
    
    var onResult:((Result) -> Void)?
    
    func navigationDetal(user: UserData) {
        onResult?(.navigationDetal(user: user))
    }
    
    @MainActor func createList() {
        apiService.getList { result in
            switch result {
            case .success(let data):
                self.listRespons = data
                for string in self.listRespons.data {
                    self.apiService.getUser(url: string) { userData in
                        self.users.append(userData)
                    }
                }
            case .failure(let error):
                if error == .error {
                    self.errorText = "Error alert"
                    self.erroHandler = true
                }
            }
        }
    }
}

