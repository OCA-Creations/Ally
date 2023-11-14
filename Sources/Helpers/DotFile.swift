//
//  DotFile.swift
//  
//
//  Created by Owen Cruz-Abrams on 9/23/23.
//

import Foundation

//TODO: Should we integrate this into logic for Init, Input, etc?
struct DotFile: Codable {
    var location: URL
    
    var aliases: [DotFile.Alias]
    
    init(location: URL, aliases: [DotFile.Alias]) {
        self.location = location
        self.aliases = aliases
    }
    
    
    /// Print the ``DotFile`` to STDOUT.
    /// - Parameter docs: Whether to print out the docs for each alias in addition to the alias itself.
    func output(docs: Bool) {
        print("You have ", terminator: "")
        boldPrint("\(self.aliases.count)", terminator: " ")
        print("aliases added in Ally.")
        for i in self.aliases {
            if docs {
                if let idocs = i.docs {
                    boldPrint(idocs)
                }
                
            }
            boldPrint("\(i.aliasName)", terminator: " -> ")
            print(i.longFormCommand)
        }
    }
}

//MARK: - Parsing extensions + types
extension DotFile {
    struct Alias: Codable {
        var docs: String?
        var aliasName: String
        var longFormCommand: String
        
        init(docs: String? = nil, aliasName: String, longFormCommand: String) {
            self.docs = docs
            self.aliasName = aliasName
            self.longFormCommand = longFormCommand
        }
    }
    
    static func parseAllyFile(fileLocation: URL) throws -> DotFile {
        
        func parseAlreadyDocs(alreadyDocs: String, index: Int, lines: [String]) -> [Self.Alias] {
            var returnable = [Self.Alias]()
            if index > lines.count-1 {
                return returnable
            }
            let currentLine = lines[index]
            if currentLine.trimmingCharacters(in: .whitespacesAndNewlines).starts(with: "#") {
                let alDocs = alreadyDocs + "\n" + currentLine
                returnable += parseAlreadyDocs(alreadyDocs: alDocs, index: index+1, lines: lines)
            } else {
                let parts = currentLine.split(separator: "=").map { sub in
                    String(sub)
                }
                var firstPart = parts[0]
                let firstPartFifthIndex = firstPart.index(firstPart.startIndex, offsetBy: 5)
                firstPart = String(firstPart[firstPartFifthIndex...])
                firstPart = firstPart.replacingOccurrences(of: "alias ", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
                let secondPart = parts[1]
                returnable.append(Self.Alias.init(docs: alreadyDocs, aliasName: firstPart, longFormCommand: secondPart))
                returnable += parseAlreadyDocs(alreadyDocs: "", index: index+1, lines: lines)
                    
                
            }
            
            return returnable
        }
        // Get the contents
        let fileContents = try String(contentsOf: fileLocation, encoding: .utf8)
        // Split by newlines. While aliases will only take up one line, it's worth noting that docs can take up several. Thus, we parse by the end of each line NOT containing "#"
        let fileContentsList = fileContents.split(separator: "\n").map { sub in
            String(sub)
        }
        let aliases: [Self.Alias] = parseAlreadyDocs(alreadyDocs: "", index: 0, lines: fileContentsList)
        
        return DotFile(location: fileLocation, aliases: aliases)
        
        
    }
}
