//
//  CartButton.swift
//  observer-pattern
//
//  Created by Ruslan Garifulin on 27.06.2020.
//  Copyright © 2020 Ruslan Garifulin. All rights reserved.
//

import UIKit

class CartButton: UIButton {
    let counterLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .rgb(red: 206.0, green: 68.0, blue: 46.0)
        label.font = .systemFont(ofSize: 10.0, weight: .semibold)
        label.textAlignment = .center
        label.layer.cornerRadius = 7.5
        label.clipsToBounds = true
        label.textColor = .white

        return label
    }()

    // MARK: - Init

    init() {
        super.init(frame: .zero)

        setUpSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout

extension CartButton {
    private func setUpSubviews() {
        addSubview(counterLabel)

        counterLabel.addAnchors(
            top: topAnchor, topPadding: -8,
            trailing: trailingAnchor, trailingPadding: -8,
            width: 16.0, height: 16.0
        )
    }
}

// MARK: - Observer

extension CartButton: Observer {
    func update<T>(with newValue: T) {
        if let items = newValue as? [Item] {
            let total = items.reduce(0, { $0 + $1.amount } )
            self.counterLabel.text = String(describing: total)
            self.isHidden = total == 0
        }
    }
}
