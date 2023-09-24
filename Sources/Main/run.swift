// Welcome to Ally! This file is called run.swift, not main.swift, because calling it `main` produces errors with the `@main` declaration.

import Foundation
import ArgumentParser

//TODO: Can we have a lower version requirement?

@main
struct Ally: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "ally",
        abstract: "A utility for managing ZSH aliases.",
        subcommands: [Add.self, Init.self, Remove.self],
        defaultSubcommand: Add.self)
    
    /// The location of the user's `.ally` file on their system.
    static var dotFileLocation: URL = FileManager.default.homeDirectoryForCurrentUser.appendingPathExtension(".ally")
    
    /// The location of the user's `.zshrc` config file on their system.
    static var zshrcFileLocation: URL = FileManager.default.homeDirectoryForCurrentUser.appendingPathExtension(".zshrc")
}
