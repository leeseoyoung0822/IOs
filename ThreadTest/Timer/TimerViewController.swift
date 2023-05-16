//
//  TimerViewController.swift
//  ThreadTest
//
//  Created by 이서영 on 2023/05/15.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timerView: UIView!
   
    @IBOutlet weak var timerInnerView: UIView!
    
    
    @IBOutlet weak var timePicker: UIPickerView!
   
    var timer = Timer()
    
    // date는 DateFormatter 인스턴스입니다. 이 인스턴스는 시간과 날짜를 표시하는 데 사용됩니다.
    let date: DateFormatter = {
       let df = DateFormatter()
       df.locale = Locale(identifier: "ko_KR")
       df.timeZone = TimeZone(abbreviation: "KST")
       df.dateFormat = "a HH:mm"
       return df
   }()
    
    // 타이머가 켜져 있는지 확인하는 변수입니다.
    var isOn: Bool = false {
        didSet {
            if (isOn) {
                // 타이머가 켜져있는 경우 UI를 업데이트합니다.
                cancelButton.setTitleColor(.white, for: .normal)
                startButton.setTitle("일시 정지", for: .normal)
                startButton.setTitleColor(UIColor(named: "pauseTextColor"), for: .normal)
                startButton.backgroundColor = UIColor(named: "pauseColor")
                timePicker.isHidden = true
                timerView.isHidden = false
                
                setupTimerUI()
            } else {
                resetButton.setTitleColor(.gray, for: .normal)
            }
        }
    }
    
    // 타이머가 일시 중지된 상태인지 확인하는 변수입니다.
    var paused: Bool = false {
        didSet {
            if (paused) {
                // 타이머가 일시 중지된 경우 UI를 업데이트합니다.
                startButton.backgroundColor = UIColor(named: "startColor")
                startButton.setTitleColor(UIColor(named: "startTextColor"), for: .normal)
                startButton.setTitle("재개", for: .normal)
            } else {
                startButton.backgroundColor = UIColor(named: "pauseColor")
                startButton.setTitleColor(UIColor(named: "pauseTextColor"), for: .normal)
                startButton.setTitle("일시 정지", for: .normal)
            }
        }
    }
    
    
    // time은 시간을 설정하는 데 사용되는 2차원 배열입니다.
    var time: [[Int]] {
        get{
            return setTime()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 초기 UI 설정을 수행합니다.
        setupUI()
        setupController()
        setupPickerLabel()
    }
    
    // 시간 배열을 설정하는 메서드입니다.
    func setTime() -> [[Int]] {
        var hour: [Int] = []
        var minutesecond: [Int] = []

        // 24시간을 시간 배열에 추가합니다.
        for i in 0..<24 {
            hour.append(i)
        }

        // 60분을 분 배열에 추가
        for i in 0..<60 {
            minutesecond.append(i)
        }

        return [hour, minutesecond, minutesecond]
    }
    
    // 초기 UI 설정
     func setupUI() {
         timerView.isHidden = true
         timePicker.setValue(UIColor.white, forKey: "textcolor")
         
         startButton.layer.cornerRadius = 40
         resetButton.layer.cornerRadius = 40
         
         resetButton.setTitle("취소", for: .normal)
         resetButton.backgroundColor = UIColor(named: "ModalColor")
         resetButton.setTitleColor(.gray, for: .normal)

         self.view.backgroundColor = UIColor(named: "backgroundColor")

         timePicker.backgroundColor = UIColor(named: "backgroundColor")
     }
    
    func setupPickerLabel(){
        let hourLabel = UILabel()
        hourLabel.text = "시간"
        
        let minuteLabel = UILabel()
        minuteLabel.text = "분"
        
        let secondLabel = UILabel()
        secondLabel.text = "초"
        
        timePicker.setPickerLabels(labels: [0:hourLabel, 1: minuteLabel, 2: secondLabel], containedView: self.view)
        
    }
    
    // 컨트롤러 설정을 수행
    func setupController() {
        timePicker.delegate = self
        timePicker.dataSource = self
    }
    
    // 피커뷰 레이블 설정을 수행하는 메서드입니다.
    func setupPickerLabel() {
        let hourLabel = UILabel(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 15, width: 20, height: 30))
        hourLabel.text = "시"
        hourLabel.textColor = UIColor(named: "textColor")
        self.view.addSubview(hourLabel)

        let minuteLabel = UILabel(frame: CGRect(x: self.view.frame.width / 2 + 30, y: self.view.frame.height / 2 - 15, width: 20, height: 30))
        minuteLabel.text = "분"
        minuteLabel.textColor = UIColor(named: "textColor")
        self.view.addSubview(minuteLabel)
    }
    
    // 타이머 UI를 설정하는 메서드입니다.
    func setupTimerUI() {
        // 타이머 내부 뷰의 모양을 설정
        timerInnerView.layer.cornerRadius = timerInnerView.frame.width / 2
        timerInnerView.layer.borderWidth = 10
        timerInnerView.layer.borderColor = UIColor(named: "innerColor")?.cgColor

        // 타이머 뷰의 모양을 설정
        timerView.layer.cornerRadius = timerView.frame.width / 2
        timerView.layer.borderWidth = 10
        timerView.layer.borderColor = UIColor(named: "outerColor")?.cgColor
    }
    
    // 타이머 시간을 설정
    func setupTimer() {
        let selectedHour = timeArray[0][timePicker.selectedRow(inComponent: 0)]
        let selectedMinute = timeArray[1][timePicker.selectedRow(inComponent: 1)]

        // 선택된 시간과 분을 초로 변환하여 타이머 시간을 설정합
        timerTime = selectedHour * 60 * 60 + selectedMinute * 60
    }
    
}

extension TimerViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch(component){
        case 0:
            return "\(time[component][row])"
        case 1:
            return "\(time[component][row])"
        case 2:
            return "\(time[component][row])"
        default:
            return nil
        }
    }
    
}

extension TimerViewController: UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return time[component].count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return time.count
    }
}

extension UIPickerView{
    func setPickerLabels(labels: [Int:UILabel], containedView: UIView) { // [component number:label]
        
        let fontSize:CGFloat = 20
        let labelWidth:CGFloat = containedView.bounds.width / CGFloat(self.numberOfComponents)
        
        let x:CGFloat = self.frame.origin.x
        let y:CGFloat = (self.frame.size.height / 2) - (fontSize / 2)
        
        for i in 0...self.numberOfComponents {
            // 0.1 0.2 0.3 .... -> 픽셀 아님!!
            if let label = labels[i] {
                if(label.text!.count == 2){
                    label.frame = CGRect(x: x + labelWidth * CGFloat(i) + 36, y: y, width: labelWidth, height: fontSize)
                }else{
                    label.frame = CGRect(x: x + labelWidth * CGFloat(i) + 24, y: y, width: labelWidth, height: fontSize)
                }
                
                if self.subviews.contains(label) {
                    label.removeFromSuperview()
                }
    
                label.font = UIFont.boldSystemFont(ofSize: fontSize)
                label.backgroundColor = .clear
                label.textAlignment = NSTextAlignment.center
                label.textColor = .white
                self.addSubview(label)
            }
        }
    }
}



