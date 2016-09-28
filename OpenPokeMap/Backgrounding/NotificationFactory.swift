//
//  NotificationFactory.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 19/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import UIKit
import UserNotifications
import MobileCoreServices

class NotificationFactory {
    static let shared = NotificationFactory()
    let temporaryDirectory = URL(fileURLWithPath: NSTemporaryDirectory())
    
    static func send(for pokemon: String, pokemonID: Int, uniqueID: String) {
        NotificationFactory.shared.send(for: pokemon, pokemonID: pokemonID, uniqueID: uniqueID)
    }
    
    func send(for pokemon: String, pokemonID: Int, uniqueID: String) {
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = "Found Pokemon"
            content.body = "A wild \(pokemon) has spawned!"
            var existURL: URL? = temporaryDirectory.appendingPathComponent("pokemon-\(pokemonID).png")
            if !FileManager.default.fileExists(atPath: existURL!.path) {
                if let image = PokemonInfo.shared.pokemonThumbnail(for: pokemonID), let data = UIImagePNGRepresentation(image) {
                    do {
                        try data.write(to: existURL!)
                    } catch {
                        existURL = nil
                    }
                } else {
                    existURL = nil
                }
            }
            if let imageURL = existURL, let attachment = try? UNNotificationAttachment(identifier: String(pokemonID), url: imageURL, options: [UNNotificationAttachmentOptionsTypeHintKey: kUTTypePNG]) {
                content.attachments.append(attachment)
            }
            let request = UNNotificationRequest(identifier: uniqueID, content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        } else {
            // Fallback on earlier versions
            let notification = UILocalNotification()
            notification.alertTitle = "Found Pokemon"
            notification.alertBody = "A wild \(pokemon) has spawned!"
            notification.alertAction = "Catch it!"
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.presentLocalNotificationNow(notification)
        }
    }
}
