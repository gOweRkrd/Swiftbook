
import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var cenliusLabel: UILabel!
    @IBOutlet weak var fahrenheitLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider! {
       //момент инициализации
    didSet {
            slider.maximumValue = 100
            slider.minimumValue = 0
            slider.value = 0
        }
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let temperatureCelsius = Int(round(sender.value))
        cenliusLabel.text = "\(temperatureCelsius)ºC"
        let fahrengeitT = Int( round((sender.value * 9 / 5) + 32))
        fahrenheitLabel.text = "\(fahrengeitT)ºF"
    }
    
    
    
    
    
    
    
    
}

