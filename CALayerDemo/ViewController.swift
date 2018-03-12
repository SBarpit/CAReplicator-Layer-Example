//
//  ViewController.swift
//  CircularView
//
//  Created by Appinventiv on 08/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    let replicatorLayer = CAReplicatorLayer()
    var toggle: Bool = true
    var x : CGFloat = 0
    var y : CGFloat = 0
    var scrollView:UIScrollView!
    
    @IBOutlet weak var someView: UIView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayer()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpLayer() {
        let numberOfItems = 40
        replicatorLayer.instanceCount = numberOfItems
        replicatorLayer.instanceColor = UIColor.white.cgColor
        replicatorLayer.backgroundColor = UIColor.clear.cgColor
        let angle = Float(Double.pi * 2.0) / Float(numberOfItems)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
        let instanceLayer = CALayer()
        let layerWidth: CGFloat = 60
        let midX = view.bounds.midX
        instanceLayer.frame = CGRect(x: self.x, y: self.y, width: layerWidth, height: layerWidth)
        let circum = CGFloat(numberOfItems)*layerWidth
        let radius = circum/(2*3.14)
        let dia = 2.0*radius
        self.x = someView.frame.origin.x
        self.y = someView.frame.origin.y
        someView.frame = CGRect(x: x, y: y, width: dia, height: dia)
        replicatorLayer.frame = someView.bounds
        scrollView = UIScrollView(frame: view.bounds)
        let width = replicatorLayer.bounds.width + 100
        let height = replicatorLayer.bounds.height + 100
        scrollView.contentSize = CGSize(width: width, height: height)
        scrollView.layer.backgroundColor = UIColor.blue.cgColor
        someView.layer.backgroundColor = UIColor.blue.cgColor
        someView.layer.addSublayer(replicatorLayer)
        scrollView.isScrollEnabled = true
        scrollView.addSubview(someView)
        view.addSubview(scrollView)
        
        
        instanceLayer.cornerRadius = layerWidth/2
        instanceLayer.backgroundColor = UIColor.gray.cgColor
        instanceLayer.opacity = 0.6
        
        let imageView = UIImageView()
        imageView.frame = CGRect(x: midX-55, y: 27.0, width: layerWidth, height: layerWidth)
        imageView.image = UIImage(named: "1")
        let image = imageView.image?.cgImage
        instanceLayer.contents = image
        instanceLayer.masksToBounds = true
        replicatorLayer.addSublayer(instanceLayer)
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = 10
        rotateAnimation.repeatCount=Float.infinity
        self.replicatorLayer.add(rotateAnimation, forKey: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        toggle = !toggle
        if toggle{
            replicatorLayer.shadowOpacity = 0.6
            replicatorLayer.shadowRadius = 7.0
            replicatorLayer.shadowOffset = .zero
            
        }
        else{
            replicatorLayer.shadowOpacity = 0.0
            replicatorLayer.shadowRadius = 0.0
        }
    }
}
