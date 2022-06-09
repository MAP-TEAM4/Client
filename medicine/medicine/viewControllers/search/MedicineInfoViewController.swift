//
//  MedicineInfoViewController.swift
//  medicine
//
//  Created by 김영민 on 2022/05/11.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class MedicineInfoViewController : UIViewController {
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        layout()
    }
    
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        label.numberOfLines = 5
        label.textColor = .systemBlue
        label.lineBreakStrategy = .hangulWordPriority
        return label
    }()
    
    lazy var imageView : UIImageView = {
        let image = UIImageView()
        let processor = DownsamplingImageProcessor(size: CGSize(width: 200, height: 400))
        
        guard let url = URL(string: "https://live.staticflickr.com/65535/51734305911_f4541d7629_m.jpg") else { return UIImageView() }
        
        image.kf.setImage(with: url, options: [.processor(processor)])
        
        return image
    }()
    
    lazy var pregnantLabel : UILabel = {
        let label = UILabel()
        label.text = "🤰🏻🚫"
        return label
    }()
    
    lazy var oldLabel : UILabel = {
        let label = UILabel()
        label.text = "👴🏻🚫"
        return label
    }()
    
    lazy var cautionStackView : UIStackView = {
        let stackView = UIStackView()

        [pregnantLabel,oldLabel].forEach{ stackView.addArrangedSubview($0) }
        
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10

        return stackView
    }()
    
    
    lazy var tabooLabel : UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 27.0, weight: .semibold)
        label.textColor = .systemBlue
        label.text = "병용 금기: "
        
        return label
    }()

    lazy var tabooNameLabel : UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18.0, weight: .light)
        
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
    
    
    
    lazy var sideEffectLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 27.0, weight: .semibold)
        label.textColor = .systemBlue
        label.text = "부작용"
        return label
    }()
    
    lazy var sideEffectDetailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .light)
        label.numberOfLines = 3
        label.text = "임부에 대한 안정성 미확립. 동물 실험에서 고용량 투여 시 태자 기형 발생 증가. 배자독성 유발됨."
        label.lineBreakStrategy = .hangulWordPriority
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
        [nameLabel,cautionStackView,imageView,tabooStackView ,sideEffectStackView]
            .forEach{ view.addSubview($0) }
        
        nameLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16.0)
            $0.trailing.equalTo(cautionStackView.snp.leading).offset(16.0)
            $0.leading.equalToSuperview().inset(16.0)
        }
        cautionStackView.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.top)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        imageView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameLabel.snp.bottom).offset(16.0)
        }
        tabooStackView.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(15.0)
            $0.leading.equalTo(nameLabel.snp.leading)
        }
        sideEffectStackView.snp.makeConstraints{
            $0.top.equalTo(tabooStackView.snp.bottom).offset(24.0)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
    }
}
