import UIKit
import UserNotifications
import Firebase

class Notifications: NSObject,UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    let messagingDelegate = Messaging.messaging()
    
    // запрос у пользователей подтверждения на отправку уведомлений
    func requestAutorization() {
        notificationCenter.requestAuthorization(options: [.alert,.sound,.badge,.providesAppNotificationSettings, .provisional]) { (granted,
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
            // регистрация нашего приложения для получения пуш уведомлений
            guard settings.authorizationStatus == .authorized else { return }
            
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    // метод отвечает за расписание уведомлений
    func scheduleNotification(notificationType: String) {
        
        let content = UNMutableNotificationContent()
        let userAction = "User Action"
        
        content.title = notificationType
        content.body = "Summer Time" + notificationType
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userAction
        
        content.threadIdentifier = notificationType
        
        content.summaryArgumentCount = 10
        content.summaryArgument = notificationType
        
        // добавляем картинку в наше уведомление
        guard let path = Bundle.main.path(forResource: "planet", ofType: "png") else { return }

        let url = URL(fileURLWithPath: path)

        do {
            let attachment = try UNNotificationAttachment(
                identifier: "planet",
                url: url,
                options: nil)

            content.attachments = [attachment]
        } catch {
            print("The attachment cold not be loaded")
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let identifiere = UUID().uuidString
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
    
    // получать уведомления,когда приложение находится в переднем плане
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
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.openSettings()
    }
}

extension Notifications: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("\nFirebase registration token: \(fcmToken)\n")
    }
}
