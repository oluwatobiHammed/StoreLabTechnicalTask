//
//  ImageList.swift
//  StoreLabTechnicalTask
//
//  Created by Oluwatobi Oladipupo on 05/07/2023.
//

import RealmSwift
import Realm

@objcMembers
class ImageModel: Object, Decodable {
    private enum CodingKeys: String, CodingKey {
        case id, author, width, height, url, download_url
    }

    public required convenience init(from decoder: Decoder) throws {
        self.init()

        let container               = try decoder.container(keyedBy: CodingKeys.self)
        self.id                     = try container.decodeIfPresent(String.self, forKey: .id)
        self.author       = try container.decodeIfPresent(String.self, forKey: .author)
        self.width       = try container.decode(Int.self, forKey: .width)
        self.height       = try container.decode(Int.self, forKey: .height)
        self.url       = try container.decodeIfPresent(String.self, forKey: .url)
        self.download_url       = try container.decodeIfPresent(String.self, forKey: .download_url)

    }

    override class func primaryKey() -> String? {
        return "id"
    }
    
    dynamic var id              : String?
    dynamic var author          : String?
    dynamic var width           : Int = 0
    dynamic var height          : Int = 0
    dynamic var url             : String?
    dynamic var download_url    : String?
}

