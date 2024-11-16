import SwiftUI

struct MainScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Header()
                Divider()
                Menu()
            }
            .navigationBarHidden(true)
            .background(Color(.systemGroupedBackground))
            .edgesIgnoringSafeArea(.top)
        }
        .accessibilityLabel("Main Screen with Header and Menu")
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
