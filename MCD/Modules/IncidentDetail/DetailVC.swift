//
//  DetailVC.swift
//  MCD
//
//  Created by Weiyi Kong on 16/8/2022.
//

import UIKit
import SnapKit

class DetailVC: UIViewController {
    lazy var incident: Incident? = nil {
        didSet {
            guard let incident = incident else { return }
            title = incident.title
            contentView.reloadData()
        }
    }
    lazy var contentView = UITableView(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .never

        setupTableView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        setup()
    }

    func setup() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }

    func setupTableView() {
        contentView.allowsSelection = false
        contentView.dataSource = self
        contentView.register(MapCell.self, forCellReuseIdentifier: "map")
        contentView.register(PropertyCell.self, forCellReuseIdentifier: "property")
    }
}

extension DetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 6 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "map", for: indexPath) as! MapCell
            cell.update(coordinate: incident?.coordinate, icon: incident?.typeIcon)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "property", for: indexPath) as! PropertyCell
        switch indexPath.row {
        case 1:
            cell.update(title: "Location", content: incident?.location)
        case 2:
            cell.update(title: "Status", content: incident?.status?.rawValue)
        case 3:
            cell.update(title: "Type", content: incident?.type)
        case 4:
            cell.update(title: "Call Time", content: incident?.callTime?.customFormatted())
        case 5:
            cell.update(title: "Description", content: incident?.description)
        default:
            break
        }
        return cell
    }
}
