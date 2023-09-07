import ColorizeSwift
import SwiftCLI


class ListCommand: Command {
    let name = "list"

    func execute() throws {
        do {
            let tasks = try TaskStore.shared.load().getTasks()

            try Display.printTaskList(tasks: tasks)
        }
        catch {
            print(error)
        }

    }
}
