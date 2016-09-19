//
//  AboutPageControllerTableViewController.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 26/08/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import UIKit

class AboutPageController: UITableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).row == 0 && (indexPath as NSIndexPath).section == 0 {
            if let url = URL(string: "http://www.openstreetmap.org/") , UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        }
        if (indexPath as NSIndexPath).row == 1 && (indexPath as NSIndexPath).section == 0 {
            if let url = URL(string: "https://icons8.com") , UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        }
        else if (indexPath as NSIndexPath).row == 2 && (indexPath as NSIndexPath).section == 0 {
            if let url = URL(string: "https://keybase.io/nullpixel") , UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        }
        else if (indexPath as NSIndexPath).row == 3 && (indexPath as NSIndexPath).section == 0 {
            if let url = URL(string: "https://keybase.io/pwnlambda") , UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        } else if (indexPath as NSIndexPath).row == 4 && (indexPath as NSIndexPath).section == 0 {
            if let url = URL(string: "https://github.com/pogointel") , UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        let selectionView = UIView()
        selectionView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        cell.selectedBackgroundView = selectionView
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            let color = UIColor.white.withAlphaComponent(0.5)
            view.detailTextLabel?.textColor = color
            view.textLabel?.textColor = color
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            let color = UIColor.white.withAlphaComponent(0.5)
            view.detailTextLabel?.textColor = color
            view.textLabel?.textColor = color
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor().HexToColor("#36393E", alpha: 1.0)
        self.tableView.backgroundColor = UIColor().HexToColor("#36393E", alpha: 1.0)
    }
    

}

extension UIColor{
    func HexToColor(_ hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(_ hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
}
