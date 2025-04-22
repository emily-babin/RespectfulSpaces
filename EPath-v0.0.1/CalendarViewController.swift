//
//  CalendarViewController.swift
//  EPath-v0.0.1
//
//  Created by Emily Babin on 2025-03-28.
//

import Foundation

import UIKit
import FirebaseFirestore

private let scrollView = UIScrollView()
private let contentView = UIView()

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var calendarPlaceholderView: UIDatePicker!
    @IBOutlet weak var eventsTableView: UITableView!
    
    var selectedItem = Event()
    
    let db = Firestore.firestore()
    var selectedEvent = Event()
    var listEventAll: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await loadData(year: 2025, month: 4)
        }
        
        table.dataSource = self
        table.delegate = self
     
        // Set default selection
         segmentedControl.selectedSegmentIndex = 0
         
         // Set target for segment changes
         segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        
        // Nav Bar Appearance
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor(red: 222/255, green: 61/255, blue: 38/255, alpha: 1.0)
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        
     }
    
    func loadData(year: Int, month: Int) async{
        
        do {
            let snapshot = try await
                db.collection("Events")
                .whereField("year", isEqualTo: year)
                .whereField("month", isEqualTo: month)
                .order(by: "day").getDocuments()
    
          for document in snapshot.documents {
              let day = document.get("day") as? Int ?? 1
              let month = document.get("month") as? Int ?? 1
              let name = document.get("name") as? String ?? "No Title"
            
              let Event = Event(day: day, month: month, name:name)
              
              listEventAll.append(Event)
              
          }
            
        } catch {
          print("Error getting documents: \(error)")
        }
        
        self.table.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEventAll.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let events = listEventAll[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "event_cell", for:indexPath) as! EventTableViewCell
        
        var month: String
        
        switch events.month {
        case 1:
            month = "JAN"
        case 2:
            month = "FEB"
        case 3:
            month = "MAR"
        case 4:
            month = "APR"
        case 5:
            month = "MAY"
        case 6:
            month = "JUN"
        case 7:
            month = "JUL"
        case 8:
            month = "AUG"
        case 9:
            month = "SEP"
        case 10:
            month = "OCT"
        case 11:
            month = "NOV"
        case 12:
            month = "DEC"
        default:
            month = "ERR"
        }
        
        cell.eventDate.text =  String(events.day)
        cell.eventMonth.text = month
        cell.eventDesc.text = events.name
        
        return cell
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
    


