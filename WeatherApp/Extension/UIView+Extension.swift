//
//  UIView+Extension.swift
//  WeatherApp
//
//  Created by Triet Le on 16.10.2020.
//

import UIKit

extension UIView {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: bounds.maxY - 1, width: frame.size.width, height: 2)
        border.name = "BottomBorder"
        layer.addSublayer(border)
    }

    func removeBottomBorder() {
        guard let subLayers = layer.sublayers else { return }

        for layer in subLayers where layer.name == "BottomBorder" {
            layer.removeFromSuperlayer()
        }
    }
}
