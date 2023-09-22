//
//  Input.swift
//  
//
//  Created by Owen Cruz-Abrams on 9/21/23.
//

import Foundation

///Gets user input from STDIO.
///- Note: The default implimentation of this function requires items. Use the ``input(_:terminator:)`` function to get input without printing anything.
///- Parameters:
///   - items: Zero or more items to print.
///   - separator: A string to print between each item. The default is a single
///     space (`" "`).
///   - terminator: The string to print after all items have been printed, before the user input. The
///     default is a space: (`" "`).
///- Warning: This function will **not return a value** until the user gives it input. Therefore, just pressing `Enter` will not cause the function to return an empty string.
func input(_ items: Any..., separator: String = " ", terminator: String = " ") -> String {
    print(items, separator: separator, terminator: terminator)
    while let line = readLine(strippingNewline: false) {
        return line
    }
    return ""
}
///Gets user input from STDIO, with or without a message.
///- Note: This function only allows a prompt of `String`. This is optional, and a value will be returned no matter what. To have more of the default ``print(_:separator:terminator:`` functionality, use ``input(_:separator:terminator:)``.
///- Parameters:
///   - prompt: The optional prompt to output before the user's response.
///   - terminator: The string to print after the `prompt` has been printed, before the user input. The
///     default is a space: (`" "`).
///- Warning: This function will **not return a value** until the user gives it input. Therefore, just pressing `Enter` will not cause the function to return an empty string.
func input(_ prompt: String? = nil, terminator: String = " ") -> String {
    if let prompt {
        print(prompt, terminator: terminator)
    }
    while let line = readLine(strippingNewline: false) {
        return line
    }
    return ""
}
