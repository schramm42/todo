import Foundation
import Stores

struct Task: Codable {
    let id: Int
    let name: String
    let description: String?
    let dateCreate: Date?
    let dateModified: Date?
    let status: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case dateCreate = "date_create"
        case dateModified = "date_modified"
        case status = "status"
    }
}

extension Task: Identifiable {}

enum TaskError: Error {
    case notExists
}

final class TaskStore {
    private let store = MultiFileSystemStore<Task>(path: "tasks")

    public static let shared: TaskStore = TaskStore()

    init() {
        // self.store = SingleFileSystemStore<Task>(path: "tasks")
    }

    public func addTask(name: String) throws {
        let maxId = self.store.allObjects().map({ $0.id }).max() ?? 0

        let now = Date()
        let task = Task(
            id: maxId + 1,
            name: name,
            description: "",
            dateCreate: now,
            dateModified: now,
            status: "todo"
        )

        try self.store.save(task)
    }

    public func getTasks() -> [Task] {
        return self.store.allObjects()
    }

    public func taskExists(id: Int) -> Bool {
        return self.store.containsObject(withId: id)
    }

    public func deleteTask(id: Int) throws {
        try self.store.remove(withId: id)
    }
}
