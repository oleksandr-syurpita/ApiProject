//
//  UserData.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import Foundation

struct UserData: Codable, Identifiable {
    
    let id: String
    let firstName: String
    let lastName: String
    let age: Int
    let gender: String
    let country: String
}
