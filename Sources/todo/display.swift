import ColorizeSwift
import Foundation
import SwiftyTextTable
import Table

final class Display {
    public static func printTask2(task: Task) throws {

        let id: String = "\(task.id)"
        let name: String = "\(task.name)"
        let dateCreated: String = Display.formatDate(date: task.dateCreate, full: true)
        let dateModified: String = Display.formatDate(date: task.dateModified, full: true)
        let description: String = Display.formatDescription(description: task.description)
        let status: String = "\(task.status)"

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

    public static func printTask(task: Task) {
        let colKey = TextTableColumn(header: "Property".bold())
        let colVal = TextTableColumn(header: "Value".bold())

        var table = TextTable(columns: [colKey, colVal])

        let id: String = String(task.id).green()
        let name: String = task.name.green()
        let status: String = task.status.rawValue.green()
        let description: String = Display.formatDescription(description: task.description).green()
        let createAt: String = Display.formatDate(date: task.dateCreate).green()
        let modifiedAt: String = Display.formatDate(date: task.dateModified).green()

        table.addRow(values: ["ID".yellow().bold(), id])
        table.addRow(values: ["Name".yellow().bold(), name])
        table.addRow(values: ["Status".yellow().bold(), status])
        table.addRow(values: ["Description".yellow().bold(), description])
        table.addRow(values: ["CreateAt".yellow().bold(), createAt])
        table.addRow(values: ["ModifiedAt".yellow().bold(), modifiedAt])

        let tableString = table.render()
        print(tableString)
    }

    public static func printTaskList2(tasks: [Task]) throws {
        var data = [
            ["ID", "Name", "Status", "CreateAt", "ModifiedAt"]
        ]

        for task in tasks {
            data.append([
                String(task.id),
                task.name.strikethrough(),
                task.status.rawValue,
                Display.formatDate(date: task.dateCreate),
                Display.formatDate(date: task.dateModified),
            ])
        }

        let table = try Table(data: data).table()

        print(table)
    }

    public static func printTaskList(tasks: [Task]) throws {
        let colId = TextTableColumn(header: "ID".bold())
        let colName = TextTableColumn(header: "Name".bold())
        let colStatus = TextTableColumn(header: "Status".bold())
        let colCreateAt = TextTableColumn(header: "CreateAt".bold())
        let colModifiedAt = TextTableColumn(header: "ModifiedAt".bold())

        var table = TextTable(columns: [colId, colName, colStatus, colCreateAt, colModifiedAt])

        for task in tasks {
            table.addRow(values: Display.formatListTableRow(task: task))
        }

        let tableString = table.render()
        print(tableString)
    }

    public static func formatListTableRow(task: Task) -> [any CustomStringConvertible] {
        var id: String = String(task.id)
        var name: String = task.name
        var status: String = task.status.rawValue
        var createAt: String = Display.formatDate(date: task.dateCreate)
        var modifiedAt: String = Display.formatDate(date: task.dateModified)

        if task.status == .done {
            id = id.strikethrough().green()
            name = name.strikethrough().green()
            status = status.strikethrough().green()
            createAt = createAt.strikethrough().green()
            modifiedAt = modifiedAt.strikethrough().green()
        }

        if task.status == .todo {
            id = id.red()
            name = name.red()
            status = status.red()
            createAt = createAt.red()
            modifiedAt = modifiedAt.red()
        }

        if task.status == .inprogress {
            id = id.yellow()
            name = name.yellow()
            status = status.yellow()
            createAt = createAt.yellow()
            modifiedAt = modifiedAt.yellow()
        }

        return [
            id,
            name,
            status,
            createAt,
            modifiedAt,
        ]
    }

    public static func formatDate(date: Date?, full: Bool = false) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = full ? "dd.MM.yyyy HH:mm:ss" : "dd.MM.yyyy"

        if date == nil {
            return ""
        }

        return formatter.string(from: date!)
    }

    public static func formatDescription(description: String?) -> String {
        if description == nil {
            return ""
        }

        if description!.count > 30 {
            return description!.prefix(30) + "..."
        }

        return description!
    }
}
