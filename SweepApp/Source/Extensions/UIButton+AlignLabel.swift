//
//  UIButton+AlignLabel.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 22/09/22.
//

import Foundation
import UIKit

public extension UIButton {

  func alignTextBelow(spacing: CGFloat = 6.0) {
      if let image = self.imageView?.image {
          let imageSize: CGSize = image.size
          self.titleEdgeInsets = UIEdgeInsets(
            top: spacing,
            left: -imageSize.width,
            bottom: -(imageSize.height),
            right: 0.0
          )
          let labelString = NSString(string: self.titleLabel!.text!)
          let titleSize = labelString.size(
            withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font]
          )
          self.imageEdgeInsets = UIEdgeInsets(
            top: -(titleSize.height + spacing),
            left: 0.0,
            bottom: 0.0,
            right: -titleSize.width
          )
      }
  }
}
