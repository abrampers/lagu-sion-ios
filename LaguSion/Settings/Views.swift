//
//  Views.swift
//  Settings
//
//  Created by Abram Situmorang on 31/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Common
import ComposableArchitecture
import SwiftUI

public struct SettingsView: View {
    let store: Store<SettingsState, SettingsAction>
    @State private var previewIndex = 0
    @State private var isOn = false
    var previewOptions = ["Always", "When Unlocked", "Never"]
    
    public init(store: Store<SettingsState, SettingsAction>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                Form {
                    Section {
                        Toggle(isOn: self.$isOn) {
                            Text("Available Offline")
                        }
                        
                        Picker(
                            selection: viewStore.binding(get: { $0.fontSelection }, send: { SettingsAction.fontSelectionChanged($0) }),
                            label: Text("Font")
                        ) {
                            ForEach(FontSelection.allCases, id: \.self) { fontSelection in
                                Text(fontSelection.rawValue)
                                    .font(fontSelection.font)
                            }
                        }
                        
                        Picker(
                            selection: viewStore.binding(get: { $0.contentSizeSelection }, send: { SettingsAction.contentSizeSelectionChanged($0) }),
                            label: Text("Font Size")
                        ) {
                            ForEach(ContentSizeSelection.allCases, id: \.self) { selection in
                                Text(selection.rawValue)
                                    .environment(\.sizeCategory, selection.contentSize)
                            }
                        }
                    }
                    
                    Section {
                        NavigationLink(destination: Text("Detail View")) {
                            Text("About")
                        }
                        
                        HStack {
                            Text("Version")
                            Spacer()
                            Text("0.1.0")
                        }
                    }
                }
                .accentColor(.white)
                .navigationBarTitle(Text("Settings"))
                .listStyle(GroupedListStyle())
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            store: Store(
                initialState: SettingsState(),
                reducer: settingsReducer,
                environment: SettingsEnvironment()
            )
        )
    }
}
