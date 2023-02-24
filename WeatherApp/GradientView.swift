//
//  GradientView.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 24/02/2023.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    @IBInspectable var firstColor: UIColor = .clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = .clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var startPoint = CGPoint(x: 0.0, y: 0.5) {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var endPoint = CGPoint(x: 1.0, y: 0.5) {
        didSet {
            updateView()
        }
    }

    override class var layerClass: AnyClass {
       get {
          return CAGradientLayer.self
       }
    }

    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map{ $0.cgColor }
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint (x: 1, y: 0.5)
    }
}
