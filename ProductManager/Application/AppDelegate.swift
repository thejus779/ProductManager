import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    // Single source of truth, should not be initialized anywhere else
    private lazy var engine: Engine = {
        return Engine(configuration: Configuration())
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        appCoordinator = AppCoordinator(engine: engine, launchOptions: launchOptions)
        configureNavigationBarAppearance()
        configureSearchBarAppearance()
        return true
    }
        
    func applicationDidBecomeActive(_ application: UIApplication) {}
    
    func applicationWillResignActive(_ application: UIApplication) {}
    
    func applicationDidEnterBackground(_ application: UIApplication) {}
    
    func applicationWillEnterForeground(_ application: UIApplication) {}
}


extension AppDelegate {
    /// Configure Navigation bar general appearance
    func configureNavigationBarAppearance(color: UIColor = .darkGray) {
        let navBarAppearance = UINavigationBar.appearance()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = color
        appearance.titleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 16.0),
            .foregroundColor: UIColor.white
        ]
        navBarAppearance.standardAppearance = appearance
        navBarAppearance.scrollEdgeAppearance = appearance
        navBarAppearance.tintColor = .white
    }
    func configureSearchBarAppearance(color: UIColor = .darkGray) {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = color
    }
}
