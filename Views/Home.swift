

import SwiftUI

struct Home: View {
    
    var body: some View {
        
        ZStack {
            MainScreen()
                .navigationBarBackButtonHidden()
            
            
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
