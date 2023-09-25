//
//  Init.swift
//  
//
//  Created by Owen Cruz-Abrams on 9/21/23.
//

import Foundation
import ArgumentParser

struct InitOptions: ParsableArguments {
    @Flag(name: [.long, .customShort("x")], help: "Don't add the source block to the end of .zshrc.")
    var noZSHRC: Bool = false
    
    @Flag(name: [.long, .customShort("o")], help: "Produce no output when installing the tool.")
    var noOutput: Bool = false
    
    @Flag(name: [.long], help: "Don't reload the shell after installing the tool.")
    var noReload: Bool = false
    
}

extension Ally {
    
    struct Init: ParsableCommand {
        
        func conditionalPrint(_ items: Any..., separator: String = "\n", terminator: String = "\n") {
            if !options.noOutput {
                Swift.print(items.map({String(describing: $0)}).joined(separator: separator), terminator: terminator)
            }
        }
        
        static var configuration = CommandConfiguration(abstract: "Initialize and install ally.")
        
        @OptionGroup var options: InitOptions
        
        mutating func run() throws {
            print("Tool is currently installed at: \(CommandLine.arguments[0])")
            // First, create the .ally file
            let installLocation = CommandLine.arguments[0]
            
            let fileContents = """
alias ally="\(installLocation)"

"""
            let fileLocation = Ally.dotFileLocation
            
            if FileManager.default.fileExists(atPath: fileLocation.absoluteString) {
                conditionalPrint("Your .ally file exists. We will not overwrite it. Continuing.")
            } else {
                // It doesn't exist, create it
                FileManager.default.createFile(atPath: fileLocation.absoluteString, contents: nil)
                try? fileContents.write(to: fileLocation, atomically: true, encoding: .utf8)
                print("Created .ally file.")
            }
            
            if !options.noZSHRC {
                // Add to zshrc
                let currentZSHRCContents = try? String(contentsOf: Ally.zshrcFileLocation)
//                print(currentZSHRCContents)
                if var currentZSHRCContents {
                    let new = "\n#Put this wherever - it adds the aliases.\nsource $HOME/.ally\n"
                    if (currentZSHRCContents.range(of: new)) == nil {
                        currentZSHRCContents += new
                        
                        
                        do {
                            try currentZSHRCContents.write(to: Ally.zshrcFileLocation, atomically: true, encoding: .utf8)
                        } catch {
                            print("Error saving ZSHRC: \(error.localizedDescription)")
                        }
                    }
                } else {
                    conditionalPrint("We couldn't find a .zshrc.")
                }
            } else {
                conditionalPrint("Not adding to ZSHRC.")
            }
            
            // Source just .zshrc - our file will be sourced as a result
           _ = try? safeShell("source ~/.zshrc")
            
            conditionalPrint("Everything is set.")
            
            
        }
    }
}