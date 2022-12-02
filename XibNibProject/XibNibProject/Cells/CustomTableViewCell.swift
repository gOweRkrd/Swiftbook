import UIKit

struct ViewModel {
	var imageURL: String
	var title: String
	var subtitle: String?
}

class CustomTableViewCell: UITableViewCell {

	@IBOutlet weak var customImageView: UIImageView!

	@IBOutlet weak var topLabel: UILabel!
	@IBOutlet weak var bottomLabel: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
		topLabel.text = "Верхняя строка"
		bottomLabel.text = "Нижняя строка"
	}

	func configure(for viewModel: ViewModel) {
		// Так же тут реализуем ассинхронную загрузку изображения через url
		topLabel.text = viewModel.title
		bottomLabel.text = viewModel.subtitle
	}
}
