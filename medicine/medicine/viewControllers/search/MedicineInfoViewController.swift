//
//  MedicineInfoViewController.swift
//  medicine
//
//  Created by 김영민 on 2022/05/11.
//

import Foundation
import UIKit
import SnapKit

class MedicineInfoViewController : UIViewController {
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        layout()
    }
    
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        
       // label.text = "스포라녹스캡슐"
        return label
    }()
    
    lazy var tabooLabel : UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 27.0, weight: .bold)
        
        label.text = "병용 금기: "
        
        return label
    }()

    lazy var tabooNameLabel : UILabel = {
        let label = UILabel()
        
        
        label.textColor = .red
        label.font = .systemFont(ofSize: 27.0, weight: .bold)
        
        label.text = "제피이트라코나졸과립"
        
        
        return label
    }()
    
    lazy var tabooStackView : UIStackView = {
        let stackView = UIStackView()
        
        [tabooLabel,tabooNameLabel].forEach{ stackView.addArrangedSubview($0) }
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
        
        return stackView
    }()
    
    lazy var nameStackView : UIStackView = {
        let stackView = UIStackView()
        
        [nameLabel,tabooStackView].forEach{ stackView.addArrangedSubview($0) }
        
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        
        return stackView
    }()
    
    
    lazy var sideEffectLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40.0, weight: .bold)
        label.text = "부작용"
        return label
    }()
    
    lazy var sideEffectDetailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .light)
        label.numberOfLines = 3
        label.text = "임부에 대한 안정성 미확립.\n동물 실험에서 고용량 투여 시 태자 기형 발생 증가\n배자독성 유발됨."
        return label
    }()
    
    lazy var sideEffectStackView : UIStackView = {
        let stackView = UIStackView()
        
        [sideEffectLabel,sideEffectDetailLabel].forEach{ stackView.addArrangedSubview($0) }
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 25
        
        return stackView
    }()
    
    private func layout() {
        [nameStackView, sideEffectStackView]
            .forEach{ view.addSubview($0) }
        
        nameStackView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16.0)
            $0.leading.equalToSuperview().inset(16.0)
        }
        sideEffectStackView.snp.makeConstraints{
            $0.top.equalTo(nameStackView.snp.bottom).offset(24.0)
            $0.leading.equalTo(nameStackView.snp.leading)
        }
        
    }
}
