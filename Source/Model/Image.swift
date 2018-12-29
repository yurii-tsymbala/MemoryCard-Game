//
//  Image.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 12/29/18.
//  Copyright © 2018 Yurii Tsymbala. All rights reserved.
//

import Foundation

struct Image: Codable {
  let name: String
  let link: String

  enum CodingKeys: String, CodingKey {
    case name = "name"
    case link = "link"
  }
}

struct Images {
  var images: [Image]
}


