import ColorizeSwift
import SwiftCLI
import Table

class ListCommand: Command {
    let name = "list"

    func execute() throws {
        do {
            let tasks = TaskStore.shared.getTasks()

            var data = [
                ["ID", "Name", "Status"],
            ]

            for task in tasks {
                data.append([String(task.id), task.name, task.status])
            }

            let table = try Table(data: data).table()

            print(table)
        }
        catch {
            print(error)
        }

    }
}
