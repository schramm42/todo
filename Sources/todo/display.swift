import Table
import ColorizeSwift
import Foundation

final class Display {
    public static func printTask(task: Task) throws {

        let id: String = "\(task.id)"
        let name: String = "\(task.name)"
        var dateCreated: String = Display.formatDate(date: task.dateCreate)
        var dateModified: String = Display.formatDate(date: task.dateModified)
        var description: String = ""
        let status: String = "\(task.status)"

        if (task.description != nil) {
            description = task.description!
        }

        if (description.count > 30) {
            description = description.prefix(30) + " ..."
        }

        let data = [
            ["ID", id],
            ["Name", name],
            ["Description", description],
            ["CreatedAt", dateCreated],
            ["ModifiedAt", dateModified],
            ["Status", status],
        ]

        let table = try Table(data: data).table()

        print(table)
    }

    public static func printTaskList(tasks: [Task]) throws {
        var data = [
            ["ID", "Name", "Status", "CreateAt"]
        ]

        for task in tasks {
            data.append([String(task.id), task.name, task.status.rawValue, Display.formatDate(date: task.dateCreate)])
        }

        let table = try Table(data: data).table()

        print(table)
    }

    public static func formatDate(date: Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        if (date == nil) {
            return ""
        }

        return formatter.string(from: date!)
    }
}
