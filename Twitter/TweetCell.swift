//
//  TweetCell.swift
//  Twitter
//
//  Created by Emily Ou on 2/6/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var liked:Bool = false
    var tweetId:Int = -1
    var retweeted:Bool = false
    
    // like button is triggered
    @IBAction func likeTweet(_ sender: Any) {
        let toBeLiked = !liked
        
        if toBeLiked {
            TwitterAPICaller.client?.likeTweet(tweetId: tweetId, success: {
                self.setLike(true)
            }, failure: { (Error) in
                print("Like Error: \(Error.localizedDescription)")
            })
        } else {
            TwitterAPICaller.client?.unlikeTweet(tweetId: tweetId, success: {
                self.setLike(false)
            }, failure: { (Error) in
                print("Unlike Error: \(Error.localizedDescription)")
            })
        }
    }
    
    // retweet button is triggered
    @IBAction func retweetTweet(_ sender: Any) {
        let toBeRetweeted = !retweeted
        
        if toBeRetweeted {
            TwitterAPICaller.client?.retweetTweet(tweetId: tweetId, success: {
                self.setRetweeted(true)
            }, failure: { (Error) in
                print("Retweet Error: \(Error.localizedDescription)")
            })
        } else {
            TwitterAPICaller.client?.undoRetweetTweet(tweetId: tweetId, success: {
                self.setRetweeted(false)
            }, failure: { (Error) in
                print("Undo Retweet Error: \(Error.localizedDescription)")
            })
        }
    }
    
    // Set images for if when the tweet is liked
    func setLike(_ isLiked: Bool) {
        liked = isLiked
        if liked {
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    // Set images for if when the tweet is retweeted
    func setRetweeted(_ isRetweeted: Bool) {
        retweeted = isRetweeted
        if isRetweeted {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            //retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            //retweetButton.isEnabled = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
