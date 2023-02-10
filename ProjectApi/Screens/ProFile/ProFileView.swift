//
//  ProFile.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import SwiftUI

struct ProFileView: View {
    
    @ObservedObject var viewModel: ProFileViewModel
    var user: UserData
    
    var body: some View {
        ZStack {
            VStack {
                Form {
                    Section {
                        details
                            .alertCustom(isPresented: $viewModel.netWork.errorOn) {
                                Alert(title:
                                        Text(viewModel.netWork.errorString),
                                      message: Text(viewModel.netWork.errorString),
                                      dismissButton: .cancel(Text("Click me"),action: {viewModel.netWork.getList() }))
                            }
                    }
                    
                }
            }
            .createTolbarProFileScreen(dismiss: {viewModel.navigationBackTO()}, text: String("\(user.firstName)" + "\(user.lastName)"))
        }
    }
}

extension ProFileView {

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

struct ProFileView_Previews: PreviewProvider {
    static var previews: some View {
        ProFileView(viewModel: .init(), user: UserData(id: "??", firstName: "Dima", lastName: "Kekish", age: 18, gender: "man", country: "Ukraine"))
    }
}
