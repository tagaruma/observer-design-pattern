//
//  Observable.swift
//  observer-pattern
//
//  Created by Ruslan Garifulin on 27.06.2020.
//  Copyright © 2020 Ruslan Garifulin. All rights reserved.
//

import UIKit

protocol Observable: class {
    var observers: [Observer] { get set }

    func addObserver(_ observer: Observer)
    func removeObserver(_ observer: Observer)
    func notifyObservers<T>(with newValue: T)
}

extension Observable {
    func addObserver(_ observer: Observer) {
        if !observers.contains(where: { $0 === observer }) {
            observers.append(observer)
        }
    }

    func removeObserver(_ observer: Observer) {
        observers = observers.filter { $0 !== observer }
    }

    func notifyObservers<T>(with newValue: T) {
        observers.forEach { $0.update(with: newValue) }
    }
}
