import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let notificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        requestAutorization()
        notificationCenter.delegate = self
        return true
    }
    
    // обнуление количества не прочитанных сообщений
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    // запрос у пользователей подтверждения на отправку уведомлений
    func requestAutorization() {
        notificationCenter.requestAuthorization(options: [.alert,.sound,.badge]) { (granted,
                                                                                    error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    // метод для отслеживания настроек
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
        }
    }
    
    // метод отвечает за расписание уведомлений
    func scheduleNotification(notificationType: String) {
        
        let content = UNMutableNotificationContent()
        let userAction = "User Action"
        
        content.title = notificationType
        content.body = "This is example how to create" + notificationType
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userAction
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let identifiere = "Local Notification"
        let request = UNNotificationRequest(identifier: identifiere,
                                            content: content,
                                            trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        // создание действий пользователей в уведомлении (можно отображать до 4 действий)
        let snoozeAction = UNNotificationAction(identifier: "Snooze",
                                                title: "Snooze",
                                                options: [])
        
        let deleteAction = UNNotificationAction(identifier: "Delete",
                                                title: "Delete",
                                                options: [.destructive])
        
        let category = UNNotificationCategory(identifier: userAction,
                                              actions: [snoozeAction, deleteAction],
                                              intentIdentifiers: [],
                                              options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
}
// получать уведомления,когда приложение находится в переднем плане
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            
            completionHandler([.alert, .sound])
        }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
            
            if response.notification.request.identifier == "Local Notification" {
                print("Handling notification with the Local Notification Identifire")
            }
            
            switch response.actionIdentifier {
                case UNNotificationDismissActionIdentifier:
                    print("Dismiss Action")
                case UNNotificationDefaultActionIdentifier:
                    print("Default")
                case "Snooze":
                    scheduleNotification(notificationType: "Reminder")
                case "Delete":
                    print("Delete")
                default:
                    print("Unknown action")
            }
            completionHandler()
        }
}



