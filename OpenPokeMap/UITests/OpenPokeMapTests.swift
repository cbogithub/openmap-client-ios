//
//  OpenPokeMapTests.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 08/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import XCTest

class OpenPokeMapTests: XCTestCase {
        
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
        
        
        
    }
    
}
