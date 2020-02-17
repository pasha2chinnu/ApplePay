//
//  Quotation.swift
//  ApplePay
//
//  Created by kvana_imac11 on 17/02/20.
//  Copyright © 2020 kvana_imac11. All rights reserved.
//

import UIKit
//import SwiftyJSON        Add swiftjson pod

enum PaymentStatus: Int {
    case firstPaymentPending = 0
    case firstPaymentDone = 1
    case secondPaymentPending = 2
    case secondPaymentDone = 3
}

class Quotation: NSObject {
    
    var quotationId: String!
    var quotationFields: [QuoteField]!
    var fullAmount:String!
    var paidAmount:String!
    var payNowAmount:String!
    var paymentStatus:PaymentStatus = .firstPaymentPending
    
    required init(json: SwiftyJSON.JSON) {
        
        quotationId = json["id"].stringValue
        quotationFields = QuoteField.array(json["quotation"])
        fullAmount = json["full_payment"].stringValue
        paidAmount = json["paid_amount"].stringValue
        payNowAmount = json["pay_now"].stringValue
        paymentStatus = PaymentStatus(rawValue: json["status"].intValue)!
    }
}
