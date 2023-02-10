//
//  ProFile.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import SwiftUI

struct ProFile: View {
    
    @ObservedObject var viewModel: ProFileViewModel
    var user: UserData
    
    var body: some View {
        ZStack {
            VStack {
                Form {
                    Section {
                        details
                    }
                }
            }
            .createTolbarProFileScreen(dismiss: {viewModel.navigationBackTO()}, text: String("\(user.firstName)" + "\(user.lastName)"))
        }
    }
}

struct ProFile_Previews: PreviewProvider {
    static var previews: some View {
        ProFile(viewModel: .init(), user: UserData(id: "??", firstName: "Dima", lastName: "Kekish", age: 18, gender: "man", country: "Ukraine"))
    }
}

extension ProFile {

    var details: some View {
        VStack {
            createButton(text: "ID",  detail: String(user.id))
            createButton(text: "First Name", detail: String(user.firstName))
            createButton(text: "Last Name", detail: String(user.lastName))
            createButton(text: "Age", detail: String(user.age))
            createButton(text: "Gender", detail: String(user.gender))
            createButton(text: "Country", detail: String(user.country))
        }
    }
}
