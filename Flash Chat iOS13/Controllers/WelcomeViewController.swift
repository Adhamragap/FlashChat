//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    var count:Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
       doingAnimation()
    }
    func doingAnimation (){
        titleLabel.text = ""
        let word = "⚡️FlashChat"
        for i in word {
            Timer.scheduledTimer(withTimeInterval: 0.2 * count, repeats: false) { timer in
                self.titleLabel.text?.append(i)
            }
            count += 1
        }
    }
    

}
