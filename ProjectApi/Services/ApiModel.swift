//
//  ApiModel.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import Foundation

class ApiModel: ObservableObject {
    
    @Published var listId: [String] = []
    var statusList = ""
    var statusUser = ""
    @Published var users = [UserData]()
    @Published var userData = UserRespons(
        status: "??",
        data: UserData(
            id: "???",
            firstName: "???",
            lastName: "??",
            age: 4,
            gender: "???",
            country: "???")
    )
            
    func getList() {
        guard let url = URL(string: "https://opn-interview-service.nn.r.appspot.com/list") else { fatalError("Missing URL") }
        var request = URLRequest(url: url)
        request.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Requst error",error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async { [self] in
                    do {
                        let decoded = try JSONDecoder().decode(DataRespons.self, from: data)
                        self.listId = decoded.data
                        self.statusList = decoded.status
                        
                        for id in self.listId {
                            getUser(url: id)
                        }
                    } catch let error{
                        print("Error decode",error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func getUser(url: String) {
        guard let url = URL(string: "https://opn-interview-service.nn.r.appspot.com/get/\(url)") else { fatalError("Missing URL") }
        var request = URLRequest(url: url)
        request.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Requst error",error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async { [self] in
                    do {
                        let decoded = try JSONDecoder().decode(UserRespons.self, from: data)
                        self.userData = decoded
                        self.statusUser = decoded.status
                        users.append(decoded.data)
                    } catch let error{
                        print("Error decode",error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
