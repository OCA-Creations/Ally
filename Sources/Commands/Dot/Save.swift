//
//  Save.swift
//
//
//  Created by Owen Cruz-Abrams on 11/13/23.
//

import Foundation
import ArgumentParser

struct SaveOptions: ParsableArguments {
}
extension Ally.Dot {
    struct Save: ParsableCommand {
        static var configuration: CommandConfiguration = CommandConfiguration(commandName: "save", abstract: "Save the \u{001b}[1m.ally\u{001b}[0m file to a given location for sharing or later use.")
    }
}
