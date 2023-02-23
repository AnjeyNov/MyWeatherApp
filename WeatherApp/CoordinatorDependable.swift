//
//  CoordinatorDependable.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 23/02/2023.
//

import UIKit

protocol CoordinatorDependable: AnyObject {
    func start()
    func finish()
    func run(_ flowCoordinator: CoordinatorDependable)

    func removeFromParent()

    var childCoordinators: [CoordinatorDependable] { get set }
    var parentCoordinator: CoordinatorDependable? { get set }
}

extension CoordinatorDependable {
    private func add(child coordinator: CoordinatorDependable) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
    }

    private func remove(child coordinator: CoordinatorDependable) {
        guard !childCoordinators.isEmpty else { return }
        
        for (index, child) in childCoordinators.enumerated() where child === coordinator {
            child.parentCoordinator = nil
            childCoordinators.remove(at: index)
            break
        }
    }

    private func attach(to parent: CoordinatorDependable) -> Self {
        parent.add(child: self)
        return self
    }

    @inlinable func removeFromParent() {
        parentCoordinator?.remove(child: self)
    }
    
    func finish() {
        removeFromParent()
    }

    func run(_ flowCoordinator: CoordinatorDependable) {
        flowCoordinator
            .attach(to: self)
            .start()
    }
}
