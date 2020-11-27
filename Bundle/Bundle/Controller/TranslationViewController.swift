//
//  TraductionViewController.swift
//  Bundle
//
//  Created by BOUHADEB Yacoub on 03/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

import UIKit

class TraductionViewController: UIViewController {

    
    // MARK: - OUTLETS
    
    // The text to translate
    @IBOutlet weak var sourceText: UITextView!
    // Choose between the translation in french an english
    @IBOutlet weak var chooseLanguage: UISegmentedControl!
    // The text translated
    @IBOutlet weak var translatedText: UITextView!
    // The button to translate
    @IBOutlet weak var translateButton: UIButton!
    // The activity indicator that show us if something is going on
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    // MARK: - BUTTONS ACTIONS //
    
    @IBAction func clearButton(_ sender: Any) {
        sourceText.text = ""
        translatedText.text = ""
    }
    
    @IBAction func translateText(_ sender: Any) {
        let enOrfr = chooseLanguage.selectedSegmentIndex
        if let TextToTranslate = sourceText.text {
            if enOrfr == 1 {
                translate(text: TextToTranslate, tar: "en", src: "fr")
            } else {
                translate(text: TextToTranslate, tar: "fr", src: "en")
            }
        } else {
            presentAlert()

        }
    }
    
    // This function do the translation
    func translate(text: String, tar: String, src: String) {
        toggleActivity(shown: true)
        TranslationService.shared.getTranslation(text: text, tar: tar, src: src) { (success, translated) in
            self.toggleActivity(shown: false)
            if success, let translated = translated {
                self.update(translated: translated)
            } else {
                self.presentAlert()
            }
        }
    }
    
    // This function show us if the activity indicator is shown or not
    private func toggleActivity(shown: Bool) {
        translateButton.isHidden = shown
        activityIndicator.isHidden = !shown
        sourceText.resignFirstResponder()
        
    }
    
    func update(translated: Translated) {
       translatedText.text = translated.translatedText
    }
    
    @IBAction func dissmissKeybord(_ sender: UITapGestureRecognizer) {
        sourceText.resignFirstResponder()
    }
    
    // This function is called when we have an error
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The translation failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

