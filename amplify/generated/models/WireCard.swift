// swiftlint:disable all
import Amplify
import Foundation

public struct WireCard: Model {
  public let id: String
  public var value: String
  public var detail: String?
  public var hexColor: String
  public var wiredeckID: String
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      value: String,
      detail: String? = nil,
      hexColor: String,
      wiredeckID: String) {
    self.init(id: id,
      value: value,
      detail: detail,
      hexColor: hexColor,
      wiredeckID: wiredeckID,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      value: String,
      detail: String? = nil,
      hexColor: String,
      wiredeckID: String,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.value = value
      self.detail = detail
      self.hexColor = hexColor
      self.wiredeckID = wiredeckID
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}