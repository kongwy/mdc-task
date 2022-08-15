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
            contentView.reloadData()
        }
    }
    lazy var contentView = IncidentTableView(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground
        title = "Incidents"
        navigationItem.largeTitleDisplayMode = .always

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
    }

    func requestData() {
        AF.request(IncidentListVC.dataURL).validate()
            .responseDecodable(of: [Incident].self, decoder: Incident.decoder) { [weak self] response in
            switch response.result {
            case .success(let value):
                self?.incidents = value
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}

extension IncidentListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return incidents.count }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension IncidentListVC: UITableViewDelegate {
    
}
