import Foundation

struct MenuItem: Codable, Identifiable {
    var id: UUID = UUID()
    let title: String
    let descriptionDish: String
    let price: String
    let image: String
    let category: Category
    
    enum CodingKeys: String, CodingKey {
        case title
        case descriptionDish = "description"
        case price
        case image
        case category
    }
    
    enum Category: String, Codable {
        case appetizer
        case mainCourse = "main_course"
        case dessert
        case drinks
        case other
    }
    
    var formattedPrice: String {
        if let priceValue = Double(price) {
            return String(format: "$%.2f", priceValue)
        }
        return "$\(price)"
    }
}
