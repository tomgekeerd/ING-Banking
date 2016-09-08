//
//  ViewController.swift
//  ING
//
//  Created by Tom de ruiter on 08/09/2016.
//  Copyright © 2016 Rydee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let ing = INGAPI(username: "my_username", andPassword: "my_password")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ing.getDebitDetails { (response, error) in
            print(response)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

