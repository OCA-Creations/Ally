//
//  Command.swift
//  
//
//  Created by Owen Cruz-Abrams on 9/21/23.
//

import Foundation
import ArgumentParser

enum Command: ExpressibleByArgument {
    init?(argument: String) {
        if argument.lowercased().contains("install") {
            self = .install
        } else if argument.lowercased().contains("alias") {
            self = .alias
        }
        return nil
    }
    
    case install
    case alias
}
