import SwiftCLI

class ShowCommand: Command {
    let name = "show"

    @Param var id: Int?

    func execute() throws {
        do {
            var idToShow: Int
            if (id == nil) {
                idToShow = Input.readInt(
                    prompt: "Id of the task to show?:"
                )
            } else {
                idToShow = id!
            }

            let task = try TaskStore.shared
                .load()
                .getTask(id: idToShow)
                
            Display.printTask(task: task)
        } catch {
            print(error)
        }
    }
}