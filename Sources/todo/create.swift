import SwiftCLI
import ColorizeSwift

class CreateCommand: Command {
    let name = "create"

    @Param var taskName: String?

    func execute() throws {
        do {
            print("\(name)".bold().red())

            var nameOfTask: String
            if (taskName == nil) {
                nameOfTask = Input.readLine(
                    prompt: "Name of task:"
                )
            } else {
                nameOfTask = taskName!
            }

            try TaskStore.shared.addTask(name: nameOfTask)
        } catch {
            print(error)
        }
    }
}
