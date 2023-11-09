import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NavigationView {
                List {
                    Section(header: Text("Notifly Test APP")) {
                        NavigationLink(destination: UserIDView()) {
                            Text("Go to User ID Setting Page")
                        }
                        NavigationLink(destination: UserPropertiesView()) {
                            Text("Go to User Properties Setting Page")
                        }

                        NavigationLink(destination: EventView()) {
                            Text("Go to Event Tracking Page")
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 20))
                    .padding(.vertical, 20) // 섹션 간격 조정
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
