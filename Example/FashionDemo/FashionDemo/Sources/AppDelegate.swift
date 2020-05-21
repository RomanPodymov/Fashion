import UIKit
import Fashion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  lazy var navigationController: UINavigationController = .init(rootViewController: self.viewController)
  lazy var viewController: ViewController = .init()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    Fashion.register(stylesheets: [MainStylesheet()])

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()

    return true
  }
}
