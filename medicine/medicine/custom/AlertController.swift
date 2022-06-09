//
//  AlertController.swift
//  medicine
//
//  Created by 김동규 on 2022/06/09.
//

import UIKit

struct Alert {
    var alertController: UIAlertController
    var title: String
    var message: String
    var handler: (UIAlertAction) -> Void
    var isAddCancel: Bool
    
    init(isAddCancel: Bool = true, title: String, message: String, handler: @escaping (UIAlertAction) -> Void ) {
        self.title = title
        self.message = message
        self.handler = handler
        self.isAddCancel = isAddCancel
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    func showAlert() -> UIAlertController {
        let okAction = UIAlertAction(title: "확인", style: .destructive, handler: handler)
        self.alertController.addAction(okAction)
        if (isAddCancel) {
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            self.alertController.addAction(cancelAction)
        }
        
        return self.alertController
    }
}
