import SwiftUI

struct Home: View {
    var body: some View {
        MainScreen()
            .navigationBarBackButtonHidden(true) // Retain only if back button hiding is intentional
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

