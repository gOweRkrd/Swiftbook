import UIKit

class ViewController: UIViewController {

	@IBAction func nextButtonDidTap(_ sender: Any) {

		let anotherVC = AnotherViewController()
		navigationController?.pushViewController(anotherVC, animated: true)
	}
}

