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

    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    @IBOutlet weak var dailyCollectionView: UICollectionView!

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
        
        hourlyCollectionView.register(
            UINib(nibName: "HourlyCollectionViewCell",bundle: nil),
            forCellWithReuseIdentifier: .hourlyCellIdentifier
        )
        hourlyCollectionView.dataSource = self
        hourlyCollectionView.delegate = self
        hourlyCollectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        dailyCollectionView.register(
            UINib(nibName: "DailyCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: .dailyCellIdentifier
        )
        dailyCollectionView.dataSource = self
        dailyCollectionView.delegate = self
    }

}


extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === hourlyCollectionView {
            return viewModel.hourlyWeather.count
        } else {
            return viewModel.dailyWeather.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === hourlyCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .hourlyCellIdentifier, for: indexPath)
            guard let cell = cell as? HourlyCollectionViewCell else { return cell }
            cell.prepareForReuse()
            cell.update(hourlyWeather: viewModel.hourlyWeather[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .dailyCellIdentifier, for: indexPath)
            guard let cell = cell as? DailyCollectionViewCell else { return cell }
            cell.prepareForReuse()
            cell.update(dailyWeather: viewModel.dailyWeather[indexPath.row])
            return cell
        }
    }
}

fileprivate extension String {
    static var hourlyCellIdentifier: String { "HourlyCollectionViewCell" }
    static var dailyCellIdentifier: String { "DailyCollectionViewCell" }
}
