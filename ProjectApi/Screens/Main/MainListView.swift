//
//  ContentView.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import SwiftUI

struct MainListView: View {
    
    @ObservedObject var mainListViewModel: MainListViewModel
    
    var body: some View {
        VStack {
            List(mainListViewModel.users) { users in
                Button(action: {
                    mainListViewModel.navigationDetal(
                    user: users)
                }, label: {Text(users.firstName)}
                )
                .alert(isPresented: $mainListViewModel.erroHandler.showError) {
                    Alert(
                        title: Text(mainListViewModel.erroHandler.error),
                        message: Text(mainListViewModel.erroHandler.error),
                        dismissButton: .cancel(
                            Text("Click me"),
                            action: {
                        mainListViewModel.createList()
                            }
                        )
                    )
                }
            }
            Button {
                mainListViewModel.users.removeAll()
                mainListViewModel.createList()
            } label: {
                Text("RESET")
            }

        }.onAppear{
            mainListViewModel.createList()
            mainListViewModel.users.removeAll()

        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView(mainListViewModel: .init(apiService: ApiModel()))
    }
}
