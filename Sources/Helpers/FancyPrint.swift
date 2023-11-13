//
//  FancyPrint.swift
//
//
//  Created by Owen Cruz-Abrams on 11/12/23.
//

import Foundation

func boldPrint(_ content: String, terminator: String = "\n") {
    print("\u{001b}[1m\(content)\u{001b}[0m", terminator: terminator)
}
