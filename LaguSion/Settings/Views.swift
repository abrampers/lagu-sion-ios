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
            List {
                Section {
                    NavigationLink(destination: Text("Detail View")) {
                        HStack {
                            ZStack {
                                Image(systemName: "airplane").font(.callout).foregroundColor(.white)
                            }.frame(width: 28, height: 28).background(Color.orange).cornerRadius(6)
                            Text("Airplane Mode")
                        }
                    }
                    NavigationLink(destination: Text("Detail View")) {
                        HStack {
                            ZStack {
                                Image(systemName: "wifi").font(.callout).foregroundColor(.white)
                            }.frame(width: 28, height: 28).background(Color.blue).cornerRadius(6)
                            Text("Wi-Fi")
                        }
                    }
                    NavigationLink(destination: Text("Detail View")) {
                        HStack {
                            ZStack {
                                Image(systemName: "wifi").font(.callout).foregroundColor(.white)
                            }.frame(width: 28, height: 28).background(Color.blue).cornerRadius(6)
                            Text("Bluetooth")
                        }
                    }
                    NavigationLink(destination: Text("Detail View")) {
                        HStack {
                            ZStack {
                                Image(systemName: "phone.fill").font(.callout).foregroundColor(.white)
                            }.frame(width: 28, height: 28).background(Color.green).cornerRadius(6)
                            Text("Cellular")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: Text("Detail View")) {
                        HStack {
                            ZStack {
                                Image(systemName: "app.badge").font(.callout).foregroundColor(.white)
                            }.frame(width: 28, height: 28).background(Color.red).cornerRadius(6)
                            Text("Notifications")
                        }
                    }
                    NavigationLink(destination: Text("Detail View")) {
                        HStack {
                            ZStack {
                                Image(systemName: "gear").font(.callout).foregroundColor(.white)
                            }.frame(width: 28, height: 28).background(Color.gray).cornerRadius(6)
                            Text("General")
                        }
                    }
                }
            }
            .accentColor(.white)
            .navigationBarTitle(Text("Settings"))
            .listStyle(GroupedListStyle())
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
