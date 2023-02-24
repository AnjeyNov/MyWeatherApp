//
//  UIView+CornerRadius.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 24/02/2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadus: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}
