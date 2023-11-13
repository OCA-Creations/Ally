//
//  Remove.swift
//  
//
//  Created by Owen Cruz-Abrams on 9/21/23.
//

import Foundation
import ArgumentParser

struct RemoveOptions: ParsableArguments {
    
    @Flag(name: [.long, .customShort("o")], help: "Produce no output while removing aliases.")
    var noOutput: Bool = false
    
    @Flag(name: [.long], help: "Reload the shell after removing the alias.")
    var reload: Bool = false
    
    @Argument(help: "The aliases to remove from the \u{001b}[1m.ally\u{001b}[0m file.")
    var alias: [String]
    
    @Flag(help: "Scan the \u{001b}[1m.zshrc\u{001b}[0m file for the aliases AS WELL AS the \u{001b}[1m.ally\u{001b}[0m file.")
    var zshrc: Bool = false
    
}

extension Ally {
    struct Remove: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Remove an alias from the Ally/ZSH config.")

        func conditionalOutput(_ str: String) {
            if !options.noOutput {
                print(str)
            }
        }
        @OptionGroup var options: RemoveOptions
        
        func scanAndRemoveIfNeeded(alias: String, fileLocation: URL) throws {
            var dotAllyContents = try String(contentsOf: fileLocation, encoding: .utf8)
            var lines = dotAllyContents.split(separator: "\n")
            let finder = "alias \(alias)"
            for (index, i) in lines.enumerated() {
                if i.localizedCaseInsensitiveContains(finder) {
                    lines.remove(at: index)
                    conditionalOutput("Alias removed from \(fileLocation.lastPathComponent): \u{001b}[1m\(alias)\u{001b}[0m.")
                }
            }
            dotAllyContents = lines.joined(separator: "\n") + "\n"
            try dotAllyContents.write(to: fileLocation, atomically: true, encoding: .utf8)
            conditionalOutput(".Ally file has been resaved, and \(alias) is no longer available in the \(fileLocation.lastPathComponent) file. To make these settings take effect for this terminal session, ")
        }
        
        mutating func run() throws {
            
            // Now, find the line that says alias X
            for alias in options.alias {
                try scanAndRemoveIfNeeded(alias: alias, fileLocation: Ally.dotFileLocation)
                if options.zshrc {
                    try scanAndRemoveIfNeeded(alias: alias, fileLocation: Ally.zshrcFileLocation)
                }
            }
            
        }
    }
}
