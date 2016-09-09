//
//  UIKitRenderer.swift
//  TemplateKit
//
//  Created by Matias Cudich on 9/3/16.
//  Copyright © 2016 Matias Cudich. All rights reserved.
//

import Foundation
import SwiftBox

public enum ElementType: ElementRepresentable, Equatable {
  case box
  case text
  case image
  case view(UIView)
  case node(AnyClass)

  public func make(_ properties: [String: Any], _ children: [Element]?, _ owner: Node?) -> BaseNode {
    switch self {
    case .box:
      return NativeNode<Box>(properties: properties, children: children?.map { $0.build(with: owner) }, owner: owner)
    case .text:
      return NativeNode<Text>(properties: properties, owner: owner)
    case .image:
      return NativeNode<Image>(properties: properties, owner: owner)
    case .view(let view):
      return ViewNode(view: view)
    case .node(let nodeClass as Node.Type):
      return nodeClass.init(properties: properties, owner: owner)
    default:
      fatalError()
    }
  }

  public func equals(_ other: ElementRepresentable) -> Bool {
    guard let otherType = other as? ElementType else {
      return false
    }
    return self == otherType
  }

  static func fromRaw(_ rawValue: String) throws -> ElementType {
    switch rawValue {
    case "box":
      return .box
    case "text":
      return .text
    case "image":
      return .image
    default:
      return try .node(NodeRegistry.shared.nodeType(for: rawValue))
    }
  }
}

public func ==(lhs: ElementType, rhs: ElementType) -> Bool {
  switch (lhs, rhs) {
  case (.box, .box), (.text, .text), (.image, .image):
    return true
  case (.node(let lhsClass), .node(let rhsClass)):
    return lhsClass == rhsClass
  default:
    return false
  }
}

public enum UIKitRenderer: Renderer {
  public typealias ViewType = UIView
}
