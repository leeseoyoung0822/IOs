//
//  StopWatchViewController.swift
//  ThreadTest
//
//  Created by 이서영 on 2023/05/13.
//

import UIKit

class StopWatchViewController: UIViewController {
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var lapTimes: [String] = []
    
    
    // 스탑워치 시작 시간
    var startTime: DispatchTime!
    // 랩 시작 시간
    var lapStartTime: DispatchTime!
    // 전체 경과 시간
    var totalTime: Double = 0.0
    // 랩 경과 시간
    var lapTotalTime: Double = 0.0
    // 스톱워치가 실행 중인지 나타내는 플래그
    var isRunning: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 스탑워치 레이블을 초기화합니다.
        timeLabel.text = formatTime(elapsedTime: 0.0)
    }
    
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        
        // 스톱워치의 실행 상태를 반전시킵니다.
        isRunning = !isRunning
        if isRunning {
            // 스탑워치가 실행 중이라면, 시작 시간을 현재 시간으로 설정합니다.
            startTime = DispatchTime.now()
            lapStartTime = DispatchTime.now()
            
            // 버튼의 텍스트를 변경합니다.
            startBtn.setTitle("중지", for: .normal)
            resetBtn.setTitle("랩", for: .normal)
            
            // 시간을 업데이트합니다.
            DispatchQueue.global().async { [weak self] in
                while self?.isRunning ?? false {
                    // 메인 스레드에서 UI를 업데이트
                    DispatchQueue.main.async {
                        let currentTime = DispatchTime.now()
                        let start = Double(self?.startTime.uptimeNanoseconds ?? 0) / 1_000_000_000.0
                        let now = Double(currentTime.uptimeNanoseconds) / 1_000_000_000.0
                        // 경과 시간을 계산하고, 이를 스톱워치 레이블에 표시합니다.
                        let elapsedTime = now - start + self!.totalTime
                        self?.timeLabel.text = self?.formatTime(elapsedTime: elapsedTime)
                    }
                    // 0.1초마다 시간을 업데이트
                    usleep(100_000)
                }
            }
        } else { // 스톱워치가 멈추면
            //전체 경과 시간을 업데이트하고 버튼의 텍스트를 변경합니다.
            let stopTime = DispatchTime.now()
            let start = Double(startTime.uptimeNanoseconds) / 1_000_000_000.0
            let now = Double(stopTime.uptimeNanoseconds) / 1_000_000_000.0
            totalTime += now - start
            
            startBtn.setTitle("시작", for: .normal)
            resetBtn.setTitle("재설정", for: .normal)
        }
    }
    
    // 초를 분:초.밀리초 형태의 문자열로 변환하는 함수입니다.
    func formatTime(elapsedTime: Double) -> String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        let milliseconds = Int((elapsedTime - floor(elapsedTime)) * 1000)
        return String(format: "%02d:%02d.%03d", minutes, seconds, milliseconds)
    }

    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        if isRunning {
            // 스톱워치가 실행 중이라면, 랩 타임을 기록
            let lapStopTime = DispatchTime.now()
            let lapStart = Double(lapStartTime.uptimeNanoseconds) / 1_000_000_000.0
            let now = Double(lapStopTime.uptimeNanoseconds) / 1_000_000_000.0
            lapTotalTime = now - lapStart
            
            // 랩 타임을 표시합니다. 이 예제에서는 콘솔에 출력합니다.
            print("랩: \(formatTime(elapsedTime: lapTotalTime))")
            lapTimes.insert(formatTime(elapsedTime: lapTotalTime), at: 0)
            tableView.reloadData()
            
            // 다음 랩을 위해 랩 시작 시간을 업데이트합니다.
            lapStartTime = DispatchTime.now()
        } else {
            // 스톱워치가 멈추면, 스톱워치를 리셋
            timeLabel.text = formatTime(elapsedTime: 0.0)
            totalTime = 0.0
            lapTotalTime = 0.0
        }
    }
}

extension StopWatchViewController: UITableViewDataSource, UITableViewDelegate {
    // 테이블 뷰에 표시할 셀의 개수를 반환하는 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapTimes.count
    }

    // 특정 위치에 표시할 셀을 반환하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LapTimeCell", for: indexPath)
        cell.textLabel?.text = lapTimes[indexPath.row]
        return cell
    }
}

