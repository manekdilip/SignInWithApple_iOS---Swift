//
//  NextVC.swift
//  SignInWithAppleID_Demo
//
//  Created by Devubha Manek on 27/02/20.
//  Copyright © 2020 Devubha Manek. All rights reserved.
//

import UIKit

//MARK: NextVC
class NextVC: UIViewController {
    
    //MARK: Variable Declaraton
    var strUid = ""
    var strEmail = ""
    
    //MARK: IBOutlet Declaration
    @IBOutlet weak var lblUid: UILabel?
    @IBOutlet weak var lblEmail: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.lblEmail?.text = self.strEmail
        self.lblUid?.text = self.strUid
        // Do any additional setup after loading the view.
    }
    
   
}

//MARK: IBAction Declaration
extension NextVC {
    
    //Tapped On Back
    @IBAction func tappedOnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil
        )
    }
    
}
