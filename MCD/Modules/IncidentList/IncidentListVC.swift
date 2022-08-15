//
//  IncidentListVC.swift
//  MCD
//
//  Created by Weiyi Kong on 15/8/2022.
//

import Alamofire
import SnapKit
import UIKit

class IncidentListVC: UIViewController {
    static let dataURL = "https://run.mocky.io/v3/5e90b420-388e-4913-b240-b5326823212c"

    lazy var incidents = [Incident]() {
        didSet {
            updateList()
        }
    }
    lazy var ascendSort = false { // descend sort by default
        didSet {
            updateList()
        }
    }
    lazy var sortedIncidents = [Incident]()
    lazy var sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortButtonTapped))

    lazy var contentView = IncidentTableView(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground
        title = "Incidents"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.setRightBarButton(sortButton, animated: true)

        setupTableView()
        requestData()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        setupView()
    }

    func setupView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }

    func setupTableView() {
        contentView.delegate = self
        contentView.dataSource = self
        contentView.register(IncidentCell.self, forCellReuseIdentifier: "incident")

        contentView.refreshControl = UIRefreshControl()
        contentView.refreshControl?.addTarget(self, action: #selector(requestData), for: .valueChanged)
    }

    @objc func requestData() {
        AF.request(IncidentListVC.dataURL).validate()
            .responseDecodable(of: [Incident].self, decoder: Incident.decoder) { [weak self] response in
                switch response.result {
                case .success(let value):
                    self?.incidents = value
                case .failure(let error):
                    debugPrint(error)
                }
                self?.contentView.refreshControl?.endRefreshing()
            }
    }

    func updateList() {
        sortedIncidents = incidents.sorted(by: { a, b in
            guard let dateA = a.lastUpdated else { return true }
            guard let dateB = b.lastUpdated else { return true }
            if dateA > dateB { return !ascendSort } else { return ascendSort }
        })
        contentView.reloadData()
    }

    @objc func sortButtonTapped() {
        ascendSort.toggle()
    }
}

extension IncidentListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return sortedIncidents.count }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incident", for: indexPath) as! IncidentCell
        cell.update(with: sortedIncidents[indexPath.row])
        return cell
    }
}

extension IncidentListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        detailVC.incident = sortedIncidents[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
