//
//  APIConstants.swift
//  medicine
//
//  Created by 김동규 on 2022/06/09.
//

import Foundation

struct APIConstants {
    static let baseURL = "http://ec2-52-79-100-20.ap-northeast-2.compute.amazonaws.com:8080"
    // 약품 리스트
    static let getMedicineAll = baseURL + "/api/drug/basicDrugList"
    // 등록 약품 주의 사항
    static let getUserMedicineNoti = baseURL + "/api/drug/userDrug"
    // OCR 결과
    static let getOcrResult = "http://ec2-52-79-100-20.ap-northeast-2.compute.amazonaws.com:8000/ocr"
}
