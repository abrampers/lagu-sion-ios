//
//  SnapshotUITests.swift
//  SnapshotUITests
//
//  Created by Abram Situmorang on 07/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import XCTest

class SnapshotUITests: XCTestCase {
    override func setUp() {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        
        let app = XCUIApplication()
        snapshot("01Home")
        let button = app.tables/*@START_MENU_TOKEN@*/.buttons["1\nDi Hadapan Hadirat-Mu"]/*[[".cells.buttons[\"1\\nDi Hadapan Hadirat-Mu\"]",".buttons[\"1\\nDi Hadapan Hadirat-Mu\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        button.tap()
        
        snapshot("02Song")
        let lsNo1NavigationBar = app.navigationBars["LS no. 1"]
        lsNo1NavigationBar.buttons["heart"].tap()
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Favorites"].tap()
        snapshot("03Favorites")
        
        button.tap()
        snapshot("04FavoritedSong")
        
        lsNo1NavigationBar.buttons["Favorites"].tap()
        tabBarsQuery.buttons["Settings"].tap()
        snapshot("05Settings")
        
        // UI tests must launch the application that they test.
        app.launch()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
