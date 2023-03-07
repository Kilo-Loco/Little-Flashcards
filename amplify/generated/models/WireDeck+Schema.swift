// swiftlint:disable all
import Amplify
import Foundation

extension WireDeck {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case name
    case cards
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let wireDeck = WireDeck.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "WireDecks"
    
    model.attributes(
      .primaryKey(fields: [wireDeck.id])
    )
    
    model.fields(
      .field(wireDeck.id, is: .required, ofType: .string),
      .field(wireDeck.name, is: .required, ofType: .string),
      .hasMany(wireDeck.cards, is: .optional, ofType: WireCard.self, associatedWith: WireCard.keys.wiredeckID),
      .field(wireDeck.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(wireDeck.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension WireDeck: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}