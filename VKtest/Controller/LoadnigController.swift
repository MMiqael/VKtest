//
//  LoadnigController.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 29.11.2020.
//

import UIKit

class LoadnigController: UIViewController {

    @IBOutlet weak var firstCircle: UIImageView!
    @IBOutlet weak var secondCircle: UIImageView!
    @IBOutlet weak var thirdCircle: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfig()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [.autoreverse, .repeat]) {
            self.firstCircle.layer.opacity = 1
        }
        
        UIView.animate(withDuration: 1.5, delay: 0.5, options: [.autoreverse, .repeat]) {
            self.secondCircle.layer.opacity = 1
        }

        UIView.animate(withDuration: 1.5, delay: 1) {
            self.thirdCircle.layer.opacity = 1
        } completion: { (_) in
            self.performSegue(withIdentifier: EnumSegueIdentifiers.toEnter.rawValue, sender: self)
        }
    }
    
    func setupConfig() {
        firstCircle.layer.opacity = 0
        secondCircle.layer.opacity = 0
        thirdCircle.layer.opacity = 0
    }
}
