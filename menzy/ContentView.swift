import SwiftUI

struct ListItem: Identifiable {
    let id = UUID()
    let title: String
    var isHidden: Bool
}

struct ContentView: View {
    @State private var items: [ListItem] = [
        ListItem(title: "Item 1", isHidden: false),
        ListItem(title: "Item 2", isHidden: false),
        ListItem(title: "Item 3", isHidden: false),
        ListItem(title: "Item 4", isHidden: false),
        ListItem(title: "Item 5", isHidden: false),
        ListItem(title: "Item 6", isHidden: false),
        ListItem(title: "Item 7", isHidden: false),
        ListItem(title: "Item 8", isHidden: false),
        ListItem(title: "Item 9", isHidden: false),
        ListItem(title: "Item 10", isHidden: false),
        ListItem(title: "Item 11", isHidden: false),
        ListItem(title: "Item 12", isHidden: false)
    ]
    
    @Environment(\.editMode) private var editMode
    @State private var editModeState: EditMode = .active
    @State private var isShowingDetailPage = false

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // App Header
                appHeader()
                
                // Login Button
                Button(action: {
                    login()
                }) {
                    Text("Login")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                
                // List Title
                Text("List sortation")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .bottom)
                
                // Reorderable List with items filtered by `isHidden`
                List {
                    ForEach(Array(items.enumerated()), id: \.1.id) { index, item in
                        HStack {
                            Text(item.title)
                                .foregroundColor(item.isHidden ? .gray : .primary)
                            
                            Spacer()
                            
                            Button(action: {
                                toggleVisibility(of: index)
                            }) {
                                Image(systemName: item.isHidden ? "eye.slash" : "eye")
                                    .foregroundColor(item.isHidden ? .gray : .blue)
                            }
                        }
                        .padding()
                        .background(item.isHidden ? Color.gray.opacity(0.2) : Color.clear)
                        .cornerRadius(8)
                    }
                    .onMove(perform: move)
                }
                
                Spacer() // Pushes the "Save" button to the bottom
                
                // Save Button
                NavigationLink(destination: DetailSwipeView(items: items)) {
                    Text("Save")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .padding(.bottom) // Adds padding at the bottom for safe area
            }
            .navigationTitle("Řazení menz")
            .navigationBarHidden(true) // Hides default navigation bar
            .environment(\.editMode, $editModeState)
        }
    }
    
    private func appHeader() -> some View {
        HStack {
            Rectangle()
                .fill(Color.yellow)
                .frame(width: 20, height: 20)
                .cornerRadius(4)
            
            Text("Menzy CTU")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
            
            Spacer() // Pushes content to the left
        }
        .padding()
        .background(Color(UIColor.systemBackground)) // Matches app background
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2) // Adds subtle shadow
    }
    
    private func login() {
        // Perform login action here
        print("Login button tapped!")
    }
    
    private func toggleVisibility(of index: Int) {
        items[index].isHidden.toggle()
        items.sort { !$0.isHidden && $1.isHidden }
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        var reorderedItems = items
        reorderedItems.move(fromOffsets: source, toOffset: destination)
        items = reorderedItems
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
