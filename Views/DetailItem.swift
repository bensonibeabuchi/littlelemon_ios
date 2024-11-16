import SwiftUI

struct DetailItem: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    let dish: Dish
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) { // Adds consistent spacing between elements
                AsyncImage(url: URL(string: dish.image ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Image("placeholder") // Fallback image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 200) // Optional size adjustment
                        .padding()
                }
                .clipShape(Rectangle())
                .cornerRadius(12)
                .shadow(radius: 5)
                
                Text(dish.title ?? "Unknown Dish")
                    .font(.subTitleFont())
                    .foregroundColor(.primaryColor1)
                    .multilineTextAlignment(.center)
                
                Text(dish.descriptionDish ?? "No description available.")
                    .font(.regularText())
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                Text("$\(dish.price ?? "0.00")")
                    .font(.highlightText())
                    .foregroundColor(.primaryColor1)
                    .monospaced()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline) // Inline navigation bar title
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground)) // Background color for better contrast
    }
}

struct DetailItem_Previews: PreviewProvider {
    static var previews: some View {
        DetailItem(dish: PersistenceController.oneDish())
    }
}
