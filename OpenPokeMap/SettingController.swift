//
//  SettingController.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 10/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import UIKit

class SettingController: UITableViewController {
    
    @IBAction func dismissView(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var debug: UISwitch!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        let debugSwitch = debug.isOn
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
