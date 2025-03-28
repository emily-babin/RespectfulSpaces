//
//  CalendarViewController.swift
//  EPath-v0.0.1
//
//  Created by Emily Babin on 2025-03-28.
//

import Foundation

import UIKit

private let scrollView = UIScrollView()
private let contentView = UIView()

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var calendarPlaceholderView: UIDatePicker!
    @IBOutlet weak var eventsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
     
        // Set default selection
         segmentedControl.selectedSegmentIndex = 0
         
         // Set target for segment changes
         segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
     }
    
    @objc func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("Monthly view selected")
        case 1:
            print("Weekly view selected")
        case 2:
            print("Daily view selected")
        default:
            break
        }
    }
}
    


