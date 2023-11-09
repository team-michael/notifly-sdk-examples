import notifly_sdk
import SwiftUI

struct UserPropertiesView: View {
    @State private var userProperties: [String: String] = [:]
    @State private var showAlert = false
    @State private var newKey: String = ""
    @State private var newValue: String = ""
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                TextField("key", text: $newKey)
                    .padding()
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                TextField("value", text: $newValue)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            Button(action: {
                showAlert = true
            }) {
                Text("Add User Property")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Add User Property"),
                    message: nil,
                    primaryButton: .default(Text("Add")) {
                        if !newKey.isEmpty, !newValue.isEmpty {
                            userProperties[newKey] = newValue
                        }
                    },
                    secondaryButton: .cancel(Text("Cancel"))
                )
            }

            List {
                Text("Key: Value")
                ForEach(Array(userProperties.keys.sorted()), id: \.self) { key in
                    VStack(alignment: .leading) {
                        Text("\(key): \(userProperties[key] ?? "")")
                    }
                }
            }

            Button(action: {
                Notifly.setUserProperties(userProperties: userProperties)
                print("User properties set successfully")

            }) {
                Text("Update User Properties")
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding()
        .background(Color.gray.opacity(0.2))
    }
}
