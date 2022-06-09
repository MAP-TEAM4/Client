//
//  UserMedicineService.swift
//  medicine
//
//  Created by 김동규 on 2022/06/09.
//

import Alamofire

struct UserMedicineService {
    static let shared = UserMedicineService()
    
    func getUserMedicineNoti(storedMedicines: [String], successHandler: @escaping (UserMedicineNoti) -> Void) {
        let url = APIConstants.getUserMedicineNoti
        let body: Parameters = [
            "drugs": storedMedicines
        ]
        
        RequestData().sendRequest(url: url, body: body, method: .post, model: UserMedicineNoti.self) { response in
            switch(response) {
            case.success(let data):
                if let data = data as? UserMedicineNoti {
                    print("등록 약품 주의 사항 요청 완료!!")
                    successHandler(data)
                }
            case.decodeErr:
                print("decodeErr")
            case.requestErr:
                print("requestErr")
            case.serverErr:
                print("serverErr")
            case.networkFail:
                print("networkFail")
            }
        }
    }
}
