import Foundation
import Combine

enum UserDefaultsKey: String {
    case firstName = "first name key"
    case lastName = "last name key"
    case email = "e-mail key"
    case isLoggedIn = "kIsLoggedIn"
    case phoneNumber = "phone number key"
    case orderStatuses = "order statuses key"
    case passwordChanges = "password changes key"
    case specialOffers = "special offers key"
    case newsletter = "news letter key"
}

class ViewModel: ObservableObject {
    
    @Published var firstName = UserDefaults.standard.string(forKey: UserDefaultsKey.firstName.rawValue) ?? ""
    @Published var lastName = UserDefaults.standard.string(forKey: UserDefaultsKey.lastName.rawValue) ?? ""
    @Published var email = UserDefaults.standard.string(forKey: UserDefaultsKey.email.rawValue) ?? ""
    @Published var phoneNumber = UserDefaults.standard.string(forKey: UserDefaultsKey.phoneNumber.rawValue) ?? ""
    
    @Published var orderStatuses = UserDefaults.standard.bool(forKey: UserDefaultsKey.orderStatuses.rawValue)
    @Published var passwordChanges = UserDefaults.standard.bool(forKey: UserDefaultsKey.passwordChanges.rawValue)
    @Published var specialOffers = UserDefaults.standard.bool(forKey: UserDefaultsKey.specialOffers.rawValue)
    @Published var newsletter = UserDefaults.standard.bool(forKey: UserDefaultsKey.newsletter.rawValue)
    
    @Published var errorMessage: String? = nil
    @Published var searchText = ""
    
    func validateUserInput(firstName: String, lastName: String, email: String, phoneNumber: String) -> Bool {
        guard !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty else {
            errorMessage = "All fields are required"
            return false
        }
        

        let emailPattern = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        guard emailPredicate.evaluate(with: email) else {
            errorMessage = "Invalid email address"
            return false
        }
        

        guard phoneNumber.isEmpty || (phoneNumber.first == "+" && phoneNumber.dropFirst().allSatisfy({ $0.isNumber })) else {
            errorMessage = "Invalid phone number format."
            return false
        }
        
        errorMessage = nil
        return true
    }
}
