//
//  Launcher.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 23/02/2023.
//

import UIKit

class Launcher {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    var root: UIViewController? {
        get { window.rootViewController }
        set { window.rootViewController = newValue }
    }
    
    func setRoot(_ newRoot: UIViewController?) {
        window.rootViewController = newRoot
    }
    
    func present(_ vc: UIViewController, animated: Bool = true) {
       guard var topController = root else { return }
       while let presentedViewController = topController.presentedViewController {
           topController = presentedViewController
       }
       topController.present(vc, animated: false)
    }
    
    func presentAlert(_ title: String, _ message: String, buttonText: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default))
        present(alert)
    }
}
