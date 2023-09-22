// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import ArgumentParser

@available(macOS 13.0, *)
@main
struct Ally: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "ally",
        abstract: "A utility for managing ZSH aliases.",
        subcommands: [Add.self, Init.self, Remove.self],
        defaultSubcommand: Add.self)
    
    /// The location of the user's `.ally` file on their system.
    static var dotFileLocation: URL = FileManager.default.homeDirectoryForCurrentUser.appending(path: ".ally")
}
