import Foundation
import SwiftCLI

enum TaskStatus: String, Codable, ConvertibleFromString, CaseIterable {
    case todo
    case inprogress
    case done
}

struct Task: Codable {
    let id: Int
    var name: String
    var description: String?
    let dateCreate: Date?
    var dateModified: Date?
    var status: TaskStatus

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
    private var tasks = [Int: Task]()
    private let encoder: JSONEncoder = JSONEncoder()
    private let decoder: JSONDecoder = JSONDecoder()

    public static let shared: TaskStore = TaskStore()

    private let savePath: String = FileManager.default.currentDirectoryPath.appending("/data.json")

    init() {
        self.encoder.outputFormatting = .prettyPrinted
        self.encoder.dateEncodingStrategy = .iso8601
        self.decoder.dateDecodingStrategy = .iso8601
    }

    public func addTask(name: String, description: String? = nil) throws -> Task {
        let keys = Array(self.tasks.keys)
        let maxId = keys.max() ?? 0

        let now = Date()
        let id = maxId + 1
        let task = Task(
            id: id,
            name: name,
            description: "",
            dateCreate: now,
            dateModified: now,
            status: TaskStatus.todo
        )
        self.tasks[id] = task

        //try self.save()

        return task
    }

    public func load() throws -> TaskStore {
        let fileData = FileManager.default.contents(atPath: self.savePath)
        self.tasks = try self.decoder.decode([Int: Task].self, from: fileData!)

        return self
    }

    public func save() throws -> TaskStore {
        let data = try self.encoder.encode(self.tasks)
        FileManager.default.createFile(atPath: self.savePath, contents: data)

        return self
    }

    public func getTasks() -> [Task] {
        return Array(self.tasks.values)
    }

    public func getTask(id: Int) throws -> Task {
        if (!self.taskExists(id: id)) {
            throw TaskError.notExists
        }

        return self.tasks[id]!
    }

    public func setTask(_ id: Int, _ task: inout Task) throws -> TaskStore {
        if (!self.taskExists(id: id)) {
            throw TaskError.notExists
        }

        task.dateModified = Date()

        self.tasks[id] = task

        return self
    }

    public func taskExists(id: Int) -> Bool {
        let keys = Array(self.tasks.keys)
        return keys.contains(id)
    }

    public func deleteTask(id: Int) throws {
        self.tasks.removeValue(forKey: id)
    }
}
