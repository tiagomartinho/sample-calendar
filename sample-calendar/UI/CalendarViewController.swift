import UIKit

@objc class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CalendarViewLayoutDelegate {
    var calendarController = CalendarController()
    var collectionView: UICollectionView?
    
    
    override func loadView() {
        let layout = CalendarViewLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout as? UICollectionViewLayout ?? UICollectionViewLayout())
        collectionView?.backgroundColor = UIColor.white
        collectionView?.dataSource = self
        collectionView?.delegate = self
        view = collectionView
        collectionView?.register(EventViewCell.self, forCellWithReuseIdentifier: "event")
        collectionView?.register(HourReusableView.self, forSupplementaryViewOfKind: "hour", withReuseIdentifier: "hour")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarController.numberOfEvents()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let view = collectionView.dequeueReusableCell(withReuseIdentifier: "event", for: indexPath) as? EventViewCell
        view?.set(event: calendarController.eventAtIndex(indexPath.item))
        return view as? UICollectionViewCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "hour", for: indexPath) as? HourReusableView
        view?.setTime("\(Int(indexPath.item))H")
        return view as? UICollectionReusableView ?? UICollectionReusableView()
    }
    
    func calendarViewLayout(_ layout: CalendarViewLayout, timespanForCellAt indexPath: IndexPath) -> NSRange {
        return calendarController.eventAtIndex(indexPath.item).timespan
    }
}
