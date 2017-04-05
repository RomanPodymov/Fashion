/// Stylization closure wrapper.
public struct Style<T: Styleable> {

  let process: (T) -> Void

  // MARK: - Initialization

  public init(process: @escaping (_ view: T) -> Void) {
    self.process = process
  }

  // MARK: - Stylization

  /**
   Composes multiple styles.

   - Parameter styles: Styles to compose.
   - Returns: A new composed style.
   */
  public static func compose(_ styles: Style<T>...) -> Style<T> {
    return Style { view in
      for style in styles {
        style.apply(to: view)
      }
    }
  }

  /**
   Composes multiple styles.

   - Parameter styles: Styles to compose.
   - Returns: A new composed style.
   */
  public static func compose(_ styles: [Style<T>]) -> Style<T> {
    return Style { view in
      for style in styles {
        style.apply(to: view)
      }
    }
  }

  /**
   Composes the current style with another styles.

   - Parameter styles: Styles to compose with.
   - Returns: A new composed style.
   */
  public func composing(with styles: Style<T>...) -> Style<T> {
    var stylesToCompose = [self]
    stylesToCompose.append(contentsOf: styles)
    return Style<T>.compose(stylesToCompose)
  }

  /**
  Applies style to the passed view.

  - Parameter view: `Styleable` view.
  */
  public func apply(to view: T) -> Void {
    process(view)
  }

  /**
   Applies style to the passed view.

   - Parameter view: `Styleable` view.
   */
  public func apply(to views: T...) {
    for view in views {
      apply(to: view)
    }
  }

  /**
   Applies style to the passed view.

   - Parameter view: `Styleable` view.
   */
  func apply(to view: Styleable) {
    guard let view = view as? T else {
      return
    }

    process(view)
  }
}
