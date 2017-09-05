//
//  ViewController1.swift
//  Swipeable Card
//
//  Created by Nitin Bhatia on 04/09/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import UIKit

class ViewController1: UIViewController,DraggableViewDelegate {
    
    var exampleCardLabels: [String]!
    var allCards: [DraggableView]!
    
    let MAX_BUFFER_SIZE = 2
    let CARD_HEIGHT: CGFloat = 386
    let CARD_WIDTH: CGFloat = 290
    
    var cardsLoadedIndex: Int!
    var loadedCards: [DraggableView]!
    var menuButton: UIButton!
    var messageButton: UIButton!
    var checkButton: UIButton!
    var xButton: UIButton!
    
    var currentCardIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        exampleCardLabels = ["first", "second", "third", "fourth", "last"]
        allCards = []
        loadedCards = []
        cardsLoadedIndex = 0
        self.loadCards()

    }
    
   


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createDraggableViewWithDataAtIndex(_ index: NSInteger) -> DraggableView {
        
    
        let view =   Bundle.main.loadNibNamed("CardView", owner: self, options: nil)?[0] as! DraggableView
        let frame = CGRect(x: (self.view.frame.size.width - CARD_WIDTH)/2, y: (self.view.frame.size.height - CARD_HEIGHT)/2, width: CARD_WIDTH, height: CARD_HEIGHT)
        
      
        view.frame = frame
        view.containerView.frame = frame
        view.lbltitle.text = exampleCardLabels[index]
        view.delegate = self
        view.overlayView = OverlayView(frame: CGRect(x: 0, y: 0, width: CARD_WIDTH, height: CARD_HEIGHT))
        view.overlayView.alpha = 0
//        view.overlayView.imageView.frame = CGRect(x: CARD_WIDTH/, y: (CARD_HEIGHT/2)/2, width: 100, height: 100)
        view.overlayView.backgroundColor = UIColor.red
        view.addSubview(view.overlayView)
        view.btnCancel.addTarget(self, action: #selector(swipeLeft), for: .touchUpInside)
        view.btnDone.addTarget(self, action: #selector(swipeRight), for: .touchUpInside)

    
        return view
    }
    
    
    func loadCards() -> Void {
        if exampleCardLabels.count > 0 {
            let numLoadedCardsCap = exampleCardLabels.count > MAX_BUFFER_SIZE ? MAX_BUFFER_SIZE : exampleCardLabels.count
            for i in 0 ..< exampleCardLabels.count {
                let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(i)
                allCards.append(newCard)
                if i < numLoadedCardsCap {
                    loadedCards.append(newCard)
                }
            }
            
            for i in 0 ..< loadedCards.count {
                if i > 0 {
                    self.view.insertSubview(loadedCards[i], belowSubview: loadedCards[i - 1])
                } else {
                    self.view.addSubview(loadedCards[i])
                }
                cardsLoadedIndex = cardsLoadedIndex + 1
            }
        }
    }

    
    func cardSwipedLeft(_ card: UIView) -> Void {
        loadedCards.remove(at: 0)
        print("discarded")
print("Current Card Index is \(currentCardIndex) and at that index label value is \(exampleCardLabels[currentCardIndex])")
        currentCardIndex += 1
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            self.view.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])

        }
    }
    
    func cardSwipedRight(_ card: UIView) -> Void {
        loadedCards.remove(at: 0)
        print("Current Card Index is \(currentCardIndex) and at that index label value is \(exampleCardLabels[currentCardIndex])")
        currentCardIndex += 1
        print("accepted")
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            self.view.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
            
        }
    }
    
    func swipeRight() -> Void {
        print("accepted")
        if loadedCards.count <= 0 {
            return
        }
        let dragView: DraggableView = loadedCards[0]
   //     dragView.overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeRight)
        UIView.animate(withDuration: 0.10, animations: {
            () -> Void in
           dragView.overlayView.alpha = 1
        })
        dragView.rightClickAction()
    }
    
    func swipeLeft() -> Void {
        print("cancel")
        if loadedCards.count <= 0 {
            return
        }
        let dragView: DraggableView = loadedCards[0]
      //  dragView.overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeLeft)
        UIView.animate(withDuration: 10.0, animations: {
            () -> Void in
           dragView.overlayView.alpha = 1
        })
        dragView.leftClickAction()
    }
    
    
    
    
    

}
