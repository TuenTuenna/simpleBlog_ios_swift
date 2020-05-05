//
//  PostTableViewCell.swift
//  SimpleBlog
//
//  Created by Jeff Jeong on 2020/04/16.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var body: UILabel!
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

//        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
//        bounds = bounds.inset(by: padding)
        
    }
    
}
