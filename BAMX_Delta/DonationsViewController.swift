//
//  DonationsViewController.swift
//  BAMX_Delta
//
//  Created by Alejandro Pizarro on 24/11/22.
//

import Foundation
import UIKit
import Braintree


class DonationsViewController: UIViewController {
    
    var braintreeClient: BTAPIClient?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //braintreeClient = BTAPIClient(authorization: "sandbox_6m27d6hd_fdswynbdc3kggfwz")!
        
        
    }

    @IBAction func paypalPaymentProcess(_ sender: Any) {
        // Example: Initialize BTAPIClient, if you haven't already
        braintreeClient = BTAPIClient(authorization: "sandbox_6m27d6hd_fdswynbdc3kggfwz")!
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient!)

        // Specify the transaction amount here. "2.32" is used in this example.
        let request = BTPayPalCheckoutRequest(amount: "2.32")
        request.currencyCode = "MXN" // Optional; see BTPayPalCheckoutRequest.h for more option
        
        payPalDriver.tokenizePayPalAccount(with: request) { (tokenizedPayPalAccount, error) in
            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")

                // Access additional information
                let email = tokenizedPayPalAccount.email
                print(email!)
                let firstName = tokenizedPayPalAccount.firstName
                let lastName = tokenizedPayPalAccount.lastName
                let phone = tokenizedPayPalAccount.phone

                // See BTPostalAddress.h for details
                let billingAddress = tokenizedPayPalAccount.billingAddress
                let shippingAddress = tokenizedPayPalAccount.shippingAddress
            } else if let error = error {
                print(error)// Handle error here...
            } else {
                // Buyer canceled payment approval
            }
        }
    }
    
}
