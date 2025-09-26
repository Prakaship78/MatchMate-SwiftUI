//
//  MatchListView.swift
//  MatchMate
//
//  Created by Prakash on 25/09/25.
//

import SwiftUI

struct MatchListView: View {
    @State var vm = MatchListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if vm.isLoading {
                    ProgressView()
                    
                }else {
                    ScrollView {
                        LazyVStack {
                            ForEach($vm.usersList) { $data in
                                
                                MatchListCardView(data: $data, acceptedButtonAction: {
                                    //
                                    vm.handleUserAction(user: data, status: .accepted)
                                }, cancelButtonAction: {
                                    //
                                    vm.handleUserAction(user: data, status: .declined)
                                })
                                .onAppear {
                                    handlePagination(for: data)
                                }
                                
                            }
                            // Pagination Loading indicator
                            if vm.isPaginationLoading {
                                ProgressView()
                                    .padding()
                            }
                            
                        }
                    }
                }
            }
            .navigationTitle("Profile Matches")
            .alert("Error", isPresented: $vm.showError){
                Button("OK",role: .cancel){}
            } message: {
                Text(vm.errorMessage ?? "Something went wrong")
            }
            .task {
                await vm.loadInitialData()
            }
        }
    }
    
    //MARK: Handle pagination logic
    private func handlePagination(for user : User){
        guard user.id == vm.usersList.last?.id else{return}
        if !vm.isPaginationLoading {
            Task {
                await vm.fetchUsersData(isPagination: true)
            }
        }
    }
}

#Preview {
    MatchListView()
}
