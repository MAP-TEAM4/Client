//
//  ExampleService.swift
//  medicine
//
//  Created by 김동규 on 2022/06/09.
//

import Foundation
import Alamofire

struct PostService {
    static let shared = PostService()
    
    // POST
    func getPostList(category: String, successHandler: @escaping ([PostModel])->Void) {
        var url = APIConstants.getPostListURL
        if category != "ALL" {
            url = APIConstants.getCategoryPostListURL + "/\(category)"
        }
        
        RequestData().sendRequest(url: url, body: nil, method: .get, model: [PostModel].self) { response in
            switch(response) {
            case.success(let data):
                if let data = data as? [PostModel] {
                    print("Get Post List Success!!")
                    successHandler(data)
                }
            case.pathErr:
                print("pathErr")
            case.requestErr(let message):
                print("requestErr: \(message)")
            case.serverErr:
                print("serverErr")
            case.networkFail:
                print("networkFail")
            }
        }
    }
    
    // GET
    struct TagService {
        static let shared = TagService()
        
        func getTagList(successHandler: @escaping ([String: Int])->Void) {
            let url = APIConstants.tagURL
            
            RequestData().sendRequest(url: url, body: nil, method: .get, model: [String: Int].self) { response in
                switch(response) {
                case.success(let data):
                    if let data = data as? [String: Int] {
                        print("Get Tag List Success!!")
                        successHandler(data)
                    }
                case.pathErr:
                    print("pathErr")
                case.requestErr(let message):
                    print("requestErr: \(message)")
                case.serverErr:
                    print("serverErr")
                case.networkFail:
                    print("networkFail")
                }
            }
        }
    }
}
