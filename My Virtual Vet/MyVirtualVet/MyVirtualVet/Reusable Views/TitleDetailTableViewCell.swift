//
//  TitleDetailTableViewCell.swift
//  MyVirtualVet
//
//  Created by Felicity Johnson on 3/11/19.
//  Copyright © 2019 FJ. All rights reserved.
//

import UIKit

private struct Layout {
    static let labelOffset: CGFloat = 10
    static let fontSize: CGFloat = 18
    static let tableViewCellHeight: CGFloat = 100
    static let titleLabelWidth: CGFloat = 170
}

class TitleDetailTableViewCell: UITableViewCell {
    
    // Public Properties
    var titleText: String? {
        didSet {
            guard let title = self.titleText else { return }
            titleLabel.text = title
        }
    }
    
    var detailsText: String? {
        didSet {
            guard let details = self.detailsText else { return }
            detailsLabel.text = details
        }
    }
    
    // Private Properties
    private let titleLabel = UILabel()
    private let detailsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "TitleDetailTableViewCell")
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private funcs
    private func setUpCell() {
        
        // TODO make extension with font stuff
        addSubview(titleLabel)
        titleLabel.font = UIFont.boldSystemFont(ofSize: Layout.fontSize)
        titleLabel.textAlignment = .left
        
        addSubview(detailsLabel)
        detailsLabel.font = UIFont.italicSystemFont(ofSize: Layout.fontSize)
        detailsLabel.textAlignment = .left
        
        addBorder(to: .bottom, with: .lightGray)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Layout.labelOffset)
            make.centerY.equalToSuperview()
            make.width.equalTo(Layout.titleLabelWidth)
        }
        
        detailsLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(Layout.labelOffset)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-Layout.labelOffset)
        }
    }
    
}
