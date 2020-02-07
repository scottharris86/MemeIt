//
//  AlertSearchTableViewCell.swift
//  MemeIt
//
//  Created by Chris Gonzales on 2/4/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class AlertSearchTableViewCell: UITableViewCell {
    lazy var alertBackView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        return view
    }()
    
    lazy var alertLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 40, y: 0, width: self.frame.width - 20, height: 50))
        return label
    }()
    
    lazy var alertImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 20, height: 20))
        return imageView
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(alertBackView)
        alertBackView.addSubview(alertLabel)
        alertBackView.addSubview(alertImageView)
    }
}
