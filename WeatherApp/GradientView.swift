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
    
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.0, y: 0.5) {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 1.0, y: 0.5) {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var locations: [NSNumber] = [0, 1] {
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
        layer.locations = locations
        layer.startPoint = startPoint
        layer.endPoint = endPoint
//        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
    }
}
