//
//  Alias.swift
//  
//
//  Created by Owen Cruz-Abrams on 9/21/23.
//

import Foundation
import ArgumentParser
import Darwin

struct AddOptions: ParsableArguments {
    @Flag(name: [.long], help: "Don't reload the terminal (a.k.a don't run `source`) after adding the alias.")
    var noReload = false
    
    @Flag(name: [.long], help: "Produce no output.")
    var noOutput = false

    @Argument(help: "The alias to be added. This is the command that will be given in the future, not the longform version being aliased to.")
    var alias: String
    
    @Argument(help: "The long-form command to be aliased to `alias`.")
    var command: String
}

extension Ally {
    
    struct Add: ParsableCommand {
        func conditionalPrint(_ str: String) {
            if !options.noOutput {
                print(str)
            }
        }
        static var configuration = CommandConfiguration(abstract: "Add an alias to the zsh config.")
        
        @OptionGroup var options: AddOptions
        
        mutating func run() throws {
            // First, check to ensure that .ally exists. If not, run ally install --no-output
            let dotFileLocation = Ally.dotFileLocation
            if FileManager.default.fileExists(atPath: dotFileLocation.relativePath) {
                // Continue
            } else {
                let yesorno = input("Ally has not yet been installed, would you like to install it? (y/n)")
                if yesorno != "y" {
                    Ally.Add.exit(withError: nil)
                }
                do {
                    try safeShell("ally install --no-output")
                    conditionalPrint("Ally is now installed, congratulations! Continuing.")
                } catch {
                    conditionalPrint("There was an error installing ally: \(error.localizedDescription). Exiting now.")
                    Ally.Add.exit(withError: nil)
                }
            }
            // Ally is now installed, so we can procede.
            // Step #1: Create the new alias line
            let aliasLine = """
alias \(options.alias)="\(options.command)"
"""
            // Step #2: Add it to .ally
            do {
                var fileContents = try String(contentsOf: dotFileLocation, encoding: .utf8)
                if fileContents.range(of: aliasLine) == nil {
                    fileContents += aliasLine
                    try fileContents.write(to: dotFileLocation, atomically: true, encoding: .utf8)
                }
                
            } catch {
                conditionalPrint("There was an error when attempting to write the alias: \(error.localizedDescription)")
            }
            
            if !options.noReload {
                _ = try? safeShell("source $HOME/.ally")
                conditionalPrint("The shell has been reloaded, and your alias is now ready to use!")
            } else {
                conditionalPrint("As requested, we did not reload the shell. You may have to do so on your own.")
            }
            
            
        }
    }
    
}
