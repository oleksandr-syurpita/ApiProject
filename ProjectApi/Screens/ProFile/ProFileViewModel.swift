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
        apiService.getList { (listRespons) in
            self.listRespons = listRespons
            for string in listRespons.data {
                self.apiService.getUser(url: string) { userData in
                    self.users.append(userData)
                }
            }
        } completionError: { error in
            self.erroHandler = true
            self.errorText = error.localizedDescription
        }
    }
}
