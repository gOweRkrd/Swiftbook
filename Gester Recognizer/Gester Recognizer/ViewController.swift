import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gesterRecognizer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipesObservers()
        tapObserver()
    }
    
    func swipesObservers() {
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    func tapObserver() {
        
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(tripleTapAction))
        tripleTap.numberOfTapsRequired = 3
        self.view.addGestureRecognizer(tripleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction))
        doubleTap.require(toFail: tripleTap)
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
    }
    
    @objc func handleSwipes(gester: UISwipeGestureRecognizer) {
        
        switch gester.direction {
        case .right:
            gesterRecognizer.text = "Right swipe"
        case .left:
            gesterRecognizer.text = "Left swipe "
        case .up:
            gesterRecognizer.text = "Up swipe "
        case .down:
            gesterRecognizer.text = "Down swipe "
        default:
            break
        }
    }
    
    @objc func tripleTapAction() {
        gesterRecognizer.text = "Triple taped was recognized"
    }
    
    @objc func doubleTapAction() {
        gesterRecognizer.text = "Double taped was recognized"
    }
    
}
