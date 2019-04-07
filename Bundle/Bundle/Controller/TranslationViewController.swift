//
//  TraductionViewController.swift
//  Bundle
//
//  Created by BOUHADEB Yacoub on 03/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

import UIKit

class TraductionViewController: UIViewController {

    @IBOutlet weak var sourceText: UITextView!
    @IBOutlet weak var chooseLanguage: UISegmentedControl!
    @IBOutlet weak var translatedText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // TranslationService().getTranslation(text: "i want you so bad", tar: "fr", src: "en")
       // print("out will apera")
    }
    
    @IBAction func clearButton(_ sender: Any) {
        sourceText.text = ""
        translatedText.text = ""
    }
    @IBAction func translateText(_ sender: Any) {
        let enOrfr = chooseLanguage.selectedSegmentIndex
        if let TextToTranslate = sourceText.text {
            if enOrfr == 0 {
                translate(text: TextToTranslate, tar: "en", src: "fr")
            } else {
                translate(text: TextToTranslate, tar: "fr", src: "en")
            }
        } else {
            print("error")

        }
    }
    
    func translate(text: String, tar: String, src: String) {
        TranslationService.shared.getTranslation(text: text, tar: tar, src: src) { (success, translated) in
            if success, let translated = translated {
                self.update(translated: translated)
            } else {
                print("error")
            }
        }
    }
    
    func update(translated: Translated) {
       translatedText.text = translated.translatedText
    }
    
    @IBAction func dissmissKeybord(_ sender: UITapGestureRecognizer) {
        sourceText.resignFirstResponder()
    }
    
}

