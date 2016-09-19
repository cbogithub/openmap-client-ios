//
//  MakeNotification.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 19/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import UIKit

class MakeNotification {
    func MakeNotif(pokemon: String) {
        let notification = UILocalNotification()
        notification.alertBody = "A wild \(pokemon) spawned!"
        notification.alertAction = "Catch it!"
        notification.fireDate = NSDate() as Date
        notification.soundName = UILocalNotificationDefaultSoundName
        
        UIApplication.shared.scheduleLocalNotification(notification)
    }
}
