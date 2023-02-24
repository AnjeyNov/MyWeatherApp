//
//  DailyCollectionViewCell.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 24/02/2023.
//

import UIKit

class DailyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        dayLabel.font = UIFont(name: "Roboto-Bold", size: 16)
        minTemperatureLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        maxTemperatureLabel.font = UIFont(name: "Roboto-Regular", size: 14)
    }
    
    override func prepareForReuse() {
        dayLabel.text = nil
        maxTemperatureLabel.text = nil
        minTemperatureLabel.text = nil
        weatherImageView.image = nil
        super.prepareForReuse()
    }

    func update(dailyWeather: DailyWeather) {
        maxTemperatureLabel.text = .fromTemperature(dailyWeather.maxTemperature)
        minTemperatureLabel.text = .fromTemperature(dailyWeather.minTemperature)
        dayLabel.text = dailyWeather.dayOfWeek
        weatherImageView.image = dailyWeather.weathercode.largeImage
    }
}

fileprivate extension String {
    static func fromTemperature(_ temperature: Double) -> String {
        String(format: "%.0f°", temperature)
    }
}
