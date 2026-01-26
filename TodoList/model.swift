import Foundation

// ToDo 核心模型：带UUID、DoIt标识、待办内容
struct ToDoItem: Identifiable, Codable {
    // 唯一标识：UUID，遵循Identifiable后可直接用id，无需额外处理
    let id: UUID()
    // 待办内容（可根据需求加其他字段：标题、时间、备注等）
    let title: String
    // 可选：待办完成状态（和doIt配合，区分「要做但未做」/「要做且已做」）
    var isCompleted: Bool = false
}