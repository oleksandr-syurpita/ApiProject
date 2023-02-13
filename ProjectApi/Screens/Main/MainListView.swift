//
//  ContentView.swift
//  ProjectApi
//
//  Created by Oleksandr Syurpita on 09.02.2023.
//

import SwiftUI

struct MainListView: View {
    
    @ObservedObject var mainListViewModel = MainListViewModel()
    @ObservedObject  var netWork = ApiModel()
    
    var body: some View {
        VStack {
            List(netWork.users) { user in
                HStack {
                    Button(action: {
                        mainListViewModel.navigationDetal(user: user)},
                           label: { Text(user.firstName)})
                    .alertCustom(isPresented: $netWork.errorOn) {
                        Alert(
                            title: Text(netWork.errorString),
                            message: Text(netWork.errorString),
                            dismissButton: .cancel(
                                Text("Click me"),
                                action: {netWork.getList() {
                                    
                                }}
                            )
                        )
                    }
                }
            }
            Button {
                netWork.users.removeAll()
                netWork.getList(){
                    
                }
            } label: {
                Text("RESET")
            }

        }.onAppear{
            netWork.getList(){
                
            }
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}
