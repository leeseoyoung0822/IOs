//
//  AlarmViewController.swift
//  ThreadTest
//
//  Created by 이서영 on 2023/05/11.
//

import UIKit

class AlarmViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    
//    var alarmData: [AlarmData]{
//        get {
//            return sortAlarmData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        

        // Do any additional setup after loading the view.
    }
    
    func setupNavigationBar(){
        self.title = "알람"
        
        let leftBarButton = UIBarButtonItem(title: "편집", style: .plain, target: self, action:#selector(leftBarButtonTapped))
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonTapped))
        
        leftBarButton.tintColor = .systemOrange
        rightBarButton.tintColor = .systemOrange
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func leftBarButtonTapped(){
        setEditing(!TableView.isEditing, animated: true)
    }
    
    @objc func rightBarButtonTapped(){
//        let _ = storyboard?.instantiateViewController(withIdentifier: "AlarmGenerateNavigationController") as! AlarmGenerateNavigationController
//
//        // navigationVC에 데이터 전달, first 뷰 컨트롤러 세팅 완료 후 데이터 전달하는 로직 추가해야됨.
//
//        self.performSegue(withIdentifier: "AlarmViewController", sender: self)
    }

    
}
