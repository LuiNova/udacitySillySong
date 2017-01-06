//
//  ViewController.swift
//  Silly Song
//
//  Created by Torres, Luis on 12/27/16.
//  Copyright © 2016 Torres, Luis. All rights reserved.
//

import UIKit

// join an array of strings into a single template string:
let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

// Silly lirycs song
func shortNameFromName(name myString: String) -> String {
    
    let lowercaseName = myString.lowercased()
    let vowelSet = CharacterSet(charactersIn: "aeiou")
    var myString = myString.lowercased()
    
    for character in lowercaseName.unicodeScalars {
        if vowelSet.contains(UnicodeScalar(character.value)!) {
            return myString;
        } else {
            myString.remove(at: myString.startIndex)
        }
    }
    
    return myString
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    
    let shortName = shortNameFromName(name: fullName)
    
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics
}

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        self.nameField.text = ""
        self.lyricsView.text = ""
        print(self.lyricsView.text)
    }

    @IBAction func displayLyrics(_ sender: Any) {
        if (!(self.nameField.text?.isEmpty)!) {
            self.lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: self.nameField.text!)
            print(self.lyricsView.text)
        }
    }
    
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

