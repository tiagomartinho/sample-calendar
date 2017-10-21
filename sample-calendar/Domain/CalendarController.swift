import Foundation
import UIKit

@objc class CalendarController: NSObject {
    
    @objc var events = [Event]()
    
    override init() {
        events = [Event.init(title: "Late snack", timespan: NSMakeRange(3600, 1800), color: UIColor.red),
        Event.init(title: "Breakfast with Nancy", timespan: NSMakeRange(23400, 3600), color: UIColor.blue),
        Event.init(title: "Shopping for a much needed new pair of shoes", timespan: NSMakeRange(32400, 10800), color: UIColor.red)]
    }
    @objc func numberOfEvents() -> Int {
        return events.count
    }
    
    @objc func eventAtIndex(_ index: Int) -> Event {
        return events[index]
    }
}
