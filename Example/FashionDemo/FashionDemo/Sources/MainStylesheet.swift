import Fashion

final class MainStylesheet: Stylesheet {
  func define() {
    share { (navigationBar: UINavigationBar) in
      navigationBar.isTranslucent = false
      navigationBar.barTintColor = .black
      
      navigationBar.titleTextAttributes = [
        NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18),
        NSAttributedStringKey.foregroundColor : UIColor.white
      ]
    }
    
    share { (label: UILabel) in
      label.textColor = .black
      label.font = UIFont.systemFont(ofSize: 20)
      label.numberOfLines = 0
      label.textAlignment = .center
    }
    
    register("content-view") { (view: UIView) in
      view.backgroundColor = .white
    }
    
    register("card-view") { (view: UIView) in
      view.layer.masksToBounds = false
      view.layer.shadowColor = UIColor.black.cgColor
      view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
      view.layer.shadowOpacity = 0.2
      view.layer.cornerRadius = 8
    }
  }
}
