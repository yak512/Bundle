//
//  MoneyViewController.swift
//  Bundle
//
//  Created by BOUHADEB Yacoub on 03/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

import UIKit

class MoneyViewController: UIViewController {

    var usdRate = Float()
    @IBOutlet weak var amountMoney: UITextField!
    @IBOutlet weak var usdOrEur: UISegmentedControl!
    @IBOutlet weak var LabelResult: UILabel!
    @IBOutlet weak var amoutCurrency: UILabel!
    @IBOutlet weak var resultConversion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        MoneyService.shared.getUsdRate { (succes, MoneyRateResponse) in
            if succes {
                self.usdRate = MoneyRateResponse!.usdRate
            } else {
                self.presentAlert()
            }
        }
    }
    
    @IBAction func convert(_ sender: Any) {
        if let amount = Float(amountMoney.text!) {
            print(amount)
            let usdOrEurIndex = usdOrEur.selectedSegmentIndex
            if usdOrEurIndex == 0 {
                resultConversion.text = "\(amount) dollar in euro:"
                LabelResult.text =  "\(amount/usdRate) €"
            } else {
                resultConversion.text = "\(amount) euro in dollar:"
                LabelResult.text =  "\(amount * usdRate) $"

            }
        }
      
    }
    
    func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The network requests failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    @IBAction func dismissKeybord(_ sender: UITapGestureRecognizer) {
        amountMoney.resignFirstResponder()
    }
    
}
