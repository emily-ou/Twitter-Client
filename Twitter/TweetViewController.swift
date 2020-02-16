//
//  TweetViewController.swift
//  Twitter
//
//  Created by Emily Ou on 2/10/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var charCount: UILabel!
    @IBOutlet weak var tweetButton2: UIBarButtonItem!
    
    @IBAction func cancelButton(_ sender: Any) {
        // Cancels the draft and dismiss screen
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweetButton(_ sender: Any) {
        // If text box is not empty
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (Error) in
                print(Error.localizedDescription)
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetTextView.delegate = self
        
        // Border around text view
        tweetTextView.layer.borderWidth = 1
        tweetTextView.layer.borderColor = UIColor.black.cgColor
        // Rounded corners
        tweetTextView.clipsToBounds = true
        tweetTextView.layer.cornerRadius = 10.0
        
        // Character limit
        charCount.text = "280"
    }
    
    // Clears on editing
    func textViewDidBeginEditing(_ textView: UITextView) {
        tweetTextView.text = ""
    }

    // Character count
    func getCharacterCountRemaining() {
        let charLimit = 280
        let charsCount = tweetTextView.text.count
        let charLeft = charLimit - charsCount
        
        if charLeft <= 10 {
            tweetTextView.textColor = UIColor.red
        } else {
            tweetTextView.textColor = UIColor.black
        }
        
        if charLeft < 0 {
            tweetButton2.isEnabled = false
        } else {
             tweetButton2.isEnabled = true
        }
        
        charCount.text = String(charLeft)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        getCharacterCountRemaining()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
