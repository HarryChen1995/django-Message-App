//
//  django_Message_AppUITests.swift
//  django Message AppUITests
//
//  Created by Hanlin Chen on 11/11/21.
//

import XCTest

class django_Message_AppUITests: XCTestCase {
    let username = "harrychen123"
    let password = "123456789!"
    var app :XCUIApplication!
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }


    func testLogin() throws {
     
        
      
        
  
        let username = app.textFields["User Name"]
        let password = app.secureTextFields["Password"]
        let login = app.buttons["Sign In"]
        
        XCTAssert(username.exists)
        XCTAssert(password.exists)
        XCTAssert(login.exists)
        
        username.tap()
        username.typeText(self.username)
        
        password.tap()
        password.typeText(self.password)
        
        // login
        login.tap()
        
        let isLoggedIn = app.staticTexts["You are logged in !"]
        
        XCTAssert(isLoggedIn.waitForExistence(timeout: 2))
   
    }
    
    
    func testLogout() throws {

        
  
        let username = app.textFields["User Name"]
        let password = app.secureTextFields["Password"]
        let login = app.buttons["Sign In"]

        
        username.tap()
        username.typeText(self.username)
        
        password.tap()
        password.typeText(self.password)
        
        // login
        login.tap()
        
        let isLoggedIn = app.staticTexts["You are logged in !"]
        
        XCTAssert(isLoggedIn.waitForExistence(timeout: 2))
        
        // logout
        let logout = app.buttons["Logout"]
        XCTAssert(logout.exists)
        
        logout.tap()
        
        XCTAssert(username.waitForExistence(timeout: 2))
        
    
    }
   
    override func tearDownWithError() throws {
        
      
    }
}
