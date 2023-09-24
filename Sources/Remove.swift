//
//  Remove.swift
//  
//
//  Created by Owen Cruz-Abrams on 9/21/23.
//

import Foundation
import ArgumentParser

struct RemoveOptions: ParsableArguments {
    
    @Flag(name: [.long, .customShort("o")], help: "Produce no output when installing the tool.")
    var noOutput: Bool = false
    
    @Flag(name: [.long], help: "Don't reload the shell after installing the tool.")
    var noReload: Bool = false
    
    @Argument(help: "The alias to remove from the .ally file. This will not be removed from ZSHRC if it is there.")
    var alias: String
    
}

extension Ally {
    struct Remove: ParsableCommand {
        
        func conditionalOutput(_ str: String) {
            if !options.noOutput {
                print(str)
            }
        }
        @OptionGroup var options: RemoveOptions
        
        mutating func run() throws {
            // First, get the contents of .ally file
            var dotAllyContents = try String(contentsOf: Ally.dotFileLocation, encoding: .utf8)
            // First, sort by lines
            var lines = dotAllyContents.split(separator: "\n")
            
            // Now, find the line that says alias X
            let finder = "alias \(options.alias)"
            for (index, i) in lines.enumerated() {
                if i.localizedCaseInsensitiveContains(finder) {
                    lines.remove(at: index)
                    conditionalOutput("Alias removed: \(options.alias).")
                }
            }
            dotAllyContents = lines.joined(separator: "\n") + "\n"
            try dotAllyContents.write(to: Ally.dotFileLocation, atomically: true, encoding: .utf8)
            print(".Ally file has been resaved, and \(options.alias) is no longer available. To make these settings take effect for this terminal session, ")
        }
    }
}
