//
//  AlarmTableViewCell.swift
//  ThreadTest
//
//  Created by 이서영 on 2023/05/11.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
//    var alarmData: AlarmData?{
//        didSet{
//            setupUI()
//        }
//    }

    @IBOutlet weak var Switch: UISwitch!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var NoonLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
//        guard let alarmData = alarmData else {
//            print("?")
//            return
//        }
        
        // 시간 숫자 세팅
//        guard let time = alarmData.time else {
//            return
//        }
//        TimeLabel.text = "\(setupTimeString(time: time).0)"
//
//        // 오전오후 세팅
//        NoonLabel.text = setupTimeString(time: time).1
        
        //DescriptionLabel.text = alarmData.label
        //Switch.isOn = alarmData.isOn
        
        Switch.backgroundColor = .darkGray
        Switch.layer.cornerRadius = Switch.bounds.size.height / 2

        
//        if(alarmData.isOn){
//            TimeLabel.textColor = .white
//            NoonLabel.textColor = .white
//            DescriptionLabel.textColor = .white
//        }else{
//            TimeLabel.textColor = .lightGray
//            NoonLabel.textColor = .lightGray
//            DescriptionLabel.textColor = .lightGray
//        }
    }
    
    func setupTimeString(time: Date) -> (String, String){
        var isNoon = false
        
        // 코어데이터에 저장된 UTC를 KST로 변환하는 로직
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:mm"
        
        // timeString 반환 로직
        var timeString = dateFormatter.string(from: time)
        
        if(timeString.first == "0"){
            timeString.remove(at: timeString.startIndex)
        }
        
        var timeArray = timeString.split(separator: ":").map { str in
            String(str)
        }
        
        if(Int(timeArray[0])! > 12){
            timeArray[0] = String(Int(timeArray[0])! - 12)
            isNoon = true
        }
        
        
        
        return (timeArray.joined(separator: ":"), isNoon ? "오후" : "오전")
    }

    @IBAction func switchButtonTapped(_ sender: UISwitch) {
        if(Switch.isOn){
            TimeLabel.textColor = .white
            NoonLabel.textColor = .white
            DescriptionLabel.textColor = .white
        }else{
            TimeLabel.textColor = .lightGray
            NoonLabel.textColor = .lightGray
            DescriptionLabel.textColor = .lightGray
            
        }
    }

}
