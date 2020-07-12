//
//  Logger.swift
//  observer-pattern
//
//  Created by Ruslan Garifulin on 28.06.2020.
//  Copyright © 2020 Ruslan Garifulin. All rights reserved.
//

import Foundation

class Logger {
    var items: [Item]

    // MARK: - Init

    init(items: [Item]) {
        self.items = items
    }
}

// MARK: - Observer

extension Logger: Observer {
    func update<T>(with newValue: T) {
        if let updatedItems = newValue as? [Item] {
            logDifference(between: items, and: updatedItems)
        }
    }
}

// MARK: - Actions

extension Logger {
    private func logDifference(between oldItems: [Item], and updatedItems: [Item]) {
        guard oldItems.count == updatedItems.count else { return }

        for (index, item) in oldItems.enumerated() {
            if item.amount != updatedItems[index].amount {
                let actionTitle = item.amount < updatedItems[index].amount ? "added to" : "removed from"
                print("\(item.title) was \(actionTitle) cart")
                break
            }
        }

        items = updatedItems
    }
}
