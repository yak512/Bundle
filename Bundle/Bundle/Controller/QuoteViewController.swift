//
//  QuoteViewController.swift
//  Bundle
//
//  Created by BOUHADEB Yacoub on 03/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

import UIKit

class QuoteViewController: UIViewController {

    @IBOutlet weak var quoteText: UITextView!
    @IBOutlet weak var newQuoteButton: UIButton!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func newQuote(_ sender: Any) {
        toggleActivity(shown: true)
        
        QuoteService.shared.getQuote { (success, quote) in
            print("in")
            self.toggleActivity(shown: false)
            if success, let quote = quote {
                self.update(quote: quote)
            } else {
                self.presentAlert()
            }
        }
    }
    
    private func toggleActivity(shown: Bool) {
        newQuoteButton.isHidden = shown
        activityIndicator.isHidden = !shown
        
    }
    
    private func update(quote: Quote) {
        quoteText.text = quote.text
        author.text = quote.author
    }
    
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The quote loading failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
