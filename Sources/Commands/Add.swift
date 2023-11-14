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
    @Argument(help: "The alias to be added. This is the command that will be given in the future, not the longform version being aliased to.")
    var alias: String
    
    @Argument(help: "The long-form command to be aliased to `alias`.")
    var command: String?
    
    @Option(help: "Description/title of the alias, to be put on the preceding line in the file.")
    var description: String?
    
    @Flag(name: [.long], help: "Reload the terminal (a.k.a run \u{001b}[1msource\u{001b}[0m) after adding the alias.")
    var reload = false
    
    @Flag(name: [.long], help: "Produce no output.")
    var noOutput = false
    
    
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
            if options.alias.localizedCaseInsensitiveContains("=") {
                let newOpts = options.alias.split(separator: "=", maxSplits: 1).map{String($0)}
                options.alias = newOpts[0]
                options.command = newOpts[1]
            }
            if let command = options.command {
                // First, check to ensure that .ally exists. If not, run ally init --no-output
                let dotFileLocation = Ally.dotFileLocation
                if FileManager.default.fileExists(atPath: dotFileLocation.relativePath) {
                    // Continue
                } else {
                    let yesorno = input("[SYSTEM] Ally has not yet been installed, would you like to install it? (y/n)")
                    if yesorno != "y" {
                        Ally.Add.exit(withError: nil)
                    }
                    do {
                        try safeShell("ally init --no-output")
                        conditionalPrint("[SYSTEM] Ally has been installed and initialized.")
                    } catch {
                        conditionalPrint("There was an error installing ally: \(error.localizedDescription). Exiting now.")
                        Ally.Add.exit(withError: nil)
                    }
                }
                // Ally is now installed, so we can procede.
                // Step #1: Create the new alias line
                var aliasLine: String
                if let description = options.description {
                    aliasLine = """
    
    # \(description)
    alias \(options.alias)="\(command)"
    """
                } else {
                    aliasLine = """
    
    alias \(options.alias)="\(command)"
    """
                }
                
                // Step #2: Add it to .ally
                do {
                    var fileContents = try String(contentsOf: dotFileLocation, encoding: .utf8)
                    // Check to see if the alias itself is already in there
                    if fileContents.range(of: "alias \(options.alias)") == nil {
                        fileContents += aliasLine
                        try fileContents.write(to: dotFileLocation, atomically: true, encoding: .utf8)
                    } else {
                        conditionalPrint("[WARNING] alias \u{001b}[1m\(options.alias)\u{001b}[0m ALREADY EXISTS. Skipping.")
                    }
                    
                } catch {
                    conditionalPrint("[ERROR] Saving alias to disk: \(error.localizedDescription)")
                }
                
                if options.reload {
                    //                system("source $HOME/.ally")
                    // TODO: Reload shell
                    conditionalPrint("Shell reloaded.")
                } else {
                    conditionalPrint("[NOTE]: Shell may require reload.")
                }
            }
            else {
                print("[ERROR] No value provided to alias '\u{001b}[1m\(options.alias)\u{001b}[0m' TO. Please provide a long-form command to set the alias to.")
            }
            
        }
    }
    
}
