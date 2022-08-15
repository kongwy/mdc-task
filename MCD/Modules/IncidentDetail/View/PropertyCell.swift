//
//  PropertyCell.swift
//  MCD
//
//  Created by Weiyi Kong on 16/8/2022.
//

import UIKit
import SnapKit

class PropertyCell: UITableViewCell {
    lazy var title = UILabel()
    lazy var content = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        setup()
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        title.font = .preferredFont(forTextStyle: .footnote, weight: .bold)
        title.textColor = .secondaryLabel
        contentView.addSubview(title)

        content.numberOfLines = 0
        content.font = .preferredFont(forTextStyle: .body)
        contentView.addSubview(content)
    }

    func layout() {
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(8)
        }

        content.snp.makeConstraints { make in
            make.left.equalTo(title.snp.left)
            make.right.equalTo(title.snp.right)
            make.top.equalTo(title.snp.bottom).offset(2)
            make.bottom.equalToSuperview().offset(-8)
        }
    }

    func update(title: String?, content: String?) {
        self.title.text = title
        self.content.text = content ?? "Not available"
    }
}
