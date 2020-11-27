//
//  QuoteViewController.swift
//  Bundle
//
//  Created by BOUHADEB Yacoub on 03/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

import UIKit

class QuoteViewController: UIViewController {

    // MARK: - OUTLETS

    // The quote
    @IBOutlet weak var quoteText: UITextView!
    // The button that generate new quote
    @IBOutlet weak var newQuoteButton: UIButton!
    // The author of the quote
    @IBOutlet weak var author: UILabel!
    // Activuty indicator, show us if something is going on
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - BUTTONS ACTIONS //

    @IBAction func newQuote(_ sender: Any) {
        toggleActivity(shown: true)
        
        QuoteService.shared.getQuote { (success, quote) in
            self.toggleActivity(shown: false)
            if success, let quote = quote {
                self.update(quote: quote)
            } else {
                self.presentAlert()
            }
        }
    }
    
    // MARK: - FUNCTINS
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
