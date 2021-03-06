//
//  ImageService.swift
//  TemplateKit
//
//  Created by Matias Cudich on 8/11/16.
//  Copyright © 2016 Matias Cudich. All rights reserved.
//

import Foundation

class ImageParser: Parser {
  typealias ParsedType = UIImage

  required init() {}

  func parse(data: Data) throws -> UIImage {
    guard let image = UIImage(data: data) else {
      throw TemplateKitError.parserError("Invalid image data")
    }
    return image
  }
}

class ImageService: ResourceService<ImageParser> {
  static let shared = ImageService()

  convenience init() {
    self.init(requestQueue: DispatchQueue(label: "ImageService"))
  }
}
