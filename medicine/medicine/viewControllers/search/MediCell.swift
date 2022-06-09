import Foundation
import UIKit
import SnapKit
import Kingfisher

class MediCell : UITableViewCell {
    
   
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        
        return label
    }()
    
   
    
    func setup() {
        [nameLabel].forEach{addSubview($0)}
        
        nameLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(8.0)
            $0.centerY.equalToSuperview()
        }
       
    }

    
}

