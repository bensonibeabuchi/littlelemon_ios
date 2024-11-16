import SwiftUI

struct Onboarding: View {
    @StateObject private var viewModel = ViewModel()
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var phoneNumber = ""
    
    @State var isKeyboardVisible = false
    @State var contentOffset: CGSize = .zero
    
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Header()
                    Hero()
                        .padding()
                        .background(Color.primaryColor1)
                        .frame(maxWidth: .infinity, maxHeight: 240)
                    VStack {
        
                        NavigationLink(value: isLoggedIn) {
                            EmptyView()
                        }
                        
                        Text("First name *")
                            .onboardingTextStyle()
                        TextField("First Name", text: $firstName)
                        
                        Text("Last name *")
                            .onboardingTextStyle()
                        TextField("Last Name", text: $lastName)
                        
                        Text("E-mail *")
                            .onboardingTextStyle()
                        TextField("E-mail", text: $email)
                            .keyboardType(.emailAddress)
                        
                        Text("Phone Number (optional)")
                            .onboardingTextStyle()
                        TextField("Phone Number", text: $phoneNumber)
                            .keyboardType(.phonePad)
                    }
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .padding()
                    
                    if let errorMessage = viewModel.errorMessage {
                        withAnimation {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                        }
                    }
                    
                    Button("Register") {
                        if viewModel.validateUserInput(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber) {
                            UserDefaults.standard.set(firstName, forKey: UserDefaultsKey.firstName.rawValue)
                            UserDefaults.standard.set(lastName, forKey: UserDefaultsKey.lastName.rawValue)
                            UserDefaults.standard.set(email, forKey: UserDefaultsKey.email.rawValue)
                            UserDefaults.standard.set(true, forKey: UserDefaultsKey.isLoggedIn.rawValue)
                            UserDefaults.standard.set(true, forKey: UserDefaultsKey.orderStatuses.rawValue)
                            UserDefaults.standard.set(true, forKey: UserDefaultsKey.passwordChanges.rawValue)
                            UserDefaults.standard.set(true, forKey: UserDefaultsKey.specialOffers.rawValue)
                            UserDefaults.standard.set(true, forKey: UserDefaultsKey.newsletter.rawValue)
                            
                     
                            firstName = ""
                            lastName = ""
                            email = ""
                            phoneNumber = ""
                            isLoggedIn = true
                        }
                    }
                    .buttonStyle(ButtonStyleYellowColorWide())
                    
                    Spacer()
                }
                .offset(y: contentOffset.height)
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                    withAnimation {
                        let keyboardRect = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                        let keyboardHeight = keyboardRect.height
                        self.isKeyboardVisible = true
                        self.contentOffset = CGSize(width: 0, height: -keyboardHeight / 2 + 50)
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
                    withAnimation {
                        self.isKeyboardVisible = false
                        self.contentOffset = .zero
                    }
                }
            }
            .navigationDestination(for: Bool.self) { value in
                if value {
                    Home()  // Navigate to Home if isLoggedIn is true
                }
            }
            .onAppear() {
                if UserDefaults.standard.bool(forKey: UserDefaultsKey.isLoggedIn.rawValue) {
                    isLoggedIn = true
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
