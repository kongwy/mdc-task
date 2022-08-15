//
//  IncidentCell.swift
//  MCD
//
//  Created by Weiyi Kong on 15/8/2022.
//

import UIKit
import Kingfisher
import SwiftUI

class IncidentCell: UITableViewCell {
    lazy var icon = UIImageView()
    lazy var date = UILabel()
    lazy var title = UILabel()
    lazy var statusBg = UIView()
    lazy var status = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        accessoryType = .disclosureIndicator
        setup()
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(icon)

        date.font = .preferredFont(forTextStyle: .footnote)
        contentView.addSubview(date)

        title.font = .preferredFont(forTextStyle: .subheadline, weight: .semibold)
        title.numberOfLines = 0
        contentView.addSubview(title)

        statusBg.layer.cornerRadius = 4
        contentView.addSubview(statusBg)

        status.font = .preferredFont(forTextStyle: .footnote, weight: .semibold)
        status.textColor = .white
        contentView.addSubview(status)
    }

    private func layout() {
        icon.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.left.equalToSuperview().offset(14)
            make.centerY.equalToSuperview()
        }

        date.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(14)
            make.right.equalToSuperview().offset(-8)
            make.top.equalToSuperview().offset(7)
        }

        title.snp.makeConstraints { make in
            make.left.equalTo(date.snp.left)
            make.right.equalTo(date.snp.right)
            make.top.equalTo(date.snp.bottom).offset(7)
        }

        statusBg.snp.makeConstraints { make in
            make.left.equalTo(date.snp.left)
            make.top.equalTo(title.snp.bottom).offset(7)
            make.width.equalTo(status.snp.width).offset(8)
            make.height.equalTo(status.snp.height).offset(6)
            make.bottom.equalToSuperview().offset(-12)
        }

        status.snp.makeConstraints { make in
            make.center.equalTo(statusBg.snp.center)
        }
    }

    func update(with model: Incident) {
        icon.kf.indicatorType = .activity
        icon.kf.setImage(with: model.typeIcon)
        date.text = model.lastUpdated?.customFormatted()
        title.text = model.title
        status.text = model.status?.rawValue
        switch model.status {
        case .underControl:
            statusBg.backgroundColor = .systemGreen
        case .onScene:
            statusBg.backgroundColor = .systemBlue
        case .outOfControl:
            statusBg.backgroundColor = .systemRed
        case .pending:
            statusBg.backgroundColor = .systemOrange
        default:
            break
        }
    }
}
