//
//  IncidentListVC.swift
//  MCD
//
//  Created by Weiyi Kong on 15/8/2022.
//

import UIKit
import SnapKit

class IncidentListVC: UIViewController {
    let contentView = IncidentTableView(frame: .zero, style: .insetGrouped)
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        self.title = "Incidents"
        self.navigationItem.largeTitleDisplayMode = .always

        setupView()
    }

    func setupView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.size.equalTo(view.safeAreaInsets)
        }
    }
}
