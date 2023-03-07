// swiftlint:disable all
import Amplify
import Foundation

extension WireCard {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case value
    case detail
    case hexColor
    case wiredeckID
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let wireCard = WireCard.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "WireCards"
    
    model.attributes(
      .index(fields: ["wiredeckID"], name: "byWireDeck"),
      .primaryKey(fields: [wireCard.id])
    )
    
    model.fields(
      .field(wireCard.id, is: .required, ofType: .string),
      .field(wireCard.value, is: .required, ofType: .string),
      .field(wireCard.detail, is: .optional, ofType: .string),
      .field(wireCard.hexColor, is: .required, ofType: .string),
      .field(wireCard.wiredeckID, is: .required, ofType: .string),
      .field(wireCard.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(wireCard.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension WireCard: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}