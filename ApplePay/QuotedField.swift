//
//  QuotedField.swift
//  ApplePay
//
//  Created by kvana_imac11 on 17/02/20.
//  Copyright © 2020 kvana_imac11. All rights reserved.
//

import UIKit
//import SwiftyJSON        Add swiftjson pod

class QuotedField: NSObject {
    
    var quoteId: String!
       var quoteTitle: String!
       var amount:String!
       
       required init(json: SwiftyJSON.JSON) {
           
           quoteId = json["id"].stringValue
           quoteTitle = json["title"].stringValue
           amount = json["amount"].stringValue
       }
       
       class func array(_ quoteObjectList:JSON) -> [QuoteField] {
           var quoteItemsArray = [QuoteField]()
           for (_, subJson) in quoteObjectList {
               let obj:QuoteField = QuoteField(json: subJson)
               quoteItemsArray.append(obj)
           }
           return quoteItemsArray
       }
}
