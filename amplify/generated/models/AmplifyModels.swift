// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "22c0be6caf5bd82cd8827a6c5a08b10a"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: WireDeck.self)
    ModelRegistry.register(modelType: WireCard.self)
  }
}