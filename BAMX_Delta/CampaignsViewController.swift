//
//  CampaignsViewController.swift
//  BAMX_Delta
//
//  Created by Alejandro Pizarro on 23/11/22.
//

import Foundation
import UIKit

class CampaignsViewController: UIViewController {

    // MARK: Botones
    @IBOutlet weak var donateUniendoManos: UIButton!
    @IBOutlet weak var volunteerAlimenta: UIButton!
    @IBOutlet weak var donateComerEnFamilia: UIButton!
    @IBOutlet weak var volunteerAlRescate: UIButton!
    
    
    override func viewDidLoad() {
        donateUniendoManos.layer.cornerRadius = 10
        volunteerAlimenta.layer.cornerRadius = 10
        donateComerEnFamilia.layer.cornerRadius = 10
        volunteerAlRescate.layer.cornerRadius = 10
        

        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
