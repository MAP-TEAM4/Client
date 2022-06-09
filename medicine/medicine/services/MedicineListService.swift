//
//  MedicineListService.swift
//  medicine
//
//  Created by 김동규 on 2022/06/09.
//

import Alamofire

struct MedicineListService {
    static let shared = MedicineListService()
    
    func getMedicineAll(successHandler: @escaping ([MedicineModel])->Void) {
        let url = APIConstants.getMedicineAll
        
        RequestData().sendRequest(url: url, body: nil, method: .get, model: [MedicineModel].self) { response in
            switch(response) {
            case.success(let data):
                if let data = data as? [MedicineModel] {
                    print("전체 약품 리스트 요청 완료!!")
                    successHandler(data)
                }
            case.pathErr:
                print("pathErr")
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
