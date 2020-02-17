//
//  ViewController.swift
//  ApplePay
//
//  Created by kvana_imac11 on 17/02/20.
//  Copyright © 2020 kvana_imac11. All rights reserved.
//

import UIKit
import PassKit

class ViewController: UIViewController {
    
    var paymentRequest: PKPaymentRequest!
    private var merchantId = "put or merchant id"
    var serviceId: String?
    var quotationData:Quotation?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Helpers
       func decimal(with string: String) -> NSDecimalNumber {
           let formatter = NumberFormatter()
           formatter.generatesDecimalNumbers = true
           return formatter.number(from: string) as? NSDecimalNumber ?? 0
       }
    
    func quotationPaymentDetails() -> [PKPaymentSummaryItem] {
        
        var paymentSummaryItems: [PKPaymentSummaryItem] = []
        //        for quotation in (quotationData?.quotationFields)! {
        //            paymentSummaryItems.append(PKPaymentSummaryItem(label: quotation.quoteTitle, amount: decimal(with: quotation.amount)))
        //        }
        //        paymentSummaryItems.append(PKPaymentSummaryItem(label: "Total", amount: decimal(with: (quotationData?.fullAmount)!)))
        paymentSummaryItems.append(PKPaymentSummaryItem(label: "Pay Now", amount: decimal(with: (quotationData?.payNowAmount)!)))
        return paymentSummaryItems
    }

    @IBAction func applePayAction(_ sender: Any) {
        let paymentNetworks = [PKPaymentNetwork.amex, .visa, .masterCard, .discover]
        
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) {
            
            paymentRequest = PKPaymentRequest()
            paymentRequest.currencyCode = "USD"
            paymentRequest.countryCode = "US"
            
            paymentRequest.merchantIdentifier = merchantId
            paymentRequest.supportedNetworks = paymentNetworks
            paymentRequest.merchantCapabilities = .capability3DS
            paymentRequest.paymentSummaryItems = self.quotationPaymentDetails()
            
            let applePayVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
            applePayVC?.delegate = self
            present(applePayVC!, animated: true, completion: nil)
            
        } else {
//            Helper.showAlert(withtTitle: NSLocalizedString("title_notice", comment: ""), withMessage: NSLocalizedString("setup_apple_pay", comment: ""), inView: self)
            print("Tell the user that he needs to setup Apple pay.")
        }
    }
    
    
    func proceedPayment() {
        /*
        WebServices.doThePayment(serviceId!, cardId: "", typeOfPayment: "apple", success: { (isExpired) in
            
            isExpired ? self.showMovingDateExpiredAlert() : self.showPaymentSuccessAlert()

        }) { (errorMsg) in
            
            self.showPaymentFailedAlert()
        }
        */
    }
    
    func showPaymentFailedAlert() {
//        Helper.showAlert(withtTitle: "", withMessage: NSLocalizedString("failed_payment", comment: ""), inView: self)
    }
    
}

// MARK: - PKPaymentAuthorizationViewControllerDelegate
extension ViewController: PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        completion(PKPaymentAuthorizationStatus.success)
        
        self.proceedPayment()
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        
        self.showPaymentFailedAlert()
    }
}
