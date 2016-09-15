//
//  ivViewController.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 04/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import UIKit

class ivViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var PokemonName: UITextField!
    @IBOutlet weak var PokemonCP: UITextField!
    @IBOutlet weak var PokemonHP: UITextField!
    @IBOutlet weak var PokemonDustPrice: UITextField!
    @IBOutlet weak var PoweredUpSwitch: UISwitch!

    @IBAction func calcIV(sender: AnyObject) {
        let Pokemon = String(PokemonName.text)
        let CP = Int(PokemonCP.text!)
        let HP = Int(PokemonHP.text!)
        let DustPrice = Int(PokemonDustPrice.text!)
        let PoweredUp = PoweredUpSwitch.on
        let enabled = false
        
        if enabled {
            if Pokemon.isEmpty {
                let alertController = UIAlertController(title: "Error", message: "You did not fill out all the fields.", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.Default, handler: nil))
                alertController.show()
            } else if CP == nil {
                let alertController = UIAlertController(title: "Error", message: "You did not fill out all the fields.", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.Default, handler: nil))
                alertController.show()
            } else if HP == nil {
                let alertController = UIAlertController(title: "Error", message: "You did not fill out all the fields.", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.Default, handler: nil))
                alertController.show()
            } else if DustPrice == nil {
                let alertController = UIAlertController(title: "Error", message: "You did not fill out all the fields.", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.Default, handler: nil))
                alertController.show()
            } else {
                CalculateIV().doEquation(Pokemon, CP: CP!, HP: HP!, DustPrice: DustPrice!, PoweredUp: PoweredUp)
            }
        } else {
            let alertController = UIAlertController(title: "Error", message: "Error parsing pokemon. Ensure all fields are filled out.", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.Default, handler: nil))
            alertController.show()
        }
    }
    
    @IBAction func userTappedBackground(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.05)
        let selectionView = UIView()
        selectionView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
        cell.selectedBackgroundView = selectionView
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            let color = UIColor.whiteColor().colorWithAlphaComponent(0.5)
            view.detailTextLabel?.textColor = color
            view.textLabel?.textColor = color
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            let color = UIColor.whiteColor().colorWithAlphaComponent(0.5)
            view.detailTextLabel?.textColor = color
            view.textLabel?.textColor = color
        }
    }
    
    func initializeTextFields() {
        PokemonName.delegate = self
        PokemonName.keyboardType = UIKeyboardType.ASCIICapable
        
        PokemonCP.delegate = self
        PokemonCP.keyboardType = UIKeyboardType.NumberPad
        
        PokemonHP.delegate = self
        PokemonHP.keyboardType = UIKeyboardType.NumberPad
        
        PokemonDustPrice.delegate = self
        PokemonDustPrice.keyboardType = UIKeyboardType.NumberPad
    }
    
    // MARK: UITextFieldDelegate events and related methods
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if string.characters.count == 0 {
            return true
        }
        
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        switch textField {

        case PokemonName:
            return prospectiveText.characters.count <= 20
        case PokemonCP:
            return prospectiveText.containsOnlyCharactersIn("0123456789") &&
                prospectiveText.characters.count < 4
        case PokemonHP:
            return prospectiveText.containsOnlyCharactersIn("0123456789") &&
                prospectiveText.characters.count <= 4
        case PokemonDustPrice:
            return prospectiveText.containsOnlyCharactersIn("0123456789") &&
                prospectiveText.characters.count <= 4
        default:
            return true
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor().HexToColor("#36393E", alpha: 1.0)
        self.tableView.backgroundColor = UIColor().HexToColor("#36393E", alpha: 1.0)
        initializeTextFields()
    }
    
    
}
