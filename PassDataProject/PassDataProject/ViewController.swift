//
//  ViewController.swift
//  PassDataProject
//
//  Created by Александр Косяков on 15.07.2022.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var LoginTF: UITextField!
    
    @IBOutlet weak var PasswordTF: UITextField!
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBAction func LoginTapped(_ sender: UIButton) {
        // перход на следующий экран, с помощью этого метода можно переходит на разные экраны при нажатии одной кнопки
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    //  функция для перемещения на другой экран через сигвей
    @IBAction func unwindSegueToMainScreen (segue : UIStoryboardSegue){
        guard segue.identifier == "unwindSegue" else {return}
        guard let svc = segue.source as? SecondViewController else {return}
        self.resultLabel.text = svc.Label.text
        
        
    }
    // метод ,который будет вызваться при нажатии на сигвей
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc = segue.destination as? SecondViewController else {return}
        dvc.login = LoginTF.text
        
        
        
        // метод для свертывания клавиатуры
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    }
}


