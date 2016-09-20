//
//  NotificationFactory.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 19/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import UIKit

class NotificationFactory {
    static func makeNotification(for pokemon: String) -> UILocalNotification {
        let notification = UILocalNotification()
        notification.alertBody = "A wild \(pokemon) has spawned!"
        notification.alertAction = "Catch it!"
        notification.fireDate = Date()
        notification.soundName = UILocalNotificationDefaultSoundName
        return notification
    }
    
    static func sendNotification(for pokemon: String) {
        let notification = makeNotification(for: pokemon)
        send(notification: notification)
    }
    
    static func send(notification: UILocalNotification) {
        UIApplication.shared.scheduleLocalNotification(notification)
    }
}
