//
//  ivViewController.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 04/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import UIKit

class ivViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var PokemonName: UITextField!
    @IBOutlet weak var PokemonCP: UITextField!
    @IBOutlet weak var PokemonHP: UITextField!
    @IBOutlet weak var PokemonDustPrice: UITextField!
    @IBOutlet weak var PoweredUpSwitch: UISwitch!

    @IBAction func calcIV(sender: AnyObject) {
        
        let Pokemon = PokemonName.text
        let CP = Int(PokemonCP.text!)
        let HP = Int(PokemonHP.text!)
        let DustPrice = Int(PokemonDustPrice.text!)
        let PoweredUp = PoweredUpSwitch.on
        
        CalculateIV().doEquation(Pokemon!, CP: CP!, HP: HP!, DustPrice: DustPrice!, PoweredUp: PoweredUp)
    }
    
    @IBAction func userTappedBackground(sender: AnyObject) {
        view.endEditing(true)
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
                prospectiveText.characters.count <= 4
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
        
        initializeTextFields()
    }
    
    
}
