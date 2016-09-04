//
//  App.swift
//  Example
//
//  Created by Matias Cudich on 8/31/16.
//  Copyright © 2016 Matias Cudich. All rights reserved.
//

import Foundation
import TemplateKit

class App: Node {
  var properties: [String : Any]
  public var state: Any?
  public var eventTarget = EventTarget()

  required init(properties: [String : Any]) {
    self.properties = properties
  }

  func render() -> Element {
    return Element(ElementType.box, ["width": CGFloat(320), "height": CGFloat(500)], [
      Element(ElementType.text, ["text": "blah"]),
      Element(ElementType.node(Details.self))
    ])
  }
}
