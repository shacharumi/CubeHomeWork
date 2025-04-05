//
//  CubeHomeWorkTests.swift
//  CubeHomeWorkTests
//
//  Created by shachar on 2025/4/2.
//

import XCTest
@testable import CubeHomeWork

final class CubeHomeWorkTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_OnlyFriendListVC_loadsView() {
        let vc = OnlyFriendListVC()
        vc.loadViewIfNeeded()
        XCTAssertNotNil(vc.view, "View 應該被正確載入")
    }
    
    func test_OnlyFriendListVC_hasCustomNavBar() {
        let vc = OnlyFriendListVC()
        vc.loadViewIfNeeded()
        XCTAssertTrue(vc.view.subviews.contains(where: { $0 is CustomNavBar }), "CustomNavBar 應該存在於 view 中")
    }
}
