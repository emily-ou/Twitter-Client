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
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // Clears on editing
        tweetTextView.text = ""
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
