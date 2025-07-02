//
//  DotFileParsingTests.swift
//  
//
//  Created by Owen Cruz-Abrams on 1/23/24.
//

import XCTest
@testable import Ally

final class DotFileParsingTests: XCTestCase {

    override func setUpWithError() throws {
        let bundle = Bundle(for: DotFileParsingTests.self)
        let homeURL = bundle.bundleURL.appendingPathComponent("DotFiles")
        setenv("HOME", homeURL.absoluteString, 0)
        print(FileManager.default.homeDirectoryForCurrentUser)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        print(FileManager.default.homeDirectoryForCurrentUser)
    }

    func testMultilineCommandParsing() throws {
        // Create a temporary .ally file with multi-line commands
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("test_multiline.ally")
        
        let allyContent = """
        alias simple="echo hello"
        
        # Multi-line alias with docs
        alias multiline="echo line1
        echo line2
        echo line3"
        
        alias another="echo world"
        
        # Test multiline without proper termination
        alias testml="echo first
        echo second"
        """
        
        try allyContent.write(to: tempURL, atomically: true, encoding: .utf8)
        
        // Parse the file
        let dotFile = try DotFile.parseAllyFile(fileLocation: tempURL)
        
        // Verify that we parsed the correct number of aliases
        XCTAssertEqual(dotFile.aliases.count, 4, "Should parse all 4 aliases including multi-line ones")
        
        // Verify specific aliases
        let aliasNames = dotFile.aliases.map { $0.aliasName }
        XCTAssertTrue(aliasNames.contains("simple"), "Should contain simple alias")
        XCTAssertTrue(aliasNames.contains("multiline"), "Should contain multiline alias")
        XCTAssertTrue(aliasNames.contains("another"), "Should contain another alias")
        XCTAssertTrue(aliasNames.contains("testml"), "Should contain testml alias")
        
        // Verify multi-line command content
        let multilineAlias = dotFile.aliases.first { $0.aliasName == "multiline" }
        XCTAssertNotNil(multilineAlias, "Should find multiline alias")
        XCTAssertTrue(multilineAlias!.longFormCommand.contains("echo line1"), "Should contain first line")
        XCTAssertTrue(multilineAlias!.longFormCommand.contains("echo line2"), "Should contain second line")
        XCTAssertTrue(multilineAlias!.longFormCommand.contains("echo line3"), "Should contain third line")
        
        // Clean up
        try? FileManager.default.removeItem(at: tempURL)
    }

    func testMultilineCommandDoesNotCrash() throws {
        // Test the specific case that used to crash - lines without "="
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("test_crash.ally")
        
        let allyContent = """
        alias broken="echo start
        this line has no equals sign
        echo end"
        """
        
        try allyContent.write(to: tempURL, atomically: true, encoding: .utf8)
        
        // This should not crash
        XCTAssertNoThrow(try DotFile.parseAllyFile(fileLocation: tempURL))
        
        let dotFile = try DotFile.parseAllyFile(fileLocation: tempURL)
        XCTAssertEqual(dotFile.aliases.count, 1, "Should parse the broken alias correctly")
        
        // Clean up
        try? FileManager.default.removeItem(at: tempURL)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
