import SwiftUI
import CoreData

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var startersIsEnabled = true
    @State private var mainsIsEnabled = true
    @State private var dessertsIsEnabled = true
    @State private var drinksIsEnabled = true
    
    @State private var searchText = ""
    
    @State private var loaded = false
    
    @State private var isKeyboardVisible = false
    
    init() {
        // Move the UITextField appearance customization to onAppear
    }
    
    var body: some View {
        NavigationStack {  // Updated to NavigationStack
            VStack {
                VStack {
                    if !isKeyboardVisible {
                        withAnimation {
                            Hero()
                                .frame(maxHeight: 180)
                        }
                    }
                    TextField("Search menu", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                .background(Color.primaryColor1)
                
                Text("ORDER FOR DELIVERY!")
                    .font(.sectionTitle())
                    .foregroundColor(.highlightColor2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        Toggle("Starters", isOn: $startersIsEnabled)
                        Toggle("Mains", isOn: $mainsIsEnabled)
                        Toggle("Desserts", isOn: $dessertsIsEnabled)
                        Toggle("Drinks", isOn: $drinksIsEnabled)
                    }
                    .toggleStyle(MyToggleStyle())
                    .padding(.horizontal)
                }
                
                FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                    List(dishes) { dish in
                        NavigationLink(destination: DetailItem(dish: dish)) {
                            FoodItem(dish: dish)
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
        .onAppear {
            if !loaded {
                MenuList.getMenuData(viewContext: viewContext)
                loaded = true
            }
            UITextField.appearance().clearButtonMode = .whileEditing  // Apply appearance here
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
            withAnimation {
                self.isKeyboardVisible = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
            withAnimation {
                self.isKeyboardVisible = false
            }
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                  ascending: true,
                                  selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSCompoundPredicate {
        // Simplifying the logic for applying category filters
        var predicates: [NSPredicate] = []
        
        // Search Predicate
        let searchPredicate = searchText.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        predicates.append(searchPredicate)
        
        // Category Filters
        if startersIsEnabled {
            predicates.append(NSPredicate(format: "category == %@", "starters"))
        }
        if mainsIsEnabled {
            predicates.append(NSPredicate(format: "category == %@", "mains"))
        }
        if dessertsIsEnabled {
            predicates.append(NSPredicate(format: "category == %@", "desserts"))
        }
        if drinksIsEnabled {
            predicates.append(NSPredicate(format: "category == %@", "drinks"))
        }
        
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
