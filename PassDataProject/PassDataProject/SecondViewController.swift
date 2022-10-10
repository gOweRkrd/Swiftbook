//
//  SecondViewController.swift
//  PassDataProject
//
//  Created by Александр Косяков on 15.07.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    var login : String?

    @IBOutlet weak var Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // метод ,чтобы в имени не писался опциональный тип 
        guard let login = self.login else { return}
        Label.text = " Hello,\(login)"
    }
    
    
    
    @IBAction func goBackTapped(_ sender: UIButton) {
        //привязка к экрану ,а не к кнопке бэк
        performSegue(withIdentifier: "unwindSegue", sender: nil)
    }
}
