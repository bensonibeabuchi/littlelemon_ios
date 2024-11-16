import SwiftUI

struct Header: View {
    @AppStorage(isLoggedIn) private var isLoggedIn: Bool = false
    
    var body: some View {
        ZStack {
            HStack {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 40)
                    .accessibilityLabel("App Logo")
                
                Spacer()
                
                if isLoggedIn {
                    NavigationLink(destination: UserProfile()) {
                        Image("Profile")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 50)
                            .clipShape(Circle())
                            .accessibilityLabel("User Profile Picture")
                    }
                    .padding(.trailing)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 60)
        .background(Color.primaryColor1)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
            .previewLayout(.sizeThatFits)
    }
}
