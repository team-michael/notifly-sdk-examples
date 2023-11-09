import FirebaseCore
import notifly_sdk
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
    {
        FirebaseApp.configure()

        Notifly.initialize(projectId: NotiflyConfig.projectId, username: NotiflyConfig.username, password: NotiflyConfig.password)

        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Failed to request authorization: \(error)")
                return
            } else {
                guard granted else {
                    print("Notification permission denied")
                    return
                }
            }
        }
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
        return true
    }

    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        /* ...YOUR CODE */
        Notifly.application(application,
                            didFailToRegisterForRemoteNotificationsWithError: error)
    }

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        /* ...YOUR CODE */
        Notifly.application(application,
                            didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ notificationCenter: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler _: () -> Void)
    {
        /* ...YOUR CODE */
        Notifly.userNotificationCenter(notificationCenter,
                                       didReceive: response)
    }

    func userNotificationCenter(_ notificationCenter: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completion: (UNNotificationPresentationOptions) -> Void)
    {
        /* ...YOUR CODE */
        Notifly.userNotificationCenter(notificationCenter,
                                       willPresent: notification,
                                       withCompletionHandler: completion)
    }
}

@main
struct notifly_exampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var deeplinkPage = DeeplinkPage()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                if !deeplinkPage.isActive {
                    ContentView()
                } else {
                    NavigationLink(destination: deeplinkPage.view, isActive: $deeplinkPage.isActive) {
                        EmptyView()
                    }
                }
            }
            .onOpenURL { url in
                guard let url = URL(string: url.absoluteString) else { return }
                guard url.scheme == "pushnotiflyswiftui", url.host == "navigation" else { return }
                let urlString = url.absoluteString
                guard urlString.contains("name") else { return }
                guard let components = URLComponents(string: url.absoluteString),
                      let name = components.queryItems?.first(where: { $0.name == "name" })?.value
                else {
                    return
                }

                switch name {
                case "event":
                    deeplinkPage.view = AnyView(EventView())
                    deeplinkPage.isActive = true
                case "userid":
                    deeplinkPage.view = AnyView(UserIDView())
                    deeplinkPage.isActive = true
                case "userproperties":
                    deeplinkPage.view = AnyView(UserPropertiesView())
                    deeplinkPage.isActive = true
                case "home":
                    deeplinkPage.view = AnyView(ContentView())
                    deeplinkPage.isActive = true
                default:
                    return
                }
            }
        }
    }
}

class DeeplinkPage: ObservableObject {
    @Published var view: AnyView? = nil
    @Published var isActive: Bool = false
}
