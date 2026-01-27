import Foundation
import SwiftData

@Model
final class ToDoItem {
    // SwiftData 會自動將屬性映射到資料庫欄位
    var id: UUID
    var title: String
    var isCompleted: Bool
    var createdAt: Date // 建議加上時間，方便排序

    init(title: String, isCompleted: Bool = false) {
        self.id = UUID()
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = Date()
    }
}