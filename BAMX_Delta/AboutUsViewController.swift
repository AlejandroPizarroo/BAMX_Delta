//
//  AboutUsViewController.swift
//  BAMX_Delta
//
//  Created by Alejandro Pizarro on 14/11/22.
//

import youtube_ios_player_helper
import Foundation
import UIKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet var playerView : YTPlayerView!

    @IBOutlet weak var aboutUs: UIButton!
    @IBOutlet weak var campaigns: UIButton!
    @IBOutlet weak var donations: UIButton!
    @IBOutlet weak var myAccount: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.load(withVideoId: "p38WgakuYDo")
    }


}
