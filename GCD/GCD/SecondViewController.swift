//
//  SecondViewController.swift
//  GCD
//
//  Created by Александр Косяков on 22.11.2022.
//

import UIKit

class SecondViewController:UIViewController {
    
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // загрузка изображения через интернет
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()
        // задержка в 3 секунду до появления AlertController
        delay(3) {
            self.loginAlert()
        }
        
    }
    // метод для создания определенной задержки во времени
    fileprivate func delay(_ delay:Int,closure: @escaping () ->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    fileprivate func loginAlert() {
        let ac = UIAlertController(title: "Зарегистрированы?", message: "Ввведите ваш логин и пароль", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default,handler: nil)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default,handler: nil)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { (usernameTF) in
            usernameTF.placeholder = "Введите логин"
        }
        ac.addTextField { (userPasswordTF) in
            userPasswordTF.placeholder = "Введите пароль"
            userPasswordTF.isSecureTextEntry = true
        }
        
        self.present(ac,animated: true,completion: nil)
    }
    
    // метод загрузки картинки с интернета
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        // создаем поток с приоритетом на асинхронной очереди
        let queue = DispatchQueue.global(qos:.utility)
        queue.async {
            guard  let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            // возвращаемся на главный поток
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
            
        }
        
        
    }
}


