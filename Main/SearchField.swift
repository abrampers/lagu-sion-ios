//
//  SearchField.swift
//  Main
//
//  Created by Abram Situmorang on 29/06/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import SwiftUI

struct SearchField: View {
    @Binding var searchText: String
    var placeholder: LocalizedStringKey = "Search..."

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .imageScale(.large)
            TextField(placeholder, text: $searchText)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .textContentType(.name)
                .foregroundColor(Color(.label))
            if !searchText.isEmpty {
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.headline)
                        .foregroundColor(.red)
                        .imageScale(.large)
                }.buttonStyle(BorderlessButtonStyle())
            }
        }
        .padding(8)
        .background(Color(.systemGray5))
        .mask(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .padding(2)
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
