//
//  INGAPI.swift
//  ING
//
//  Created by Tom de ruiter on 08/09/2016.
//  Copyright © 2016 Rydee. All rights reserved.
//

import Foundation
import Alamofire

class INGAPI: NSObject {
    
    private var baseURL = "https://www.tomderuiter.com/ingapi/"
    private var version = "v1"
    
    private var username: String!
    private var password: String!
    
    init(username user: String, andPassword pass: String) {
        self.username = user
        self.password = pass
    }
    
    // Get 'master' account details
    
    func getMasterAccountDetails(completionHandler: (NSDictionary?, NSError?) -> ()) {
        makeAPICall("m_acc_details", params: [:], completionHandler: completionHandler)
    }
    
    // Payment account details
    
    func getPaymentAccounts(completionHandler: (NSDictionary?, NSError?) -> ()) {
        makeAPICall("payment_accounts", params: [:], completionHandler: completionHandler)
    }

    func getPaymentAccountDetails(account_number: String, completionHandler: (NSDictionary?, NSError?) -> ()) {
        makeAPICall("payment_account_details", params: ["acc_number": account_number], completionHandler: completionHandler)
    }
    
    func getPaymentAccountTransactions(account_number: String, completionHandler: (NSDictionary?, NSError?) -> ()) {
        makeAPICall("payment_account_transactions", params: ["acc_number": account_number], completionHandler: completionHandler)
    }
    
    // Saving accounts
    
    func getSavingAccounts(completionHandler: (NSDictionary?, NSError?) -> ()) {
        makeAPICall("saving_accounts", params: [:], completionHandler: completionHandler)
    }
    
    func getSavingAccountDetails(account_number: String, completionHandler: (NSDictionary?, NSError?) -> ()) {
        makeAPICall("saving_account_details", params: ["acc_number": account_number], completionHandler: completionHandler)
    }
    
    func getSavingAccountTransactions(account_number: String, completionHandler: (NSDictionary?, NSError?) -> ()) {
        makeAPICall("saving_account_transactions", params: ["acc_number": account_number], completionHandler: completionHandler)
    }
    
    // Creditations
    
    func getDebitDetails(completionHandler: (NSDictionary?, NSError?) -> ()) {
        makeAPICall("debit_details", params: [:], completionHandler: completionHandler)
    }
    
    func getDailyLimit(completionHandler: (NSDictionary?, NSError?) -> ()) {
        makeAPICall("daily_limit", params: [:], completionHandler: completionHandler)
    }
    
    private func makeAPICall(action: String, params: [String: String], completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        var paramaters = [
            "username": self.username,
            "password": self.password
        ]
        
        if params.count > 0 {
            paramaters.update(params)
        }
        
        Alamofire.request(.GET, "\(baseURL)\(version)/\(action)", parameters: paramaters)
            .authenticate(user: username, password: password)
            .responseJSON { response in
                switch response.result {
                case .Success(let value):
                    completionHandler(value as? NSDictionary, nil)
                case .Failure(let error):
                    completionHandler(nil, error)
                }
        }

    }
    
}

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
