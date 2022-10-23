//
//  DetailsVC.swift
//  Lesson 3
//
//  Created by Alexey Efimov on 02.05.2018.
//  Copyright © 2018 swiftbook.ru. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var trackTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: trackTitle)
        label.text = trackTitle
        label.numberOfLines = 0
        
    }

}
