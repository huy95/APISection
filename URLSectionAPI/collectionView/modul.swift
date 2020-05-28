//
//  modul.swift
//  URLSectionAPI
//
//  Created by Huy on 5/28/20.
//  Copyright © 2020 Huy. All rights reserved.
//

import Foundation
struct ObjectAPI: Codable {
  let resultCount: Int
  let results:[Item]
}

struct Item: Codable {
  let trackId: Int?
  let trackName: String?
  let collectionName: String?
  let artworkUrl100: String?
  let trackPrice: Float?
  let previewUrl: String?
}
