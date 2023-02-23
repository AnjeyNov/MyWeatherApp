//
//  FirstTutorialScreenViewModel.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 22/02/2023.
//

import Foundation

protocol FirstTutorialScreenRouting: AnyObject {
    func endFirstTutorial()
}

struct FirstTutorialScreenViewModel {
    unowned let router: FirstTutorialScreenRouting
    
    init(router: FirstTutorialScreenRouting) {
        self.router = router
    }
    
    func goNext() {
        router.endFirstTutorial()
    }
}
