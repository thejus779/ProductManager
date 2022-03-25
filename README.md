# ProductManager

Welcome to ProductManager app, a basic app which let's the user search for products and display details about the selected product.

## Pre-requirements

1. Minimun deployment target iOS 14

## Libraries used

### Swift package manger
1. TLogger -> https://github.com/thejus779/TLogger -> My personal logger with emojis to make life easy

### Cocoapods
1. SDWebImage -> https://github.com/SDWebImage/SDWebImage -> Only used for managing cached images, as the mocked image urls are loaded from network.



## Architecure

1. ProductManager uses MVVM + coordinator architecure where all data is handled at Model leve, View models respective to each view, and Controllers as Views.
2. All routings and flows are handled by respective Coordinators.
3. Uses pagination on searched result.


## Known Issues to improve in V2

1. Maybe to introduce a cache for the network calls if any.
2. Better UI with some good assests and images.


## Usage

###  ProductService -> Protocol for service calls (ProductNetworkService and MockProductService implements this)

    ```func searchProducts(with query: String, pageNo: Int, completion: @escaping ResultCallback<ProductResponse>)```
    Makes an async call to fetch search results matching the query, can throw erros of type PError.
    
    ```func cancelAnyOngoingRequest()```
    Cancel any ongoing network request.
    
    ```func loadMockedData() -> ProductResponse```
    returns mocked response similar to an actuall api call `product_list.json`
        
    
### SearchProductsViewModel
    ViewModel for the SearchProductsViewController

    ```func searchProducts(with query: String, completion: @escaping ResultCallback<ProductResponse>)```
    ViewModel interacts with the service to fetch response matching the query, can throw erros of type PError.
    
    ```func loadMoreProducts(completion: @escaping (Error?) -> Void )```
    ViewModel interacts with the service to fetch more response for the same the query if available, can throw erros of type PError.
    
    ```func reset()```
    ViewModel resets previous search result
    
### ProductDetailsViewModel
    ViewModel for the ProductDetailsViewController that handles the view according to the product data.

    
### ProductsCellViewModel
    ViewModel for ProductTableViewCell that handles the cell view according to the product data.
    
## Protocols
    
### Spawnable
    Helps in easy instantiating View controllers from storyboard using `storyboardName` and `storyboardIdentifier`
    
## Coordinators

### AppCoordinator
    Handles all routing/navigations at AppDelegate level
### HomeCoordinator
    Handles all routing/navigations and flow at Home, Search and Details level

    

## Tests

### UITests
Performs basic UI flow tests on searching for a prduct.

### Unit Tests & integration tests
Performs unit tests on small modules + complete flow


## Utils

###JsonLoader

    ```func loadResourceJson<T>(filename: String, to type: T.Type, decoder: JSONDecoder = JSONDecoder()) throws -> T where T : Decodable```
    Loads json data and parses them to Decodable from file


## Test Resources

`product_list.json`
    Json format file containing some dummy data used for mocking the product async.
