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
        apiService.getList { (listRespons) in
            self.listRespons = listRespons
            for string in listRespons.data {
                self.apiService.getUser(url: string) { userData in
                    self.users.append(userData)
                }
            }
        }completionError: { error in
            self.erroHandler = true
            self.errorText = error.localizedDescription
        }
    }
}
