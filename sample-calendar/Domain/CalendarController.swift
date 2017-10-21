import Foundation
import UIKit

@objc class CalendarController: NSObject {
    
    @objc var events = [Event]()
    
    override init() {
        events = [Event.init(title: "Late snack", timespan: NSMakeRange(3600, 1800), color: UIColor.red),]
    }
    @objc func numberOfEvents() -> Int {
        return events.count
    }
    
    @objc func eventAtIndex(_ index: Int) -> Event {
        return events[index]
    }
}

//        // Mock a few events for the day
//        self.events = @[
//        [Event eventWithTitle:@"Late snack" timespan:NSMakeRange(3600, 1800) color:[UIColor redColor]],
//        [Event eventWithTitle:@"Breakfast with Nancy" timespan:NSMakeRange(23400, 3600) color:[UIColor blueColor]],
//        [Event eventWithTitle:@"Shopping for a much needed new pair of shoes" timespan:NSMakeRange(32400, 10800) color:[UIColor redColor]],
//        [Event eventWithTitle:@"Meeting!" timespan:NSMakeRange(52200, 7200) color:[UIColor orangeColor]],
//        [Event eventWithTitle:@"Beer with Matt" timespan:NSMakeRange(75600, 10800) color:[UIColor blueColor]]
//        ];

