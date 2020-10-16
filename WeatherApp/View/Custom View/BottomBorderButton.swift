//
//  BottomBorderButton.swift
//  WeatherApp
//
//  Created by Triet Le on 16.10.2020.
//

import UIKit

import UIKit

class BottomBorderButton : UIButton {
    private let selectingTextColor: UIColor = UIColor(red: 0.0, green: 84.0 / 255.0, blue: 159.0 / 255.0, alpha: 1.0)
    private let unselectingTextColor: UIColor = UIColor(red: 0.0, green: 84.0 / 255.0, blue: 159.0 / 255.0, alpha: 0.6)

    private let selectingTextFont: UIFont? = UIFont.systemFont(ofSize: 17, weight: .bold)
    private let unselectingTextFont: UIFont? = UIFont.systemFont(ofSize: 15, weight: .regular)

    var isSelecting = false {
        didSet {
            guard oldValue != isSelecting else { return }
            updateUI()
        }
    }

    private func updateUI() {
        if isSelecting {
            titleLabel?.font = selectingTextFont
            setTitleColor(selectingTextColor, for: .normal)
            addBottomBorderWithColor(color: selectingTextColor, width: bounds.width)
        } else {
            setTitleColor(unselectingTextColor, for: .normal)
            titleLabel?.font = unselectingTextFont
            removeBottomBorder()
        }
    }
}
