//
//  TabBarController.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 05/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        for tabBarItem in tabBar.items! {
            tabBarItem.title = ""
        }
        for item in self.tabBar.items! as [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithColor(UIColor.white).withRenderingMode(.alwaysOriginal)
            }
        }
        if let viewControllers = viewControllers {
            for vc in viewControllers {
                vc.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
            }
        }
        
    }

}
