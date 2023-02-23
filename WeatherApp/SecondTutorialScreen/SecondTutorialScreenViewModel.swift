//
//  SecondTutorialScreenViewModel.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 23/02/2023.
//

import UIKit

protocol SecondTutorialScreenRouting: AnyObject {
    func endSecondTutorial()
}

struct SecondTutorialScreenViewModel {
    unowned let router: SecondTutorialScreenRouting

    init(router: SecondTutorialScreenRouting) {
        self.router = router
    }
    
    func goNext() {
        router.endSecondTutorial()
    }
}
