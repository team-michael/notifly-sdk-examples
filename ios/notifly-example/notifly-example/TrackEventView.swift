import notifly_sdk
import SwiftUI

struct EventView: View {
    @State private var eventName: String = ""
    @State private var eventParams: [String: String] = [:]
    @State private var segmentationEventParamKey: String = ""

    @State private var showAlert = false
    @State private var showTrackEventAlert = false

    @State private var newKey: String = ""
    @State private var newValue: String = ""
    var body: some View {
        VStack(spacing: 10) {
            TextField("Event Name", text: $eventName)
                .padding(20)
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)

            HStack(spacing: 5) {
                TextField("key", text: $newKey)
                    .padding(10)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                TextField("value", text: $newValue)
                    .padding(10)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            TextField("SegmentationEventParamkey", text: $segmentationEventParamKey)
                .padding(10)
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)

            HStack(spacing: 5) {
                Button(action: {
                    showAlert = true
                }) {
                    Text("Add Event Params")
                        .padding(5)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Add Event Params"),
                        message: nil,
                        primaryButton: .default(Text("Add")) {
                            if !newKey.isEmpty, !newValue.isEmpty {
                                eventParams[newKey] = newValue
                            }
                        },
                        secondaryButton: .cancel(Text("Cancel"))
                    )
                }
                Button(action: {
                    eventParams = [:]
                }) {
                    Text("Reset Event Params")
                        .padding(5)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }

            List {
                Text("Event Params List")
                ForEach(Array(eventParams.keys.sorted()), id: \.self) { key in
                    VStack(alignment: .leading) {
                        Text("\(key): \(eventParams[key] ?? "")")
                    }
                }
            }

            Button(action: {
                if !eventName.isEmpty {
                    Notifly.trackEvent(eventName: eventName, eventParams: eventParams, segmentationEventParamKeys: [segmentationEventParamKey])
                } else {
                    showTrackEventAlert = true
                }

                print("Event Params successfully")

            }) {
                Text("Track Event")
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .alert(isPresented: $showTrackEventAlert) {
                Alert(
                    title: Text("Event Name Required")
                )
            }

            HStack(spacing: 5) {
                Button(action: {
                    // 첫 번째 버튼 액션
                    Notifly.trackEvent(eventName: "ios-event1")
                }) {
                    Text("ios-event1")
                        .padding(5)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    // 두 번째 버튼 액션
                    Notifly.trackEvent(eventName: "ios-event2")
                }) {
                    Text("ios-event2")
                        .padding(5)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    // 세 번째 버튼 액션
                    Notifly.trackEvent(eventName: "ios-event3")
                }) {
                    Text("ios-event3")
                        .padding(5)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            HStack(spacing: 5) {
                Button(action: {
                    // 첫 번째 버튼 액션
                    Notifly.trackEvent(eventName: "ios-event4")
                }) {
                    Text("ios-event4")
                        .padding(5)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    // 두 번째 버튼 액션
                    Notifly.trackEvent(eventName: "ios-event5")
                }) {
                    Text("ios-event5")
                        .padding(5)
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    // 세 번째 버튼 액션
                    Notifly.trackEvent(eventName: "ios-event6")
                }) {
                    Text("ios-event6")
                        .padding(5)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding()
        .background(Color.gray.opacity(0.2))
    }
}
