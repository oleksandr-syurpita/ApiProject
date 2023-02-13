//
//  ApiModel.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import Foundation

class ApiModel: ObservableObject {

    func getList(completion: @escaping (DataRespons) -> Void,completionError: @escaping (Error) -> Void) {
        guard let url = URL(string: "https://opn-interview-service.nn.r.appspot.com/list") else {  return }
        var request = URLRequest(url: url)
        request.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { (data, respons, error)in
            guard let respons = respons as? HTTPURLResponse else {return}
            guard let data = data else {return}
            if respons.statusCode == 200 {
                DispatchQueue.main.async {
                    do {
                        let decode = try JSONDecoder().decode(DataRespons.self, from: data)
                            completion(decode)
                    }
                    catch {
                        completionError(error)
                    }
                }
            }else {
                if let error = error {
                    completionError(error)
                    print("very not ok")
                }
                print("not ok")
            }
        }.resume()
    }
    
    
    func getUser(url: String, completion: @escaping (UserData) -> Void) {
        guard let url = URL(string: "https://opn-interview-service.nn.r.appspot.com/get/\(url)") else {  return }
        var request = URLRequest(url: url)
        request.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { (data, respons, error)in
            guard let respons = respons as? HTTPURLResponse else {return}
            guard let data = data else {return}

            if respons.statusCode == 200 {
                DispatchQueue.main.async {
                    do {
                        let decode = try JSONDecoder().decode(UserRespons.self, from: data)
                        let user = decode.data
                        completion(user)
                    }
                    catch {
                        print("error decode")
                    }
                }
            }else {
                print("error status code")
            }
        }.resume()
    }

}
