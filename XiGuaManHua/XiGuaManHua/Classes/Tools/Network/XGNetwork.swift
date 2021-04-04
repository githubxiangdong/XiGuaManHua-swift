//
//  XGNetwork.swift
//  XiGuaManHua
//
//  Created by zxd on 2021/4/4.
//

import Foundation
import Alamofire

enum MethodType {
    case get
    case post
}

class XGNetwork {
    class func xgRequest(_ url: String,
                       method: MethodType = .get,
                       parameters: [String : Any]? = nil,
                       finish: @escaping (_ response: Any) -> ()) {
        // 1. 获取网络请求类型
        let type = method == .get ?  HTTPMethod.get : HTTPMethod.post

        // 2. 发送网络请求
        Alamofire.request(url, method: type, parameters: parameters).responseJSON { ( response ) in
            
            // 3. 获取结果
            guard let result = response.result.value else {
                // 处理错误
                print(response.result.error!)
                return
            }
            
            // 4. 将结果回调回去
            finish(result)
        }
    }
}
