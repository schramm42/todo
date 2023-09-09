import SwiftCLI

class SetCommand: Command {

    let name = "set"

    @Key("-s", "--status", description: "Status of task")
    var taskStatus: TaskStatus?

    @Key("-n", "--name", description: "Name of task")
    var taskName: String?

    @Flag("-d", "--description", description: "Description of task")
    var taskDescription: Bool

    @Param var id: Int?

    func execute() throws {
        do {

            var idToProcess: Int
            if id == nil {
                idToProcess = Input.readInt(
                    prompt: "Id of the task to edit?:"
                )
            }
            else {
                idToProcess = id!
            }

            var task: Task = try TaskStore.shared
                .load()
                .getTask(id: idToProcess)

            if (taskStatus != nil) {
                task.status = taskStatus!
            }

            if (taskName != nil) {
                task.name = taskName!
            }

            if (taskDescription) {
                let description = Input.readLine(
                    prompt: "Description of the task?:"
                )
                task.description = description
            }

            _ = try TaskStore.shared
                .setTask(idToProcess, &task)
                .save()

            Display.printTask(task: task)
        }
        catch TaskError.notExists {
            print("Task doesn't exists")
        }
        catch {
            print(error)
        }
    }
}
