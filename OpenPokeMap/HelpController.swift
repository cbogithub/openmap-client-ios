//
//  HelpController.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 05/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import UIKit

class HelpController: UIViewController {

    @IBAction func dismiss(_ sender: AnyObject) {
            self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
