//
//  XGCommonModel.swift
//  XiGuaManHua
//
//  Created by zxd on 2021/4/4.
//

import UIKit
import HandyJSON

struct XGComicsModel: HandyJSON {
    var comicId: Int = 0
    var name: String?
    var cover: String?
    var tags: String?
    var subTitle: String?
    var description: String?
    var cornerInfo: String?
    var short_description: String?
    var author_name: String?
    var is_vip: Int = 0
}

struct XGComicListsModel: HandyJSON {
    var comicType: Int = 0
    var canedit: Int = 0
    var sortId: String?
    var titleIconUrl: String?
    var newTitleIconUrl: String?
    var description: String?
    var itemTitle: String?
    var argName: String?
    var argValue: Int = 0
    var argType: Int = 0
    
    var comics: Any?
    var comicArray: [XGComicsModel] {
        var arr = [XGComicsModel]()
        guard let comicList = comics as? NSArray else { return [] }
        for com in comicList {
            if arr.count >= 4 { break } // 每个只展示4个
            if let comicsModel = XGComicsModel.deserialize(from: com as? NSDictionary) {
                arr.append(comicsModel)
            }
        }
        return arr
    }
}
