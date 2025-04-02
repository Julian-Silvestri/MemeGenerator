//
//  MemeModel.swift
//  MemeGenerator
//
//  Created by Julian Silvestri on 2025-04-02.
//

import Foundation

class MemeModel: Codable {
    
    let success: Bool
    let data: DataResults
    
    static var dataResults = [MemeResults]()
    static var result = [MemeModel]()

    
    init(success: Bool, data: DataResults) {
        self.success = success
        self.data = data
    }
    
    
}

class MemeResults: Codable{
    let id,name, url: String
    let width, height, box_count: Int
    
    enum CodingKeys: String, CodingKey{
        case id, name, url, width, height
        case box_count = "box_count"
    }
    
    init(id: String, name: String, url: String, width: Int, height: Int, box_count: Int) {
        self.id = id
        self.name = name
        self.url = url
        self.width = width
        self.height = height
        self.box_count = box_count
    }
    
    
}

class DataResults: Codable{
    let memes: [MemeResults]
    
    init(memes: [MemeResults]) {
        self.memes = memes
    }
}


//{
//   "success": true,
//   "data": {
//      "memes": [
//         {
//            "id": "61579",
//            "name": "One Does Not Simply",
//            "url": "https://i.imgflip.com/1bij.jpg",
//            "width": 568,
//            "height": 335,
//            "box_count": 2
//         },
//         {
//            "id": "101470",
//            "name": "Ancient Aliens",
//            "url": "https://i.imgflip.com/26am.jpg",
//            "width": 500,
//            "height": 437,
//            "box_count": 2
//         }
//         // probably a lot more memes here..
//      ]
//   }
//}
