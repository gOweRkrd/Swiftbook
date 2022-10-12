//
//  ViewController.swift
//  WeeklyFinder
//
//  Created by Александр Косяков on 11.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dataTF: UITextField!
    @IBOutlet weak var monthTF: UITextField!
    @IBOutlet weak var yearTF: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBAction func findDay(_ sender: UIButton) {
        
        guard let day = dataTF.text, let month = monthTF.text,let year = yearTF.text else {return}
        let calendar = Calendar.current
        var dateComponents = DateComponents ()
        dateComponents.day = Int(day)
        dateComponents.month = Int (month)
        dateComponents.year = Int (year)
        
        let dateFormatter = DateFormatter ()
        // поменять локализацию
        dateFormatter.locale = Locale (identifier: "ru_Ru")
        // выбор типа надписи
        dateFormatter.dateFormat = "EEEE"
        
        guard let date = calendar .date(from: dateComponents) else {return}
        
        let weekday =  dateFormatter.string(from: date)
        // сделать день недели с большой буквы
        let capitalizedWeekday = weekday.capitalized
        resultLabel.text = capitalizedWeekday
    }
    // функция ,чтобы клавиатуры скрывалась без нажатия
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

