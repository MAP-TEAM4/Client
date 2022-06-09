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
    
    var pregnant : Bool = false
    var old : Bool = false
    var imageUrl : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22.0, weight: .bold)
    
        return label
    }()
    
    lazy var imageView : UIImageView = {
        let image = UIImageView()
        let processor = DownsamplingImageProcessor(size: CGSize(width: 200, height: 400))
        
        guard let url = URL(string: "\(self.imageUrl)") else { return UIImageView() }
        
        image.kf.setImage(with: url, options: [.processor(processor)])
        image.layer.cornerRadius = 20.0
        
        return image
    }()
    
 
    
    lazy var tabooLabel : UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 22.0, weight: .semibold)
     
        label.text = "병용 금기 "
        
        return label
    }()

    lazy var tabooNameLabel : UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15.0, weight: .light)
        label.text = "없음"
        return label
    }()
    
    
    lazy var sideEffectLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22.0, weight: .semibold)
       
        label.text = "부작용"
        return label
    }()
    
    lazy var sideEffectDetailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .light)
        label.numberOfLines = 3
        label.text = "없음"
        label.lineBreakStrategy = .hangulWordPriority
        return label
    }()
    lazy var pregnantLabel : UILabel = {
        let label = UILabel()
        
        
        label.isHidden = self.pregnant
        
        label.text = "🤰🏻🚫 임부 금기"
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()
    
    lazy var oldLabel : UILabel = {
        let label = UILabel()
        
        
        label.isHidden = self.old
        
        label.text = "👴🏻🚫 노인 금기"
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()
    
    lazy var view1 : UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    lazy var view2 : UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    
    //MARK: StackViews
    
    lazy var nameStackView : UIStackView = {
        let stackView = UIStackView()

        [nameLabel,imageView].forEach{ stackView.addArrangedSubview($0) }

        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
        stackView.layer.cornerRadius = 10.0
   
        return stackView
    }()
    
    
    lazy var tabooStackView : UIStackView = {
        let stackView = UIStackView()

        [tabooLabel,tabooNameLabel].forEach{ stackView.addArrangedSubview($0) }

        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
        stackView.layer.cornerRadius = 10.0
        
        return stackView
    }()
    
    lazy var sideEffectStackView : UIStackView = {
        let stackView = UIStackView()
        
        [sideEffectLabel,sideEffectDetailLabel].forEach{ stackView.addArrangedSubview($0) }
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 25
        stackView.layer.cornerRadius = 10.0
      
        return stackView
    }()
    
    lazy var cautionStackView : UIStackView = {
        let stackView = UIStackView()

        [pregnantLabel,oldLabel].forEach{ stackView.addArrangedSubview($0) }
        
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10

        return stackView
    }()
    

    
    
    private func layout() {
        [nameLabel,cautionStackView,imageView,view1,view2,tabooStackView,sideEffectStackView]
            .forEach{ view.addSubview($0) }
        
        nameLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16.0)
            $0.centerX.equalToSuperview()
        }
      
        cautionStackView.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().inset(16.0)
        }
        
        imageView.snp.makeConstraints{
            $0.top.equalTo(cautionStackView.snp.bottom).offset(16.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }
        
        
        view1.snp.makeConstraints{
            $0.width.height.equalTo(1)
            $0.top.equalTo(imageView.snp.bottom).offset(16.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }
      
        tabooStackView.snp.makeConstraints{
            $0.top.equalTo(view1.snp.bottom).offset(32.0)
            $0.leading.equalToSuperview().inset(16.0)
        }
        
        view2.snp.makeConstraints{
            $0.width.height.equalTo(1)
            $0.top.equalTo(tabooStackView.snp.bottom).offset(16.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }
        
        sideEffectStackView.snp.makeConstraints{
            $0.top.equalTo(view2.snp.bottom).offset(32.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
    }
}
