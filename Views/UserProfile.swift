import SwiftUI

struct UserProfile: View {
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @State private var isLoggedOut = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            NavigationLink(destination: Onboarding(), isActive: $isLoggedOut) { EmptyView() }
            
            VStack(spacing: 0) {
                HeaderView()
                
                PersonalInfoView()
                
                NotificationSettingsView(
                    orderStatuses: $viewModel.orderStatuses,
                    passwordChanges: $viewModel.passwordChanges,
                    specialOffers: $viewModel.specialOffers,
                    newsletter: $viewModel.newsletter
                )
                
                LogoutButton()
                
                ActionButtons()
                
                if $viewModel.errorMessageShow {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
            }
        }
        .onAppear {
            $viewModel.loadData
        }
    }
    
    private func HeaderView() -> some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "arrow.left")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(16)
                    .background(Color.green)
                    .clipShape(Circle())
            }
            Spacer()
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 180, maxHeight: 180)
                .padding(.bottom)
            Spacer()
            Image("Profile")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 60, maxHeight: 60)
                .padding(.leading)
        }
        .padding()
    }
    
    private func PersonalInfoView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Personal Information")
                .font(.title)
                .bold()
            
            Text("Avatar").onboardingTextStyle()
            HStack {
                Image("Profile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 75)
                    .clipShape(Circle())
                Button("Change") { /* Add functionality */ }
                    .buttonStyle(ButtonStylePrimaryColor1())
                Button("Remove") { /* Add functionality */ }
                    .buttonStyle(ButtonStylePrimaryColorReverse())
            }
            
            TextField("First Name", text: $viewModel.firstName)
                .textFieldStyle(.roundedBorder)
            TextField("Last Name", text: $viewModel.lastName)
                .textFieldStyle(.roundedBorder)
            TextField("E-mail", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
            TextField("Phone number", text: $viewModel.phoneNumber)
                .keyboardType(.phonePad)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
    }
    
    private func NotificationSettingsView(
        orderStatuses: Binding<Bool>,
        passwordChanges: Binding<Bool>,
        specialOffers: Binding<Bool>,
        newsletter: Binding<Bool>
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Email Notifications")
                .font(.regularText())
                .foregroundColor(.primaryColor1)
            
            Checkbox(title: "Order statuses", isChecked: orderStatuses)
            Checkbox(title: "Password changes", isChecked: passwordChanges)
            Checkbox(title: "Special offers", isChecked: specialOffers)
            Checkbox(title: "Newsletter", isChecked: newsletter)
        }
        .padding()
    }
    
    private func LogoutButton() -> some View {
        Button("Log Out") {
            viewModel.logout()
            isLoggedOut = true
        }
        .buttonStyle(ButtonStyleYellowColorWide())
    }
    
    private func ActionButtons() -> some View {
        HStack {
            Button("Discard Changes") {
                viewModel.loadData()
                dismiss()
            }
            .buttonStyle(ButtonStylePrimaryColorReverse())
            
            Button("Save Changes") {
                if viewModel.validateUserInput(
                    firstName: viewModel.firstName,
                    lastName: viewModel.lastName,
                    email: viewModel.email,
                    phoneNumber: viewModel.phoneNumber
                ) {
                    viewModel.saveData()
                    dismiss()
                }
            }
            .buttonStyle(ButtonStylePrimaryColor1())
        }
        .padding()
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
        Button(action: { isChecked.toggle() }) {
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

