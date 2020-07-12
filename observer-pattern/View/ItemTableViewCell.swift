//
//  ItemTableViewCell.swift
//  observer-pattern
//
//  Created by Ruslan Garifulin on 27.06.2020.
//  Copyright © 2020 Ruslan Garifulin. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    var plusActionBlock: (() -> Void)?
    var minusActionBlock: (() -> Void)?

    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)

        return label
    }()

    private lazy var priceLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = .gray

        return label
    }()

    private lazy var plusButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic-plus"), for: .normal)
        button.addTarget(self, action: #selector(touchUpInside(plusButton:)), for: .touchUpInside)

        return button
    }()

    private lazy var amountLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center

        return label
    }()

    private lazy var minusButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic-minus"), for: .normal)
        button.addTarget(self, action: #selector(touchUpInside(minusButton:)), for: .touchUpInside)

        return button
    }()


    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        setUpSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout

extension ItemTableViewCell {
    private func setUpSubviews() {
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(minusButton)
        addSubview(amountLabel)
        addSubview(plusButton)

        titleLabel.addAnchors(
            top: topAnchor, topPadding: 5.0,
            leading: leadingAnchor, leadingPadding: 10.0,
            height: 20.0
        )
        priceLabel.addAnchors(
            top: titleLabel.bottomAnchor,
            bottom: bottomAnchor, bottomPadding: 5.0,
            leading: leadingAnchor, leadingPadding: 10.0
        )
        plusButton.addAnchors(
            top: topAnchor, topPadding: 10.0,
            trailing: trailingAnchor, trailingPadding: 10.0,
            width: 25.0, height: 25.0
        )
        amountLabel.addAnchors(
            top: topAnchor, topPadding: 10.0,
            trailing: plusButton.leadingAnchor, trailingPadding: 10.0,
            widthAnchor: heightAnchor,
            height: 25.0
        )
        minusButton.addAnchors(
            top: topAnchor, topPadding: 10.0,
            trailing: amountLabel.leadingAnchor, trailingPadding: 10.0,
            width: 25.0, height: 25.0
        )
    }
}

// MARK: - Actions

extension ItemTableViewCell {
    func updateViews(with item: Item) {
        titleLabel.text = item.title
        priceLabel.text = "\(item.price) USD"
        amountLabel.text = String(describing: item.amount)
    }

    private func plusButtonPressed() {
        plusActionBlock?()
    }

    private func minusButtonPressed() {
        minusActionBlock?()
    }
}

// MARK: - UIButton

extension ItemTableViewCell {
    @objc private func touchUpInside(plusButton: UIButton) {
        plusButtonPressed()
    }

    @objc private func touchUpInside(minusButton: UIButton) {
        minusButtonPressed()
    }
}
