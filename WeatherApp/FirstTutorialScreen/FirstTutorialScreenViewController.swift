//
//  FirstTutorialScreenViewController.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 22/02/2023.
//

import UIKit
import CoreLocation

class FirstTutorialScreenViewController: UIViewController {
    private let viewModel: FirstTutorialScreenViewModel
    private let locationManager = CLLocationManager()

    @IBOutlet weak var mainButton: UIButton!

    init(viewModel: FirstTutorialScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "FirstTutorialScreenViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        mainButton.isEnabled = false
        locationManager.delegate = self
        switch locationManager.authorizationStatus {
        case .denied:
            presentAlert()
        default:
            locationManager.requestAlwaysAuthorization()
        }
    }

    @IBAction func mainButtonAction() {
        viewModel.goNext()
    }
    
    private func presentAlert() {
        let alert = UIAlertController(title: .alertTitle, message: .alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: .ok, style: .default))
        present(alert, animated: true)
    }
}

extension FirstTutorialScreenViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            mainButton.isEnabled = true
            viewModel.fetchWeather()
        case .denied:
            mainButton.isEnabled = false
            presentAlert()
        default:
            mainButton.isEnabled = false
        }
    }
}

fileprivate extension String {
    static var alertTitle: String { "Geolocation services must be enabled." }
    static var alertMessage: String { "The geolocation service must be used for the application to work properly." }
    static var ok: String { "Ok" }
}
