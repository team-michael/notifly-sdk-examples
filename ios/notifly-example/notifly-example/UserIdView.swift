import notifly_sdk
import SwiftUI

struct UserIDView: View {
    @State private var userid: String = ""
    @State private var showAlert = false
    @State private var currentUserID = UserDefaults.standard.string(forKey: "currentTestAppUserID")

    var body: some View {
        VStack(spacing: 30) {
            Text("Current User ID: " + (currentUserID ?? ""))
                .padding()
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            TextField("userid", text: $userid)
                .padding()
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            Button(action: {
                // 첫 번째 버튼 액션
                if !userid.isEmpty {
                    Notifly.setUserId(userId: userid)
                    currentUserID = userid
                    UserDefaults.standard.set(userid, forKey: "currentTestAppUserID")

                } else {
                    showAlert = true
                }

            }) {
                Text("set_user_id")
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Button(action: {
                // 두 번째 버튼 액션
                Notifly.setUserId(userId: nil)

            }) {
                Text("remove_user_id")
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding()
        .background(Color.gray.opacity(0.1))
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Alert"), message: Text("UserID is empty"), dismissButton: .default(Text("OK")))
        }
    }
}
