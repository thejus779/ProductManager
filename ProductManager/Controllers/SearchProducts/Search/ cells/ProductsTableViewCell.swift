import UIKit
import SDWebImage

class ProductsTableViewCell: UITableViewCell {

    @IBOutlet private weak var deliveryStatusLabel: UILabel!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productImageView: UIImageView!
    
    @IBOutlet private weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.shadowStyle = .medium
    }
    
    func configure(viewModel: ProductsCellViewModel) {
        deliveryStatusLabel.text = viewModel.deliveryStatusLabel
        deliveryStatusLabel.textColor = viewModel.isDeliveredNextDay ? .systemBrown : .red
        productNameLabel.text = viewModel.productName
        productImageView.sd_setImage(
            with: viewModel.imageUrl,
            placeholderImage: Assets.productPlaceholder.image,
            completed: nil
        )
    }
}
