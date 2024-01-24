//
//  FancyPrint.swift
//
//
//  Created by Owen Cruz-Abrams on 11/12/23.
//

import Foundation

/// Print  `content` to STDOUT in bold text
func boldPrint(_ content: String, terminator: String = "\n") {
    print("\u{001b}[1m\(content)\u{001b}[0m", terminator: terminator)
}
/// Print MarkDown `content` to STDOUT.
/// - parameter content: The `MarkDown` content to print. See `Notes` for supported MD formatting.
/// - parameter terminator: How to terminate the printed line. **Default:** `\n`
func markDownPrint(_ content: String, terminator: String = "\n") {

}
