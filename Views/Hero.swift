import SwiftUI

struct Hero: View {
    var body: some View {
        ZStack {
            Color.primaryColor1 // Background color
                .ignoresSafeArea()
            
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Little Lemon")
                        .foregroundColor(Color.primaryColor2)
                        .font(.displayFont())
                        .accessibilityLabel("Restaurant Name: Little Lemon")
                    
                    Text("Chicago")
                        .foregroundColor(.white)
                        .font(.subTitleFont())
                        .accessibilityLabel("Location: Chicago")
                    
                    Text("""
                    We are a family-owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.
                    """)
                    .foregroundColor(.white)
                    .font(.leadText())
                    .accessibilityLabel("Description of the restaurant.")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image("hero-image")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 120, maxHeight: 140)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .accessibilityLabel("Image of Mediterranean dishes")
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: 240)
    }
}

struct Hero_Previews: PreviewProvider {
    static var previews: some View {
        Hero()
            .previewLayout(.sizeThatFits)
    }
}
