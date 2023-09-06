import SwiftCLI
import ColorizeSwift

class DeleteCommand: Command {
    let name = "delete"

    @Flag("-y", "--assume-yes", description: "Interaktive Fragen werden automatisch mit 'YES'/'JA' beantwortet")
    var assumeYes: Bool

    @Param var id: Int?

    func execute() throws {
        do {

            var idToDelete: Int
            if (id == nil) {
                idToDelete = Input.readInt(
                    prompt: "Id of the task to delete?:"
                )
            } else {
                idToDelete = id!
            }

            // print("IdToDelete: \(idToDelete)")

            if (!TaskStore.shared.taskExists(id: idToDelete)) {
                throw TaskError.notExists
            }

            try TaskStore.shared.deleteTask(id: idToDelete)
            print("Task #\(idToDelete) is deleted")
            
        } catch TaskError.notExists {
            print("Task doesn't exists")
        } catch {
            print(error)
        }
    }
}
