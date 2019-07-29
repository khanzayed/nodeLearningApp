//
//  RegistrationViewController.swift
//  NodeLearningApp
//
//  Created by Faraz on 28/07/19.
//  Copyright © 2019 Faraz. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneTapped(_ sender: UIButton) {
    }
    
}
