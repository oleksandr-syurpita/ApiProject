//
//  ContentView.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import SwiftUI

struct MainList: View {
    
    @ObservedObject var netWork: ApiModel
    @ObservedObject var mainListViewModel = MainListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List(netWork.users) { user in
                    Text(String(user.firstName)).onTapGesture {
                        mainListViewModel.navigationDetal(user: user)
                    }
                }.onAppear{
                    netWork.getList()
                }
                Button(action: {
                    netWork.users.removeAll()
                    netWork.getList()
                }) {
                        Text("RESET")
                    }
            }
        }
    }
}

struct MainList_Previews: PreviewProvider {
    static var previews: some View {
        MainList(netWork: .init())
    }
}
