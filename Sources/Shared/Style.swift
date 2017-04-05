/// Stylization closure wrapper.
final class Style<T: Styleable> {

  let process: (_ model: T) -> Void

  // MARK: - Initialization

  init(process: @escaping (_ model: T) -> Void) {
    self.process = process
  }

  // MARK: - Stylization

  /**
  Applies style to the passed model.

  - Parameter model: `Styleable` view/model.
  */
  func apply(to model: Styleable) -> Void {
    guard let model = model as? T else {
      return
    }

    process(model)
  }
}
