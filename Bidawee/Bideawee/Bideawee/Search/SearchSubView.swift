//
//  SearchSubView.swift
//  Bideawee
//
//  Created by Felicity Johnson on 9/24/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation
import UIKit

final class SearchSubView: UIView {
    
    private struct Layout {
        static let textFieldHeight: CGFloat = 60
    }
    
    //MARK: - Private properties
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let dropDownTextField = CustomTextField()
    private let data: [String]
    
    //MARK: - Public properties
    var title: String? {
        didSet {
            titleLabel.text = title?.uppercased() ?? ""
        }
    }
    
    init(data: [String]) {
        self.data = data
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        
        titleLabel.font = UIFont.themeSmallBold
        titleLabel.textColor = UIColor.themePink
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dropDownTextField)
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        dropDownTextField.translatesAutoresizingMaskIntoConstraints = false
        dropDownTextField.heightAnchor.constraint(equalToConstant: Layout.textFieldHeight).isActive = true
        
        dropDownTextField.layer.borderWidth = 2.0
        dropDownTextField.layer.borderColor = UIColor.black.cgColor
        dropDownTextField.layer.cornerRadius = 5.0
        dropDownTextField.addToolBar()
        dropDownTextField.loadDropdownData(data: data)
    }
}
