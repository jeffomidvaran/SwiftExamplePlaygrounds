//
//  ViewController.swift
//  BoundsFrames
//
//  Created by jeff Omidvaran on 1/19/22.
//

import UIKit

class ViewController: UIViewController {

    /*
        BOUNDS
             describe location and size in views own coordinate system
             location and size remain the same when rotating
        FRAME
            where the view is situated in the superview
            on rotation the FRAME SIZE, and X,Y will change
     
    */
    @IBOutlet weak var orangeView: UIView!
    private func printAll() {
        print("=========== FRAME COORDS ==============")
        print("X : ", self.orangeView.frame.origin.x)
        print("Y : ", self.orangeView.frame.origin.y)
        print("width : ", self.orangeView.frame.size.width)
        print("height : ", self.orangeView.frame.size.height)
        print("=========== BOUNDS COORDS =============")
        print("X : ", self.orangeView.bounds.origin.x)
        print("Y : ", self.orangeView.bounds.origin.y)
        print("width : ", self.orangeView.bounds.size.width)
        print("height : ", self.orangeView.bounds.size.height)
        print("#######################################\n")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printAll()
        let testView = UIView(frame: CGRect(x: self.orangeView.frame.origin.x,
                                            y: self.orangeView.frame.origin.y,
                                            width: self.orangeView.frame.size.width,
                                            height: self.orangeView.frame.size.height))
        testView.layer.borderColor = UIColor.red.cgColor
        testView.layer.borderWidth = 2
        self.view.addSubview(testView)
        
        
        self.orangeView.transform = CGAffineTransform(rotationAngle: 5)
        printAll()
        
    }


}

