// This code was fetched from https://stackoverflow.com/questions/26971240/how-do-i-run-a-terminal-command-in-a-swift-script-e-g-xcodebuild

// TODO: This may only be necessary for the initializer, which can be called directly. Skippable? We would need to abstract initializer logic.
import Foundation

@discardableResult
func safeShell(_ command: String) throws -> String {
    // TODO: Let's make this the current process. Can we call something like `Process.main`?
    let task = Process()
    let pipe = Pipe()

    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.executableURL = URL(fileURLWithPath: "/bin/zsh")
    task.standardInput = nil

    try task.run()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!

    return output
}
