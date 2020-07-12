import Foundation

class AppModel {
  
  var appState: AppState = .notStarted

  static let instance = AppModel()

  init() {}
  
  func start() {
    appState = .inProgress
  }
}
