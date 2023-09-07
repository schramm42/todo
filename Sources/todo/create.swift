import SwiftCLI
import ColorizeSwift

class CreateCommand: Command {
    let name = "create"

    @Param var taskName: String?

    func execute() throws {
        do {
            var nameOfTask: String
            if (taskName == nil) {
                nameOfTask = Input.readLine(
                    prompt: "Name of task:"
                )
            } else {
                nameOfTask = taskName!
            }

            let task = try TaskStore.shared
                .load()
                .addTask(name: nameOfTask)
                
            _ = try TaskStore.shared.save()

            try Display.printTask(task: task)
        } catch {
            print(error)
        }
    }
}
