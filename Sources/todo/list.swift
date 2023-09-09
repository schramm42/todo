import ColorizeSwift
import SwiftCLI


class ListCommand: Command {
    let name = "list"

    @Key("-s", "--status", description: "Filter by status")
    var taskStatus: TaskStatus?

    func execute() throws {
        do {
            var tasks = try TaskStore.shared.load().getTasks()

            tasks.sort {
                $0.id < $1.id
            }

            if (taskStatus != nil) {
                tasks = tasks.filter { task in
                    return task.status == taskStatus
                }
            }

            try Display.printTaskList(tasks: tasks)
        }
        catch {
            print(error)
        }

    }
}
