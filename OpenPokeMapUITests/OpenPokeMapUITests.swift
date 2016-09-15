//
//  OpenPokeMapUITests.swift
//  OpenPokeMapUITests
//
//  Created by Jamie Bishop on 08/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import XCTest

class OpenPokeMapUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {

        
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Map"].tap()
        let map = tabBarsQuery.buttons["Map"].tap()
        sleep(10)
        snapshot("Map")
        tabBarsQuery.buttons["IV"].tap()
        snapshot("IV")
        app.navigationBars["IV Calculator"].buttons["Help"].tap()
        app.navigationBars["OpenPokeMap.Help"].buttons["Close"].tap()
        tabBarsQuery.buttons["About"].tap()
        snapshot("About")
        
        
    }
    
}
