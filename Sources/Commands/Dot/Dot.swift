//
//  Dot.swift
//
//
//  Created by Owen Cruz-Abrams on 11/13/23.
//

import Foundation
import ArgumentParser

extension Ally {
    struct Dot: ParsableCommand {
        static var configuration: CommandConfiguration = CommandConfiguration(
            commandName: "dot",
            abstract: "Work with Ally's dotfile (the \u{001b}[1m.ally\u{001b}[0m file).",
            subcommands: [Open.self, Format.self],
            defaultSubcommand: Open.self
        )
    }
}
extension Ally.Dot {
    struct Open: ParsableCommand {
        static func transformURL(_ str: String) -> URL {
           let newStr = str.replacingOccurrences(of: "~", with: FileManager.default.homeDirectoryForCurrentUser.path)
           return URL(fileURLWithPath: newStr)
       }

        @Option(help: "The location of the \u{001b}[1m.ally\u{001b}[0m file.", transform: transformURL(_:))
        var location: URL = Ally.dotFileLocation

        @Option(name: [.long, .customShort("a")], help: "The app/executable with which to open the \u{001b}[1m.ally\u{001b}[0m file. \u{001b}[1mDefault:\u{001b}[0m system default text editor.")
        var editor: String?

        // Thank you https://forums.swift.org/t/parsing-file-urls-with-argumentparser/34173
        mutating func validate() throws {
            // Verify the file actually exists.
            if #available(macOS 13.0, *) {
                guard FileManager.default.fileExists(atPath: location.path()) else {
                    throw ValidationError("File does not exist at \(location.path())")
                }
            } else {
                guard FileManager.default.fileExists(atPath: location.path) else {
                    throw ValidationError("File does not exist at \(location.path)")
                }
            }
        }

        func openFile(_ filePath: String) {
            let process = Process()
            process.launchPath = "/usr/bin/env"
            if let editor = editor {
                process.arguments = ["open", filePath, "-a", editor]
            } else {
                process.arguments = ["open", filePath]
            }

            process.launch()
            process.waitUntilExit()
        }

        mutating func run() throws {
            if #available(macOS 13.0, *) {
                openFile(location.path())
            } else {
                openFile(location.path)
            }
        }
    }

    struct Format: ParsableCommand {
        // TODO: Implement formatting of .ally file
    }
}
