//
//  HourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 24/02/2023.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        timeLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        temperatureLabel.font = UIFont(name: "Roboto-Regular", size: 14)
    }
    
    override func prepareForReuse() {
        weatherImageView.image = nil
        timeLabel.text = nil
        temperatureLabel.text = nil
        super.prepareForReuse()
    }

    func update(hourlyWeather: HourlyWeather) {
        timeLabel.text = hourlyWeather.time
        temperatureLabel.text = .fromTemperature(hourlyWeather.temperature)
        weatherImageView.image = hourlyWeather.weathercode.largeImage
    }
}

fileprivate extension String {
    static func fromTemperature(_ temperature: Double) -> String {
        String(format: "%.0f°", temperature)
    }
}
