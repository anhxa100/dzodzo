//
//  DashBoardVC.swift
//  dzodzo
//
//  Created by anhxa100 on 4/18/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController, UIScrollViewDelegate {
    


    @IBOutlet weak var scrollView: UIScrollView!
    
    var leftMenuWidth = 400

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DispatchQueue.main.async() {
            self.closeMenu(animated: false)
        }
        
//         Tab bar controller's child pages have a top-left button toggles the menu
        NotificationCenter.default.addObserver(self, selector: #selector(toggleMenu), name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(closeMenuViaNotification), name: NSNotification.Name(rawValue: "closeMenuViaNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)

        
        // LeftMenu sends openModalWindow
        NotificationCenter.default.addObserver(self, selector: #selector(ContainerVC.openModalWindow), name: NSNotification.Name(rawValue: "openModalWindow"), object: nil)
        // Do any additional setup after loading the view.
    }
    
   
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func openModalWindow() {
        performSegue(withIdentifier: "openModalWindow", sender: nil)
    }
    
    @objc func toggleMenu() {
        
        scrollView.contentOffset.x == 0  ? closeMenu() : openMenu()
        
    }

    @objc func closeMenuViaNotification(){
        closeMenu()
    }
    
    @objc func rotated(){
        if UIDeviceOrientation.landscapeRight.isLandscape, UIDeviceOrientation.landscapeLeft.isLandscape {
            DispatchQueue.main.async() {
                print("closing menu on rotate")
                self.closeMenu()
            }
        }
    }
    
//     Use scrollview content offset-x to slide the menu.
    func closeMenu(animated:Bool = true){
        print("closing menu")
        scrollView.setContentOffset(CGPoint(x: leftMenuWidth, y: 0), animated: animated)
        
    } 
    
    // Open is the natural state of the menu because of how the storyboard is setup.
    func openMenu(){
        print("opening menu")
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    
}

extension DashBoardVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollView.contentOffset.x:: \(scrollView.contentOffset.x)")
    }


    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.isPagingEnabled = true
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.isPagingEnabled = false
    }

}
