// swiftlint:disable all
import Amplify
import Foundation

public struct WireDeck: Model {
  public let id: String
  public var name: String
  public var cards: List<WireCard>?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      name: String,
      cards: List<WireCard>? = []) {
    self.init(id: id,
      name: name,
      cards: cards,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      name: String,
      cards: List<WireCard>? = [],
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.name = name
      self.cards = cards
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}