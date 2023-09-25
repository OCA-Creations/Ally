//
//  List.swift
//  
//
//  Created by Owen Cruz-Abrams on 9/23/23.
//

import Foundation
import ArgumentParser

struct ListOptions: ParsableArguments {
    @Flag(name: [.long], help: "Don't output the included, user-created docs for the command.")
    var noDocs: Bool = false
    
    @Option(name: [.long, .short], help: "The output file location. All list output will be saved to this file.")
    var outputLocation: String? = nil
}

extension Ally {
    struct List: ParsableCommand {
        @OptionGroup var options: ListOptions
        
        mutating func run() throws {
            // Parse DotFile
            do {
                let dotFile = try DotFile.parseAllyFile(fileLocation: Ally.dotFileLocation)
                dotFile.output(docs: !options.noDocs)
            } catch {
                print("There was an error reading your .ally file: \(error.localizedDescription).")
            }
            
            
        }
    }
}
