//
//  MediCell.swift
//  medicine
//
//  Created by 김영민 on 2022/06/09.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class MediCell : UITableViewCell {
    
    var pregnant = SearchViewController().pregnantBool
    var old = SearchViewController().oldBool
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.lineBreakStrategy = .hangulWordPriority
        
        return label
    }()
    
    lazy var pregnantLabel : UILabel = {
        let label = UILabel()
        
        label.isHidden = pregnant
        
        label.text = "🤰🏻🚫"
        return label
    }()
    
    lazy var oldLabel : UILabel = {
        let label = UILabel()
        
        label.isHidden = old
        label.text = "👴🏻🚫"
        return label
    }()
    
    lazy var cautionStackView : UIStackView = {
        let stackView = UIStackView()

        [pregnantLabel,oldLabel].forEach{ stackView.addArrangedSubview($0) }
        
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10

        return stackView
    }()
    
    func setup() {
        [nameLabel,cautionStackView].forEach{addSubview($0)}
        
        nameLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(8.0)
            $0.trailing.equalTo(contentView.snp.centerX).offset(25.0)
        }
        cautionStackView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16.0)
        }
    }

    
}

