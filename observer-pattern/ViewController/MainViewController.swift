//
//  MainViewController.swift
//  observer-pattern
//
//  Created by Ruslan Garifulin on 25.06.2020.
//  Copyright © 2020 Ruslan Garifulin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, Observable {
    lazy var observers: [Observer] = []

    private let cellReuseIdentifier: String = String(describing: ItemTableViewCell.self)

    private var items: [Item] = [] {
        didSet {
            notifyObservers(with: items)
        }
    }

    private lazy var logger = Logger(items: self.items)

    private lazy var cartButton: CartButton = {
        var button = CartButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic-cart"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addAnchors(width: 30.0, height: 30.0)
        button.isHidden = true

        return button
    }()

    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self

        return tableView
    }()
}

// MARK: - Life Cycle

extension MainViewController {
    override func loadView() {
        super.loadView()

        setUpSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "Observer Design Pattern"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButton)

        setUpItems()
        setUpObservers()
    }
}

// MARK: - Layout

extension MainViewController {
    private func setUpSubviews() {
        view.addSubview(tableView)
        tableView.addAnchors(
            top: view.layoutGuide.topAnchor,
            bottom: view.layoutGuide.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor
        )
    }
}

// MARK: - SetUp

extension MainViewController {
    private func setUpObservers() {
        addObserver(cartButton)
        addObserver(self)
        addObserver(logger)
    }

    private func setUpItems() {
        items = [
            Item(title: "iPhone SE", price: 399),
            Item(title: "iPhone XR", price: 549),
            Item(title: "iPhone 11", price: 699),
            Item(title: "iPhone 11 Pro", price: 999),
            Item(title: "AirPods", price: 149),
            Item(title: "AirPods Pro", price: 199),
            Item(title: "Apple Watch Series 3", price: 199),
            Item(title: "Apple Watch Edition", price: 799),
            Item(title: "Apple Watch Hermes", price: 1249),
            Item(title: "Apple Watch Nike", price: 399),
            Item(title: "Apple Watch Series 5", price: 399),
            Item(title: "iPad mini", price: 399),
            Item(title: "iPad", price: 329),
            Item(title: "iPad Air", price: 499),
            Item(title: "iPad Pro", price: 799)
        ]
    }
}

// MARK: - Observer

extension MainViewController: Observer {
    func update<T>(with newValue: T) {
        if let _ = newValue as? [Item] {
            tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)

        if let cell = cell as? ItemTableViewCell {
            cell.updateViews(with: items[indexPath.row])
            cell.plusActionBlock = { [weak self] in
                self?.items[indexPath.row].amount += 1
            }
            cell.minusActionBlock = { [weak self] in
                if let amount = self?.items[indexPath.row].amount, amount > 0 {
                    self?.items[indexPath.row].amount -= 1
                }
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let total = items.reduce(0, { $0 + $1.amount * $1.price } )
        return total > 0 ? "Total for items in cart: \(total) USD" : nil
    }
}
