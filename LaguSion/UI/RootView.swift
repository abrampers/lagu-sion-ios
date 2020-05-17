//
//  RootView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 10/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import SwiftUI



struct RootView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            EmptyView()
                .tabItem {
                    VStack {
                        Image(systemName: "globe")
                        Text("Main")
                    }
                }
                .tag(0)
            TestCombineGRPCView()
                .tabItem {
                    VStack {
                        Image(systemName: "globe")
                        Text("CombineGRPC")
                    }
                }
                .tag(1)
            Text("First View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("first")
                        Text("First")
                    }
                }
                .tag(2)
            Text("Second View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Second")
                    }
                }
                .tag(3)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
