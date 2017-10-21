import Foundation
import UIKit

@objc class Event: NSObject {
    
    var timespan = NSRange()
    var title = ""
    var color: UIColor?
    
    @objc convenience init(title: String, timespan: NSRange, color: UIColor) {
        self.init()
        self.title = title
        self.timespan = timespan
        self.color = color
    }
}
