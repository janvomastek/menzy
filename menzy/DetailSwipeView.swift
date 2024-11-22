import SwiftUI

struct DetailSwipeView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme // Access the current color scheme
    
    let items: [ListItem]
    @State private var selectedIndex: Int = 0
    
    // Custom initializer
    init(items: [ListItem]) {
        self.items = items
        UIPageControl.appearance().currentPageIndicatorTintColor = .blue
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.5)
    }

    var body: some View {
        VStack {
            // Back navigation
            Spacer()
                .navigationBarBackButtonHidden(true)
                .toolbar(content: {
                    ToolbarItem (placement: .navigationBarLeading)  {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(.blue)
                            Text("Settings")
                                .foregroundColor(.blue)
                        })
                    }
                })
            
            ZStack {
                // TabView for item details
                TabView(selection: $selectedIndex) {
                    ForEach(items.indices, id: \.self) { index in
                        if !items[index].isHidden {
                            VStack {
                                Text("Item Detail")
                                    .font(.title)
                                    .padding(.bottom, 8)
                                
                                Text(items[index].title)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(UIColor.systemBackground))
                            .tag(index) // Tag for TabView item selection
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))

                // Arrow buttons overlay at the bottom
                VStack {
                    Spacer()
                    HStack {
                        // Left arrow button
                        Button(action: {
                            if selectedIndex > 0 {
                                selectedIndex -= 1
                            }
                        }) {
                            Image(systemName: "arrow.left.circle.fill")
                                .font(.title)
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()

                        // Right arrow button
                        Button(action: {
                            if selectedIndex < items.count - 1 && !items[selectedIndex+1].isHidden {
                                selectedIndex += 1
                            }
                        }) {
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.title)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 10) // Adjust bottom padding to position the arrows properly
                }
            }
        }
        .navigationTitle("Swipe Through Items")
       
    }
    

}

#Preview {
    DetailSwipeView( items: [
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
    ])
}
