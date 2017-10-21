import Foundation
import UIKit

private let HourReusableViewTimeLineTopPadding: CGFloat = 6.0

class HourReusableView: UICollectionReusableView {
    
    var timeLabel: UILabel!
    var timeLineView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        timeLabel = UILabel()
        timeLabel?.font = UIFont.systemFont(ofSize: 10)
        timeLabel?.textColor = UIColor.black
        timeLabel?.textAlignment = .right
        addSubview(timeLabel!)
        timeLineView = UIView()
        timeLineView?.backgroundColor = UIColor(white: 0, alpha: 0.2)
        addSubview(timeLineView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var timeLabelFrame: CGRect = timeLabel.frame
        timeLabelFrame.origin.x = 2
        timeLabelFrame.origin.y = 0
        timeLabelFrame.size.width = 24
        timeLabel.frame = timeLabelFrame
        let timeLineFrame = CGRect(x: timeLabelFrame.maxX + 5, y: HourReusableViewTimeLineTopPadding, width: bounds.size.width - timeLabelFrame.maxX - 10, height: 0.5)
        timeLineView.frame = timeLineFrame
    }
    
    func setTime(_ time: String) {
        timeLabel.text = time
        timeLabel.sizeToFit()
        setNeedsLayout()
    }
}
