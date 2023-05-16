//
//  StopWatchTableViewCell.swift
//  ThreadTest
//
//  Created by 이서영 on 2023/05/13.
//

import UIKit

class StopWatchTableViewCell: UITableViewCell {

    @IBOutlet weak var LapLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    
    // 랩 타임과 랩 번호를 설정하는 메서드
    func configure(lapTime: String, lapNumber: Int) {
        TimeLabel.text = lapTime
        LapLabel.text = "Lap \(lapNumber)"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // 셀이 재사용될 때 설정을 초기화하는 메서드
    override func prepareForReuse() {
        super.prepareForReuse()
        
        TimeLabel.text = nil
        LapLabel.text = nil
    }

}
