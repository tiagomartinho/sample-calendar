import Foundation
import UIKit

@objc class EventViewCell: UICollectionViewCell {
    
    var event: Event?
    var leftBorderView: UIView?
    var label: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        leftBorderView = UIView()
        contentView.addSubview(leftBorderView!)
        label = UILabel()
        label?.font = UIFont.boldSystemFont(ofSize: 10)
        label?.numberOfLines = 0
        label?.lineBreakMode = .byWordWrapping
        contentView.addSubview(label!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func set(event: Event) {
        self.event = event
        layer.borderColor = event.color?.cgColor
        backgroundColor = event.color?.withAlphaComponent(0.2)
        label?.text = event.title
        label?.textColor = event.color
        leftBorderView?.backgroundColor = event.color
        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        leftBorderView?.frame = CGRect(x: 0, y: 0, width: 4, height: bounds.size.height)
        let labelSize = label?.sizeThatFits(CGSize(width: bounds.size.width - 10.0, height: CGFloat(MAXFLOAT)))
        label?.frame = CGRect(x: 8, y: 8, width: labelSize!.width, height: labelSize!.height)
    }
}
