//
//  SearchField.swift
//  Main
//
//  Created by Abram Situmorang on 29/06/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import SwiftUI
import UIKit

public struct SearchField: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String = "Search"
    
    public init(text: Binding<String>, placeholder: String = "Search") {
        self._text = text
        self.placeholder = placeholder
    }
    
    public func makeCoordinator() -> SearchField.Coordinator {
        return Coordinator(text: $text)
    }
    
    public func makeUIView(context: UIViewRepresentableContext<SearchField>) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = placeholder
        searchBar.returnKeyType = .search
        return searchBar
    }
    
    public func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchField>) {
    }
}

extension SearchField {
    
    public class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }
        
        public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(true, animated: true)
        }
        
        public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let searchBarText = searchBar.text else { return }
            text = searchBarText
            searchBar.resignFirstResponder()
        }
        
        public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(false, animated: true)
        }
        
        public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                Section(header:
                    SearchField(text: .constant("Editing"),
                                placeholder: "test"))
                {
                    SearchField(text: .constant(""),
                                placeholder: "Placeholder")
                    SearchField(text: .constant("Editing"),
                                placeholder: "test")
                    Text("An item")

                }

            }
        }
    }
}
