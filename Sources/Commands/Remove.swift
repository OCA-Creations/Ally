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
        static var configuration = CommandConfiguration(
            commandName: "remove",
            abstract: "Remove an alias from the Ally/ZSH config."
        )
        @OptionGroup var options: RemoveOptions

        mutating func run() throws {

            // Now, find the line that says alias X
            for alias in options.alias {
                try scanAndRemoveIfNeeded(alias: alias, fileLocation: Ally.dotFileLocation, conditionalOutput: !options.noOutput)
                if options.zshrc {
                    try scanAndRemoveIfNeeded(
                        alias: alias,
                        fileLocation: Ally.zshrcFileLocation,
                        conditionalOutput: !options.noOutput
                    )
                }
            }
        }
    }
}

func scanAndRemoveIfNeeded(alias: String, fileLocation: URL, conditionalOutput: Bool) throws {
    var dotAllyContents = try String(contentsOf: fileLocation, encoding: .utf8)
    var lines = dotAllyContents.split(separator: "\n")
    let finder = "alias \(alias)"
    for (index, line) in lines.enumerated() {
        if line.localizedCaseInsensitiveContains(finder) {
            lines.remove(at: index)
            // Remove all lines above the index that are #s as well
            for (lineIndex, line) in lines[0..<index].reversed().enumerated() {
                print(line)
                if line.trimmingCharacters(in: .whitespacesAndNewlines).starts(with: "#") && !line.isEmpty {
                    lines.remove(at: lineIndex)
                } else if !line.isEmpty {
                    break
                }
            }
            if conditionalOutput {
                print("Alias removed from \(fileLocation.lastPathComponent): ", terminator: "")
                boldPrint(alias)
            }
        }
    }
    dotAllyContents = lines.joined(separator: "\n") + "\n"
    try dotAllyContents.write(to: fileLocation, atomically: true, encoding: .utf8)
    if conditionalOutput {
        print("Dot Ally file resaved. Alias ", terminator: "")
        boldPrint(alias, terminator: " ")
        print("No longer available.")
        print("[WARNING] Terminal may require reload.")
    }
}
