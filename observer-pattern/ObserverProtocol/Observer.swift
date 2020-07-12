//
//  Observer.swift
//  observer-pattern
//
//  Created by Ruslan Garifulin on 27.06.2020.
//  Copyright © 2020 Ruslan Garifulin. All rights reserved.
//

import Foundation

protocol Observer: class {
    func update<T>(with newValue: T)
}
