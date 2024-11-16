
import SwiftUI

struct UserProfile: View {
    @StateObject private var viewModel = ViewModel()
    @Environment(\.presentationMode) var presentation
    
    @State private var orderStatuses = true
    @State private var passwordChanges = true
    @State private var specialOffers = true
    @State private var newsletter = true
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    
    @State private var isLoggedOut = false
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            

            NavigationLink(destination: Onboarding(), isActive: $isLoggedOut) {
         
            }
            
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        
                        presentation.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(16)
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                    
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 180, maxHeight: 180)
                        .padding(.bottom)

                    Image("Profile")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 60, maxHeight: 60)
                        .padding(.leading)

                    
                }
                
                VStack {
                   Text("Personal information")
                        .font(.title)
                        .bold()
                        .padding(.leading, -88.0)
                    
                    Text("Avatar")
                    .onboardingTextStyle()
                    .padding(.horizontal)
                    HStack{
                        
                        Image("Profile")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 75)
                            .clipShape(Circle())
                            .padding(.trailing)
                        
                        Button("Change") { }
                            .buttonStyle(ButtonStylePrimaryColor1())
                        
                        Button("Remove") { }
                            .buttonStyle(ButtonStylePrimaryColorReverse())
                            
                        
                    }.padding(.horizontal)
                    
                    
                }
                
                VStack(alignment: .leading) {
                    Text("First name")
                        .onboardingTextStyle()
                    TextField("First Name", text: $firstName)
                        .textFieldStyle(.roundedBorder)
                    Text("Last name")
                        .onboardingTextStyle()
                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(.roundedBorder)
                    Text("E-mail")
                        .onboardingTextStyle()
                    TextField("E-mail", text: $email)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(.roundedBorder)
                    Text("Phone number")
                        .onboardingTextStyle()
                    TextField("Phone number", text: $phoneNumber)
                        .keyboardType(.default)
                    
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
                        
                    
                    VStack(alignment: .leading) {
                        
                        Text("Email notifications")
                            .font(.regularText())
                            .foregroundColor(.primaryColor1)
                            .padding()
                        
                        Checkbox(title: "Order statuses", isChecked: $orderStatuses)
                        Checkbox(title: "Password changes", isChecked: $passwordChanges)
                        Checkbox(title: "Special offers", isChecked: $specialOffers)
                        Checkbox(title: "Newsletter", isChecked: $newsletter)
                    }
                }
                
                .padding()
                .font(Font.leadText())
                .foregroundColor(.primaryColor1)
                
                Button("Log out") {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    UserDefaults.standard.set("", forKey: kFirstName)
                    UserDefaults.standard.set("", forKey: kLastName)
                    UserDefaults.standard.set("", forKey: kEmail)
                    UserDefaults.standard.set("", forKey: kPhoneNumber)
                    UserDefaults.standard.set(false, forKey: kOrderStatuses)
                    UserDefaults.standard.set(false, forKey: kPasswordChanges)
                    UserDefaults.standard.set(false, forKey: kSpecialOffers)
                    UserDefaults.standard.set(false, forKey: kNewsletter)
                    isLoggedOut = true
                }
                .buttonStyle(ButtonStyleYellowColorWide())
                
                Spacer(minLength: 20)
                
                HStack {
                    Button("Discard Changes") {
                        firstName = viewModel.firstName
                        lastName = viewModel.lastName
                        email = viewModel.email
                        phoneNumber = viewModel.phoneNumber
                        
                        orderStatuses = viewModel.orderStatuses
                        passwordChanges = viewModel.passwordChanges
                        specialOffers = viewModel.specialOffers
                        newsletter = viewModel.newsletter
                        self.presentation.wrappedValue.dismiss()
                    }
                    .buttonStyle(ButtonStylePrimaryColorReverse())
                    
                    Button("Save changes") {
                        if viewModel.validateUserInput(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber) {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
                            UserDefaults.standard.set(orderStatuses, forKey: kOrderStatuses)
                            UserDefaults.standard.set(passwordChanges, forKey: kPasswordChanges)
                            UserDefaults.standard.set(specialOffers, forKey: kSpecialOffers)
                            UserDefaults.standard.set(newsletter, forKey: kNewsletter)
                            self.presentation.wrappedValue.dismiss()
                        }
                           
                    }
                    .buttonStyle(ButtonStylePrimaryColor1())
                }
                
                if viewModel.errorMessageShow {
                    withAnimation() {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                    }
                     
                }
                   
            }
            
            
        }
        .onAppear {
            firstName = viewModel.firstName
            lastName = viewModel.lastName
            email = viewModel.email
            phoneNumber = viewModel.phoneNumber
            
            orderStatuses = viewModel.orderStatuses
            passwordChanges = viewModel.passwordChanges
            specialOffers = viewModel.specialOffers
            newsletter = viewModel.newsletter
            
        }
        
}
    }
    


struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}

struct Checkbox: View {
    let title: String
    @Binding var isChecked: Bool

    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square" : "square")
                    .foregroundColor(isChecked ? .primaryColor1 : .gray)
                Text(title)
            }
            .padding(.leading)
            
        }
        .buttonStyle(PlainButtonStyle())
        
    }
}
