//
//  ContentView.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import SwiftUI

struct MainListView: View {
    
    @ObservedObject var mainListViewModel = MainListViewModel()
    
    var body: some View {
        VStack {
            List(mainListViewModel.netWork.users) { user in
                HStack {
                    Button(action: {
                        mainListViewModel.navigationDetal(user: user)},
                           label: { Text(user.firstName)})
                    .alertCustom(isPresented: $mainListViewModel.netWork.errorOn) {
                        Alert(
                            title: Text(mainListViewModel.netWork.errorString),
                            message: Text(mainListViewModel.netWork.errorString),
                            dismissButton: .cancel(
                                Text("Click me"),
                                action: mainListViewModel.netWork.getList
                            )
                        )
                    }
                }
            }
            Button {
                mainListViewModel.netWork.users.removeAll()
                mainListViewModel.netWork.getList()
            } label: {
                Text("RESET")
            }

        }.onAppear{
            mainListViewModel.netWork.getList()
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}
