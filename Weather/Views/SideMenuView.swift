//
//  SideMenuView.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 13/01/2022.
//

import SwiftUI

struct SideMenuView: View {
    @State private var showConfirmationAlert = false
    @State private var showUnableAlert = false
    @State private var selectedIndexSet: IndexSet?
    @ObservedObject var viewModel = SideMenuViewModel()
    
    // Callback function type
    typealias TapAction = (_ selectedCity: String) -> Void
    // Stored property to hold the callback function
    var onTapGesture: TapAction
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
            List {
                if (!viewModel.cities!.isEmpty) {
                    ForEach(0..<viewModel.cities!.count, id: \.self) { i in
                        Text("\(viewModel.cities![i].name), \(viewModel.cities![i].country)")
                            .font(.system(size: 16))
                            .onTapGesture {
                                debugPrint("Tapped on \(viewModel.cities![i].name)")
                                self.onTapGesture(viewModel.cities![i].name)
                            }
                    }.onDelete { indexSet in
                        let city = indexSet.map { viewModel.cities![$0] }.first
                        
                        if city!.current == 1 {
                            self.showUnableAlert = true
                        } else {
                            self.selectedIndexSet = indexSet
                            self.showConfirmationAlert = true
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 32/255, green: 32/255, blue: 32/255))
            .navigationBarTitle("Weather Around")
            .alert(isPresented: $showUnableAlert) {
                Alert(
                    title: Text("Oops!"),
                    message: Text("Unable to remove current GPS located city"),
                    dismissButton: Alert.Button.default(
                        Text("Okay")
                    )
                )
            }
            .alert(isPresented: $showConfirmationAlert) {
                Alert(
                    title: Text("Confirmation"),
                    message: Text("Are you sure to remove this city?"),
                    primaryButton: Alert.Button.default(
                        Text("Yes"), action: {
                            for index in self.selectedIndexSet ?? [] {
                                DispatchQueue.main.async {
                                    viewModel.removeCity(
                                        city: viewModel.cities![index]
                                    )
                                }
                            }
                            self.showConfirmationAlert = false
                        }
                    ),
                    secondaryButton: Alert.Button.cancel(
                        Text("No"), action: {
                            self.showConfirmationAlert = false
                        }
                    )
                )
            }
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(){selectedCity in }
    }
}
