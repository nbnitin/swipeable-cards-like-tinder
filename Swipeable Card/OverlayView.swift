//
//  OverlayView.swift
//  TinderSwipeCardsSwift
//
//  Created by Nitin Bhatia on 04/09/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved..
//

import Foundation
import UIKit

enum GGOverlayViewMode {
    case ggOverlayViewModeLeft
    case ggOverlayViewModeRight
}

class OverlayView: UIView{
    var _mode: GGOverlayViewMode! = GGOverlayViewMode.ggOverlayViewModeLeft
    var imageView: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        imageView = UIImageView(image: UIImage(named: "noButton"))
       // self.addSubview(imageView)
    }
    
    func setMode(_ mode: GGOverlayViewMode) -> Void {
        if _mode == mode {
            return
        }
        _mode = mode
        
        if _mode == GGOverlayViewMode.ggOverlayViewModeLeft {
            imageView.image = UIImage(named: "noButton")
        } else {
            imageView.image = UIImage(named: "yesButton")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       // imageView.frame = CGRect(x: 100, y: 80, width: 100, height: 100)
    }
}
