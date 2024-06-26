#if canImport(UIKit)
import UIKit

extension UIView {
  private struct AssociatedKeys {
    static var stylesApplied: Void?
  }

  // MARK: - Method Swizzling

  class func setupSwizzling() {
    struct Static {
      static let token = NSUUID().uuidString
    }

    if self !== UIView.self { return }

    DispatchQueue.once(token: Static.token) {
      let originalSelector = #selector(willMove(toSuperview:))
      let swizzledSelector = #selector(fashion_willMove(toSuperview:))

      Swizzler.swizzle(
        cls: UIView.self,
        originalSelector: originalSelector,
        swizzledSelector: swizzledSelector
      )
    }
  }

  @objc func fashion_willMove(toSuperview newSuperview: UIView?) {
    fashion_willMove(toSuperview: newSuperview)

    guard runtimeStyles else {
      return
    }

    guard Stylist.master.applyShared(self) && stylesApplied != true else {
      return
    }

    stylesApplied = true

    if let styles = styles {
      self.styles = styles
    }
  }

  private var stylesApplied: Bool? {
    get {
      withUnsafePointer(to: &AssociatedKeys.stylesApplied) {
        objc_getAssociatedObject(self, $0) as? Bool
      }
    }
    set (newValue) {
      objc_setAssociatedObject(
        self,
        &AssociatedKeys.stylesApplied,
        newValue,
        objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
    }
  }
}
#endif
