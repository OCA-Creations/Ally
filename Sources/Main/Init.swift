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

    @Flag(name: [.long, .customShort("n")], help: "Produce no output when installing the tool.")
    var noOutput: Bool = false
}

extension Ally {

    enum InitError: Error {
        case functionNotFound
        case noOverwriteAllowed
    }

    struct Init: ParsableCommand {

        func conditionalPrint(_ items: Any..., separator: String = "\n", terminator: String = "\n") {
            if !options.noOutput {
                Swift.print(items.map({String(describing: $0)}).joined(separator: separator), terminator: terminator)
            }
        }

        static var configuration = CommandConfiguration(abstract: "Initialize and install ally.")

        @OptionGroup var options: InitOptions

        mutating func run() throws {
            // First, create the .ally file
            let installLocation = CommandLine.arguments[0]
            // We actually want to create a ZSH function for the 
            let fileContents = """
           alias ally=\(installLocation)
           """
//            guard let fileContents else {
//                Ally.exit(withError: InitError.functionNotFound)
//            }
            let fileLocation = Ally.dotFileLocation

            if FileManager.default.fileExists(atPath: fileLocation.absoluteString) {
                let overwriteFile = input("[WARNING] Your .ally file exists. Do you want us to overwrite it? WARNING: THIS CANNOT BE UNDONE! (y/n): ")
                if overwriteFile == "y" {
                    try writeAllyFile(overwrite: true)
                } else {
                    boldPrint("We are not overwriting your .ally file. Exiting now.")
                    Ally.exit(withError: InitError.noOverwriteAllowed)
                }

            } else {

                // It doesn't exist, create it
                FileManager.default.createFile(atPath: fileLocation.absoluteString, contents: nil)
                try? fileContents.write(to: fileLocation, atomically: true, encoding: .utf8)
                print("[SYSTEM] Created .ally file.")
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
                            print("[ERROR] Saving ZSHRC: \(error.localizedDescription)")
                        }
                    }
                } else {
                    conditionalPrint("[WARNING] No .zshrc found.")
                }
            } else {
                conditionalPrint("[SYSTEM] Not adding to ZSHRC.")
            }

            // Source just .zshrc - our file will be sourced as a result
           conditionalPrint("""
[SYSTEM] .zshrc and .ally files are set up.
To reload your current shell session, execute the following command:
source $HOME/.ally
""")

        }

        func writeAllyFile(overwrite: Bool) throws {

        }
    }
}
