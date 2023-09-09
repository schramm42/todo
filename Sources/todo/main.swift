import SwiftCLI

let todo = CLI(name: "todo", version: "v0.0.1")

todo.commands = [
    ListCommand(), 
    CreateCommand(), 
    DeleteCommand(), 
    ShowCommand(), 
    SetCommand(),
]

todo.aliases["add"] = "create"
todo.aliases["ls"] = "list"
todo.aliases["rm"] = "delete"
todo.aliases["get"] = "show"

todo.go()