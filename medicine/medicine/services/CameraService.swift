//
//  CameraService.swift
//  medicine
//
//  Created by 김동규 on 2022/06/10.
//

import Alamofire

struct CameraService {
    static let shared = CameraService()
    
    func getOcrResult(imageData: Data, successHandler: @escaping (OcrResultModel) -> Void) {
        let url = APIConstants.getOcrResult
//        let header: HTTPHeaders = [ "Content-type": "multipart/form-data" ]
      
        AF.upload(multipartFormData: { formData in
            formData.append(imageData, withName: "file", fileName: "ocrImage.jpeg", mimeType: "image/jpeg")
        }, to: url, method: .post).responseJSON { response in
            print(response.response)
            if let err = response.error {
                print(err)
                return
            }
            
            print("OCR 결과 요청 성공!!")
            
            let json = response.data
            
            if let json = json {
                print(json)
            }
        }
    }
}
