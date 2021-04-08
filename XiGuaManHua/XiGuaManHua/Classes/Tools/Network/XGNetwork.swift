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
                       finish: @escaping (_ response: NSDictionary?, _ code: Int, _ msg: NSString?) -> ()) {
        // 1. 获取网络请求类型
        let type = method == .get ?  HTTPMethod.get : HTTPMethod.post
        
        // 2. 发送网络请求
        Alamofire.request(url, method: type, parameters: parameters).responseJSON { ( response ) in
            // 3. 获取结果
            guard let result = response.result.value else {
                // 处理错误
//                finish(nil, 0, response.result.error)
                return
            }
            
            // 4. 容错处理
            guard let resultDic = result as? NSDictionary else {
                
                return
            }
            
            guard let dataDic = resultDic["data"] as? NSDictionary else {
                
                return
            }
            
            guard let stateCode = dataDic["stateCode"] as? Int else {
                
                return
            }
            
            guard stateCode == 1 else {
                
                return
            }
            
            guard let returnDataDic = dataDic["returnData"] as? NSDictionary else {
                
                return
            }
            
            // 5. 将结果回调回去
            finish(returnDataDic, 0, "成功")
        }
    }
}
