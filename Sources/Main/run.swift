// Welcome to Ally! This file is called run.swift, not main.swift, because calling it `main` produces errors with the `@main` declaration.

import Foundation
import ArgumentParser

//TODO: Can we have a lower version requirement?

@main
struct Ally: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "ally",
        abstract: "A utility for managing ZSH aliases.",
        subcommands: [Add.self, Init.self, List.self, Remove.self, Dot.self],
        defaultSubcommand: Add.self)
    
    /// The location of the user's `.ally` file on their system.
    static var dotFileLocation = {
        var homeDirectory = FileManager.default.homeDirectoryForCurrentUser
        if #available(macOS 13.0, *) {
            homeDirectory.append(path: ".ally")
        } else {
            homeDirectory = homeDirectory.appendingPathComponent(".ally")
        }
        return homeDirectory
    }()
    
    /// The location of the user's `.zshrc` config file on their system.
    static var zshrcFileLocation = {
        var homeDirectory = FileManager.default.homeDirectoryForCurrentUser
        if #available(macOS 13.0, *) {
            homeDirectory.append(path: ".zshrc")
        } else {
            homeDirectory = homeDirectory.appendingPathComponent(".zshrc")
        }
        return homeDirectory
    }()
}
