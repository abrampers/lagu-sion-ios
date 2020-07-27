//
//  MainTests.swift
//  MainTests
//
//  Created by Abram Situmorang on 24/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Combine
import ComposableArchitecture
import SwiftUI
import XCTest

@testable import Main

class MainTests: XCTestCase {
    func testAlert() {
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MainEnvironment(
                mainQueue: <#AnySchedulerOf<DispatchQueue>#>,
                grpc: <#GRPCExecutor#>,
                laguSionClient: <#Lagusion_LaguSionServiceClientProtocol#>
            )
        )
    }
}
