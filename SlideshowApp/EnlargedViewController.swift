//
//  EnlargedViewController.swift
//  SlideshowApp
//
//  Created by kazuto masuda on 2020/12/01.
//  Copyright © 2020 kmzstdbnsh. All rights reserved.
//

import UIKit

class EnlargedViewController: UIViewController {

    @IBOutlet weak var Base: UIView!
    @IBOutlet weak var ImageArea: UIImageView!
    @IBOutlet weak var BackButton: UIView!
    
    
    var baseColor : UIColor?
    var imageName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Base.backgroundColor = baseColor
        BackButton.backgroundColor = baseColor
        ImageArea.image = UIImage(named: imageName)
        // Do any additional setup after loading the view.
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
