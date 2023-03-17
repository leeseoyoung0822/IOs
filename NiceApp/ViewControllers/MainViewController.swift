//
//  ViewController.swift
//  NiceApp
//
//  Created by 이서영 on 2023/03/18.
//

import UIKit

class MainViewController: UIViewController {
    
    let titleLable:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "메인화면"
        label.font = UIFont.boldSystemFont(ofSize: 70)
        
        return label
    }()

    //뷰가 생성되었을때
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(titleLable)
        
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLable.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }


}

