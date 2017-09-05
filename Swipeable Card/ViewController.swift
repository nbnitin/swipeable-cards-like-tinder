//
//  ViewController.swift
//  Swipeable Card
//
//  Created by Nitin Bhatia on 04/09/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cardView : UIView!
    var panGestureRecognizer:UIPanGestureRecognizer!
    var originalPoint: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized(gestureRecognizer:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
        self.cardView = createCard()
        self.view.addSubview(cardView)
        self.cardView.insertSubview(createCard(), belowSubview: self.cardView)

    }
    
    override func viewWillLayoutSubviews() {
        cardView.center = self.view.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func panGestureRecognized(gestureRecognizer: UIPanGestureRecognizer) {
        let xDistance = gestureRecognizer.translation(in: self.view).x
        let yDistance = gestureRecognizer.translation(in: self.view).y
        
        switch gestureRecognizer.state {
        case .began:
            self.originalPoint = self.view.center
            break
            
        case .changed:
            updateCardViewWithDistances(xDistance:xDistance, yDistance)
            break
            
        case .ended:
            resetViewPositionAndTransformations()
            break
            
        default:
            break
        }
    }
    
    func resetViewPositionAndTransformations() {
        UIView.animate(withDuration: 0.2, animations: {
            self.cardView.center = self.originalPoint;
            self.cardView.transform = CGAffineTransform(rotationAngle: 0);
        })
    }

    
    func updateCardViewWithDistances(xDistance:CGFloat, _ yDistance:CGFloat) {
        let rotationStrength = min(xDistance / 320, 1)
        let fullCircle = (CGFloat)(2*M_PI)
        
        let rotationAngle:CGFloat = fullCircle * rotationStrength / 16
        let scaleStrength:CGFloat = (CGFloat) (1 - fabsf(Float(rotationStrength)) / 2)
        let scale = max(scaleStrength, 0.93)
        
        let newX = self.originalPoint.x + xDistance
        let newY = self.originalPoint.y + yDistance
        
        let transform = CGAffineTransform(rotationAngle: rotationAngle)
        let scaleTransform = transform.scaledBy(x: scale, y: scale)
        
        self.cardView.center = CGPoint(x:newX, y:newY)
        self.cardView.transform = scaleTransform
    }
    
    
    func createCard() -> UIView{
        let width = self.view.frame.width * 0.8
        let height = self.view.frame.height * 0.8
        let rect = CGRect(x:0, y:0, width:width, height:height)
        
        let tempCardView = UIView(frame: rect)
        tempCardView.backgroundColor = UIColor.blue
        tempCardView.layer.cornerRadius = 8
        tempCardView.layer.shadowOffset = CGSize(width: 7, height: 7)
        tempCardView.layer.shadowRadius = 5
        tempCardView.layer.shadowOpacity = 0.5
        return tempCardView
    }
    
    


}

