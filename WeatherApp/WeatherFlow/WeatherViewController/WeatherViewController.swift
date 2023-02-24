//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 24/02/2023.
//

import UIKit

class WeatherViewController: UIViewController {
    private let viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "WeatherViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
