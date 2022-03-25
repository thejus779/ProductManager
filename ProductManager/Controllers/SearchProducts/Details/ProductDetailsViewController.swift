import UIKit

class ProductDetailsViewController: UIViewController, Spawnable {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var imageContainerView: UIView!
    
    private var viewModel: ProductDetailsViewModel!

    static var storyboardName: String? = Storyboards.Main.storyboardName.rawValue

    static func spawn(viewModel: ProductDetailsViewModel) -> ProductDetailsViewController {
        let controller = ProductDetailsViewController.spawn()
        controller.viewModel = viewModel
        controller.title = L10n.Productdetailsviewcontroller.title
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageContainerView.layer.cornerRadius = 10
        imageContainerView.shadowStyle = .medium
        productImageView.sd_setImage(
            with: viewModel.imageUrl,
            placeholderImage: Assets.productPlaceholder.image,
            completed: nil
        )
        tableView.tableHeaderView = headerView
        
    }
}

// MARK: - Table View Delegate impementations
extension ProductDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.displayableInfos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") else {
                return UITableViewCell(style: .default, reuseIdentifier: "InfoCell")
            }
            return cell
        }()
        
        cell.textLabel?.text = viewModel.displayableInfos[indexPath.row].localizedString
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        return cell
    }
}
