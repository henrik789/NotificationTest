
import UIKit
import UserNotifications

class Notification {
    
    func executeNotification(message: String) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            
        }
        let content = UNMutableNotificationContent()
        content.title = "Hello!!"
        content.body = message
        
        let date = Date().addingTimeInterval(6)
        let dateComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            print(message)
        }
    }
    
    
}
