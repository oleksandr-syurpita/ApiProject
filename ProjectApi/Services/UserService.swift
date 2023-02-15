//
//  ApiModel.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import Foundation

class UserService: ObservableObject {

    func getList(completion: @escaping (Result<DataResponses,NetworkError>) -> Void) {
        guard let url = URL(string: "https://opn-interview-service.nn.r.appspot.com/list") else {  return }
        var request = URLRequest(url: url)
        request.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
         URLSession.shared.dataTask(with: request) { (data, responses, error)in
            guard let responses = responses as? HTTPURLResponse else {return}
            guard let data = data else {return}
            if responses.statusCode == 200 {
                DispatchQueue.main.async {
                    do {
                        let decode = try JSONDecoder().decode(DataResponses.self, from: data)
                        completion(.success(decode))
                    }
                    catch {
                        print("error decode")
                    }
                }
            }else {
                completion(.failure(NetworkError.error))
            }
        }.resume()
    }
    
    func getUser(url: String, completion: @escaping (UserData) -> Void) {
        guard let url = URL(string: "https://opn-interview-service.nn.r.appspot.com/get/\(url)") else {  return }
        var request = URLRequest(url: url)
        request.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
         URLSession.shared.dataTask(with: request) { (data, responses, error)in
            guard let responses = responses as? HTTPURLResponse else {return}
            guard let data = data else {return}

            if responses.statusCode == 200 {
                DispatchQueue.main.async {
                    do {
                        let decode = try JSONDecoder().decode(UserResponses.self, from: data)
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
