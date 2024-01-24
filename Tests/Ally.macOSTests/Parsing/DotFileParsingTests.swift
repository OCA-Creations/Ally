//
//  DotFileParsingTests.swift
//  
//
//  Created by Owen Cruz-Abrams on 1/23/24.
//

import XCTest

final class DotFileParsingTests: XCTestCase {

    override func setUpWithError() throws {
        let bundle = Bundle(for: DotFileParsingTests.self)
        let homeURL = bundle.bundleURL.appendingPathComponent("DotFiles", conformingTo: .folder)
        setenv("HOME", homeURL.absoluteString, 0)
        print(FileManager.default.homeDirectoryForCurrentUser)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        print(FileManager.default.homeDirectoryForCurrentUser)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
