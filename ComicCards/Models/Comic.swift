/// Copyright (c) 2018 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import ObjectMapper

open class Comic: BaseResponse /*ImmutableMappable*/ {
  
//  var id: Int = 0
//  var title: String = ""
  var description: String? = ""
  var thumbnail: Thumbnail!
  var characters: CharactersInfo!
  private var dates: [Date]?

  public var onsaleDate: Foundation.Date {
    guard let stringDate = dates?.first(where: { $0.type == "onsaleDate" })?.date,
          let date = Foundation.Date(ISO8601: stringDate) else {
        fatalError("onsaleDate must be present for a Comics object: \(dates)")
    }

    return date
  }
  
//   required init(map: Map) throws {
//    id = try map.value("id")
//    title = try map.value("title")
//    description = try map.value("description")
//    thumbnail = try map.value("thumbnail")
//    dates = try map.value("dates")
//  }
  
  required public init(map: Map) {
    super.init(map: map)
//    id = try! map.value("id")!
//    title = try! map.value("title") ?? ""
//    description = try? map.value("description") ?? ""
//    thumbnail = try! (map.value("thumbnail") ?? nil)!
//    dates = try! (map.value("dates") ?? nil)!
//
    
  }
  
  override open func mapping(map: Map) {
//    self.id <- map["id"]
//    self.title <- map["title"]
    self.description <- map["description"]
    self.thumbnail <- map["thumbnail"]
    self.dates <- map["dates"]
  }
  
  
}

extension Comic: CustomDebugStringConvertible {
  public var debugDescription: String {
    return "<Comic: with \(dates?.count) dates and \(characters.available) characters on-sale from \(onsaleDate)"
  }
}

extension Comic {
  struct Thumbnail: Codable {
    let path: String
    let `extension`: String

    var url: URL {
      return URL(string: path + "." + `extension`)!
    }
  }
}

extension Comic {
  struct Date: Codable {
    let type: String
    let date: String
  }
}

extension Comic {
  struct CharactersInfo: Codable {
    let available: Int
    let items: [Character]
  }

  struct Character: Codable {
    let resourceURI: URL
    let name: String
  }
}
