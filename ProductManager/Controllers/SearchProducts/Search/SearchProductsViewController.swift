import UIKit

class SearchProductsViewController: UIViewController, Spawnable {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    @IBOutlet private weak var noDataLabel: UILabel!
    @IBOutlet private var searchBar: UISearchBar!
    
    private var viewModel: SearchProductsViewModel!
    private weak var searchCoordinatorDelegate: SearchCoordinatorDelegate?
    
    static var storyboardName: String? = Storyboards.Main.storyboardName.rawValue
    
    static func spawn(searchCoordinatorDelegate: SearchCoordinatorDelegate?, viewModel: SearchProductsViewModel) -> SearchProductsViewController {
        let controller = SearchProductsViewController.spawn()
        controller.searchCoordinatorDelegate = searchCoordinatorDelegate
        controller.viewModel = viewModel
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = searchBar
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.placeholder = L10n.Searchproductsviewcontroller.Field.placeholder
        searchBar.searchTextField.delegate = self
        reloadData()
        configureAccessibilityIdentifier()
    }
    
    private func configureAccessibilityIdentifier() {
        searchBar.searchTextField.accessibilityIdentifier = "searchProductsSearchField"
    }
    private func loadData(with query: String) {
        loader.showLoader()
        noDataLabel.isHidden = true
        viewModel.searchProducts(with: query) { [weak self] result in
            self?.loader.hideLoader()
            switch result {
            case .failure(let error):
                self?.presentAlert(message: error.localizedDescription, completion: nil)
            default: break
            }
            self?.reloadData()
        }
    }
    // Reload data
    private func reloadData() {
        loader.hideLoader()
        
        tableView.isHidden = viewModel.searchedProducts.isEmpty
        tableView.reloadData()

        noDataLabel.text =  searchBar.searchTextField.text?.isEmpty ?? true
        ?  L10n.Searchproductsviewcontroller.Label.search
        : L10n.Searchproductsviewcontroller.Label.nodata
        noDataLabel.isHidden = !viewModel.searchedProducts.isEmpty
    }
}

// MARK: - Table View Delegate impementations
extension SearchProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.searchedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard   let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductsTableViewCell.kReuseIdentifier,
            for: indexPath
        ) as? ProductsTableViewCell
        else { fatalError("Developer error") }
        
        cell.configure(
            viewModel: ProductsCellViewModel(product: viewModel.searchedProducts[indexPath.row])
        )
        // Local pagination, Last cell reached, load more data if needed
        if indexPath.item == viewModel.searchedProducts.count - 1 {
            loadMore()
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.searchedProducts[indexPath.row]
        searchCoordinatorDelegate?.showDetails(for: product)
    }
    
    private func loadMore() {
        viewModel.loadMoreProducts { [weak self] error in
            if let error = error {
                self?.presentAlert(message: error.localizedDescription, completion: nil)
            }
            self?.reloadData()
        }
    }
}
// MARK: - Searchbar Delegate impementations
extension SearchProductsViewController: UISearchBarDelegate, UITextFieldDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.reset()
            reloadData()
        } else {
            loadData(with: searchText)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
