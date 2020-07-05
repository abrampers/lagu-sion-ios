//
//  SearchField.swift
//  Main
//
//  Created by Abram Situmorang on 29/06/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import SwiftUI

extension UIApplication {
    fileprivate func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct SearchField: View {
    @State private var showCancelButton: Bool = false
    @Binding var searchText: String
    var placeholder: LocalizedStringKey = "Search..."

    var body: some View {
        HStack {
            HStack {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                TextField(placeholder, text: $searchText, onEditingChanged: { self.showCancelButton = $0 })
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .textContentType(.name)
                    .foregroundColor(.primary)
                        if !searchText.isEmpty {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                            }.buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    .padding(8)
                    .foregroundColor(.secondary)
                    .background(Color(.tertiarySystemFill))
                    .cornerRadius(8)
            
            if showCancelButton  {
                // Cancel button
                Button("Cancel") {
                    UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                    self.searchText = ""
                    self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .navigationBarHidden(showCancelButton)
            .animation(.spring())
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                Section(header:
                    SearchField(searchText: .constant("Editing"),
                                placeholder: "test"))
                {
                    SearchField(searchText: .constant(""),
                                placeholder: "Placeholder")
                    SearchField(searchText: .constant("Editing"),
                                placeholder: "test")
                    Text("An item")
                    
                }
                
            }
        }
    }
}
