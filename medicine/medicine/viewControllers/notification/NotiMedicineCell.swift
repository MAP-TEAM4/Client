//
//  NotiMedicineCell.swift
//  medicine
//
//  Created by 김동규 on 2022/06/09.
//

import UIKit
import SnapKit
import Then

class NotiMedicineCell: UITableViewCell, ViewProtocol {
    static let cellIdentifier: String = "NotiMedicineCell"
    
    var nameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    var timeStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    var drugPrecautionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .systemGray
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpValue()
        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpValue() {}
    
    func setUpView() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(timeStackView)
        self.contentView.addSubview(drugPrecautionLabel)
    }
    
    func setConstraints() {
        let padding: CGFloat = 10
        let labelSpacing: CGFloat = 33
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding)
            make.leading.equalToSuperview().offset(padding)
        }
        
        timeStackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel).offset(labelSpacing)
            make.leading.equalToSuperview().offset(padding)
        }
        
        drugPrecautionLabel.snp.makeConstraints { make in
            make.top.equalTo(timeStackView).offset(labelSpacing - 5)
            make.leading.equalToSuperview().offset(padding)
        }
    }
}

extension NotiMedicineCell {
    func removeAllArrangedSubviews() {
        timeStackView.arrangedSubviews.forEach { subview in
            timeStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
}
