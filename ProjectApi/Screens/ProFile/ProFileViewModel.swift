//
//  ProFileViewModel.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import Foundation

class ProFileViewModel: ObservableObject {
    
    var listRespons = DataRespons(data: [""], status: "")
    var apiService: ApiModel
    var list: [DataRespons] = []
    var errorText = ""
    @Published var users = [UserData]()
    @Published var erroHandler = false
    
    init (apiservice: ApiModel){
        self.apiService = apiservice
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
