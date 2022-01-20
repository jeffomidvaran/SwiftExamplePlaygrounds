import UIKit

/*
    Notifications and observers
        an observer waits then runs code when it recieves a notification with post
        one to many (one notification many observers)
*/

class MyClass {
    let notificationName1 = Notification.Name(rawValue: "key1")
    let notificationName2 = Notification.Name(rawValue: "key2")
    init(){
        self.createObservers()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(funcOne(notification:)), name: notificationName1, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(funcTwo(notification:)), name: notificationName2, object: nil)
    }
    @objc func funcOne(notification: NSNotification) {
        print("notification one")
    }

    @objc func funcTwo(notification: NSNotification) {
        print("notification two")
    }
    
    
    func callNotificationOne(){
        NotificationCenter.default.post(name: notificationName1, object: nil)
    }
    
    func callNotificationTwo(){
        NotificationCenter.default.post(name: notificationName2, object: nil)
    }
}

var notificationTest = MyClass()
notificationTest.callNotificationOne()
notificationTest.callNotificationTwo()

