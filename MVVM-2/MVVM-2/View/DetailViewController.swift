import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    var viewModel:DetailViewModelType?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // проверка на то ,что виью модель есть
        guard let viewModel = viewModel else {return}
        self.textLabel.text = viewModel.description
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.age.bind {[unowned self] in
            guard let string = $0 else {return}
            
            self.textLabel.text = string
        }
        // создание задержки 
        delay(delay: 5) { [unowned self] in
            self.viewModel?.age.value = "some new value"
        }
    }
    private func delay(delay:Double,closure:@escaping() -> ()) {
        DispatchQueue.main.asyncAfter (wallDeadline: .now() + delay) {
            closure()
            
        }
        
    }
}
