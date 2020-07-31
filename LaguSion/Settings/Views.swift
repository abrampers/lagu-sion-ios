//
//  Views.swift
//  Settings
//
//  Created by Abram Situmorang on 31/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

public struct SettingsView: View {
    let store: Store<SettingsState, SettingsAction>
    
    public init(store: Store<SettingsState, SettingsAction>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationView {
            Text("HAHA")
            .navigationBarTitle(Text("Settings"))
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
