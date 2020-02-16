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
    
    @IBAction func likeTweet(_ sender: Any) {
        // like button is triggered
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
    
    @IBAction func retweetTweet(_ sender: Any) {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
