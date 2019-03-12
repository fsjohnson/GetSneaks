//
//  Extensions.swift
//  MyVirtualVet
//
//  Created by Felicity Johnson on 3/11/19.
//  Copyright © 2019 FJ. All rights reserved.
//

import UIKit

private struct Layout {
    static let labelOffset: CGFloat = 10
    static let fontSize: CGFloat = 18
    static let borderLineHeight: CGFloat = 2
}

extension UIView {
    
    enum Border {
        case top, bottom, left, right
    }
    
    func addBorder(to border: Border, with color: UIColor) {
        let borderLine = UIView()
        borderLine.backgroundColor = color
        self.addSubview(borderLine)
        
        borderLine.snp.makeConstraints { make in
            
            switch border {
            case .bottom:
                make.width.bottom.centerX.equalToSuperview()
                make.height.equalTo(Layout.borderLineHeight)
            case .left:
                make.leading.top.bottom.equalToSuperview()
                make.width.equalTo(Layout.borderLineHeight)
            case .right:
                make.trailing.top.bottom.equalToSuperview()
                make.width.equalTo(Layout.borderLineHeight)
            case .top:
                make.width.top.centerX.equalToSuperview()
                make.height.equalTo(Layout.borderLineHeight)
            }
        }
    }
}
