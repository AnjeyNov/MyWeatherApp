//
//  SecondTutorialScreenViewController.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 23/02/2023.
//

import UIKit

class SecondTutorialScreenViewController: UIViewController {
    private let viewModel: SecondTutorialScreenViewModel

    init(viewModel: SecondTutorialScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "SecondTutorialScreenViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
    }

    @IBAction func mainButtonAction() {
        viewModel.goNext()
    }
}
