//
//  NetworkResult.swift
//  medicine
//
//  Created by 김동규 on 2022/06/09.
//

import Foundation

enum NetworkResult<T>{
    case success(T)
    case requestErr
    case pathErr
    case serverErr
    case networkFail
}
