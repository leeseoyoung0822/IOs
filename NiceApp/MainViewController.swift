//
//  ViewController.swift
//  NiceApp
//
//  Created by 이서영 on 2023/03/18.
//

import UIKit
import Lottie

class MainViewController : UIViewController {
    
    @IBOutlet var UIView: UIView!
   
    //뷰가 생성되었을때
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = LottieAnimationView(name : "139849-in-tempus")
        animationView.frame = CGRect(x:0, y:0, width : 400, height: 400)
        animationView.contentMode = .scaleAspectFill //크기에 맞게 이미지 확대
        
        view.backgroundColor = .black
        view.addSubview(animationView)
        animationView.center = view.center
        
    
        //에니메이션 실행
        animationView.play()
        animationView.loopMode = .loop
       // animationView.pause()
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            animationView.stop()
        }
        
        
    }

}

