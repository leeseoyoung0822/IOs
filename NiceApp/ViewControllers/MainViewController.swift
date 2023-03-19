//
//  ViewController.swift
//  NiceApp
//
//  Created by 이서영 on 2023/03/18.
//

import UIKit
import Lottie

class MainViewController : UIViewController {
    
    let titleLable:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "메인화면"
        label.font = UIFont.boldSystemFont(ofSize: 70)
        
        return label
    }()
    
    let animationView : AnimationView = {
        
        let animView = AnimationView(name : "139849-in-tempus")
        animView.frame = CGRect(x:0, y:0, width : 400, height: 400)
        animView.contentMode = .scaleAspectFill //크기에 맞게 이미지 확대
        return animView
    }()

    //뷰가 생성되었을때
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .black
        view.addSubview(animationView)
        animationView.center = view.center
        
    
        //에니메이션 실행
        animationView.play{ (finish) in
            //
            print("애니메이션이 끝났다")
            
            self.view.backgroundColor = .white
            self.animationView.removeFromSuperview() //애니매이션 뷰의 상위 부모가 뷰. 뷰가 애니메이션 뷰를 품음. 슈퍼 뷰는 뷰. 뷰로 부터 애니메이션 제거.
            
            
            
            self.view.addSubview(titleLable)
            
            self.titleLable.translatesAutoresizingMaskIntoConstraints = false
            self.titleLable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            self.titleLable.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
        
        
                
    }


}

