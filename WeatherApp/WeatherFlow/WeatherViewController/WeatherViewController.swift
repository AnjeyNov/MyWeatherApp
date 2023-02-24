//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 24/02/2023.
//

import UIKit

class WeatherViewController: UIViewController {
    private let viewModel: WeatherViewModel
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!

    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "WeatherViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text = viewModel.location.city
        cityLabel.font = UIFont(name: "Roboto-Bold", size: 21)

        weatherLabel.text = viewModel.currentWeather.weathercode.text
        weatherLabel.font = UIFont(name: "Roboto-Regular", size: 13)

        temperatureLabel.text = "\(viewModel.currentWeather.temperature)°"
        temperatureLabel.font = UIFont(name: "Roboto-Bold", size: 40)
        
        weatherImage.image = viewModel.currentWeather.weathercode.largeImage
    }

}

