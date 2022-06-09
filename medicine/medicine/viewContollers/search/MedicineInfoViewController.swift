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
        
        view.backgroundColor = .systemGray6
        layout()
    }
    
    //약 이름
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        label.text = "아스피린"
        label.textColor = .systemBlue
        return label
    }()
    
    //약 사진
    lazy var imageView : UIImageView = {
        let image = UIImageView()
        let processor = DownsamplingImageProcessor(size: CGSize(width: 100, height: 200))

        guard let url = URL(string: "https://nedrug.mfds.go.kr/pbp/cmn/itemImageDownload/1NeFqpW1gtI")
        else {return UIImageView()}
        image.kf.setImage(
            with: url,
            options: [.processor(processor)]
            )
        
        return image
    }()
    
    //병용금기 제목
    lazy var tabooLabel : UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 27.0, weight: .semibold)
        
        label.text = "병용 금기"
        label.textColor = .systemBlue
        
        return label
    }()

    //병용금기 약물 이름
    lazy var tabooNameLabel : UILabel = {
        let label = UILabel()
        
        
        label.textColor = .red
        label.font = .systemFont(ofSize: 27.0, weight: .light)
        label.textColor = .systemRed
        label.text = ": 제피이트라코나졸과립"
        
        
        return label
    }()
    
    lazy var tabooStackView : UIStackView = {
        let stackView = UIStackView()
        
        [tabooLabel,tabooNameLabel].forEach{ stackView.addArrangedSubview($0) }
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        return stackView
    }()
    
//    lazy var nameStackView : UIStackView = {
//        let stackView = UIStackView()
//
//        [nameLabel,tabooStackView].forEach{ stackView.addArrangedSubview($0) }
//
//
//        stackView.axis = .vertical
//        stackView.distribution = .equalSpacing
//        stackView.spacing = 30
//
//        return stackView
//    }()
    
    
    lazy var sideEffectLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 27.0, weight: .semibold)
        label.textColor = .systemBlue
        label.text = "부작용"
        return label
    }()
    
    lazy var sideEffectDetailLabel: UILabel = {
        let label = UILabel()
        let font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        label.numberOfLines = 0
        
        label.text = "임부에 대한 안정성 미확립. 동물 실험에서 고용량 투여시 태자 기형 발생 증가. 배자독성 유발됨."
        label.lineBreakStrategy = .hangulWordPriority
        
        return label
    }()
    
    lazy var sideEffectStackView : UIStackView = {
        let stackView = UIStackView()
        
        [sideEffectLabel,sideEffectDetailLabel].forEach{ stackView.addArrangedSubview($0) }
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
        
        return stackView
        
    }()
    
    private func layout() {
        [nameLabel,imageView,tabooStackView,sideEffectStackView]
            .forEach{ view.addSubview($0) }
        
        
        nameLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16.0)
            $0.leading.equalToSuperview().inset(16.0)
        }
        
        imageView.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(16.0)
            $0.centerX.equalToSuperview()
        }
        
        tabooStackView.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(16.0)
            $0.leading.equalTo(nameLabel.snp.leading)
        }
        
        sideEffectStackView.snp.makeConstraints{
            $0.top.equalTo(tabooStackView.snp.bottom).offset(24.0)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
    }
}
