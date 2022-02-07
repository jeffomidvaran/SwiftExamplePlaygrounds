//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .blue
        self.view = view
        
        // ############################################
        // ######### Add Label With Frame #############
        // ############################################
        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Added With A Frame!!!"
        label.textColor = .white
        view.addSubview(label)
        
        // ##################################################
        // ######### Add Label With Constraints #############
        // ##################################################
        let label2 = UILabel()
        view.addSubview(label2)
        label2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label2.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            label2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
        ])
        label2.text = "Added with Constraints!!!"
        label2.textColor = .white
        
        // #######################################
        // ######### Add Shape ###################
        // #######################################
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100, y: 100),
                                      radius: CGFloat(20),
                                      startAngle: CGFloat(0),
                                      endAngle: CGFloat(Double.pi * 2),
                                      clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 3.0
        view.layer.addSublayer(shapeLayer)
        
    }
}


// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
