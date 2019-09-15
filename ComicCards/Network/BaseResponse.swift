import Foundation
import ObjectMapper

open class BaseResponse: Mappable {
  
  required public init(map: Map) {
    id = try! map.value("id")
    title = try! map.value("title")
  }
  
  open var id: Int!
  open var title: String!
  
  open func mapping(map: Map) {
    id <- map["id"]
    title <- map["title"]
  }
}


