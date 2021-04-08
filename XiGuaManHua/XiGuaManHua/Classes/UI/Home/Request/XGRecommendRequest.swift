//
//  XGHomeDataRequest.swift
//  XiGuaManHua
//
//  Created by zxd on 2021/4/3.
//

import UIKit

protocol XGRecommendRequestProtocol {
    // 请求推荐数据接口
    static func requestRecommendData(finish: @escaping (_ comicLists: [XGComicListsModel]) -> ())
}

extension XGRecommendRequestProtocol {
    // 实现请求推荐接口
    static func requestRecommendData(finish: @escaping (_ comicLists: [XGComicListsModel]) -> ()) {
        let url = kBaseUrl + "/comic/boutiqueListNew"
        let parameters = ["sexType" : 1]
        
        XGNetwork.xgRequest(url, parameters: parameters) { (result , code, msg)  in
            guard let comicLists = result?["comicLists"] as? NSArray else {
                
                return
            }
            
            var comicListsModels = [XGComicListsModel]()
            for comic in comicLists {
                if let comicListsModel = XGComicListsModel.deserialize(from: comic as? NSDictionary) {
                    comicListsModels.append(comicListsModel)
                }
            }
            
            finish(comicListsModels)
        }
    }
}

struct XGRecommendRequest: XGRecommendRequestProtocol { }
