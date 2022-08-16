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

    // Data List
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

    // Search Bar
    lazy var searchController = UISearchController(searchResultsController: nil)
    lazy var searchResult = [Incident]()

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
        setupSearchController()
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

    func setupSearchController() {
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
        searchController.searchResultsUpdater = self
        contentView.tableHeaderView = searchController.searchBar
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
        if searchController.isActive { return searchResult.count }
        if section == 0 { return sortedIncidents.count }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incident", for: indexPath) as! IncidentCell
        cell.update(with: searchController.isActive ? searchResult[indexPath.row] : sortedIncidents[indexPath.row])
        return cell
    }
}

extension IncidentListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController.dismiss(animated: true)

        let detailVC = DetailVC()
        detailVC.incident = sortedIncidents[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension IncidentListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let keyword = searchController.searchBar.text {
            searchResult = sortedIncidents.filter({ incident in
                return incident.title?.contains(keyword) ?? false
            })
            contentView.reloadData()
        }
    }
}
