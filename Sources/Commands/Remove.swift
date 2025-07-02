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
    var lines = dotAllyContents.split(separator: "\n").map { String($0) }
    let finder = "alias \(alias)"
    var indexesToRemove: [Int] = []
    
    for (index, line) in lines.enumerated() {
        if line.localizedCaseInsensitiveContains(finder) {
            indexesToRemove.append(index)
            
            // Check if this is a multi-line alias by looking for unclosed quotes
            let parts = line.split(separator: "=", maxSplits: 1).map { String($0) }
            if parts.count >= 2 {
                let commandPart = parts[1]
                // If the command starts with a quote but doesn't end with one, it's multi-line
                if commandPart.hasPrefix("\"") && !commandPart.dropFirst().hasSuffix("\"") {
                    // Continue collecting lines until we find the closing quote
                    var currentIndex = index + 1
                    while currentIndex < lines.count {
                        indexesToRemove.append(currentIndex)
                        if lines[currentIndex].hasSuffix("\"") {
                            break
                        }
                        currentIndex += 1
                    }
                }
            }
            
            // Remove all lines above the index that are #s as well
            for reverseIndex in stride(from: index - 1, through: 0, by: -1) {
                let prevLine = lines[reverseIndex]
                if prevLine.trimmingCharacters(in: .whitespacesAndNewlines).starts(with: "#") && !prevLine.isEmpty {
                    indexesToRemove.append(reverseIndex)
                } else if !prevLine.isEmpty {
                    break
                }
            }
            
            if conditionalOutput {
                print("Alias removed from \(fileLocation.lastPathComponent): ", terminator: "")
                boldPrint(alias)
            }
            break // Only remove the first match
        }
    }
    
    // Remove lines in reverse order to maintain correct indices
    for index in indexesToRemove.sorted(by: >) {
        lines.remove(at: index)
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
