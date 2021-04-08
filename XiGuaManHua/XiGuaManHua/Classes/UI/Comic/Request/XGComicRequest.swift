//
//  XGComicRequest.swift
//  XiGuaManHua
//
//  Created by zxd on 2021/4/8.
//

import UIKit

protocol XGComicRequestProtocol {
    static func requestComicData(comicId: Int, finish: @escaping (_ response: String) -> ())
}

extension XGComicRequestProtocol {
    static func requestComicData(comicId: Int, finish: @escaping (_ response: String) -> ()) {
        let url = kBaseUrl + "/comic/detail_static_new"
        let parameters = ["comicid" : comicId]
        
        XGNetwork.xgRequest(url, parameters: parameters) { (result , code, msg) in
            print(result)
        }
    }
}

struct XGComicRequest: XGComicRequestProtocol { }
