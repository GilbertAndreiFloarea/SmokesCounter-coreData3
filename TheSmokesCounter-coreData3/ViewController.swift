//
//  ViewController.swift
//  SmokesCounter-coreData3
//
//  Created by Gilbert Andrei Floarea on 13/04/2019.
//  Copyright © 2019 Gilbert Andrei Floarea. All rights reserved.
//

import CoreData
import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var currentCigarette: Cigarette?
    
    var managedContext: NSManagedObjectContext!
    
    // MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let cigaretteBrand = "Fido"
        let cigaretteFetch: NSFetchRequest<Cigarette> = Cigarette.fetchRequest()
        cigaretteFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(Cigarette.brand), cigaretteBrand)
        
        do {
            let results = try managedContext.fetch(cigaretteFetch)
            if results.count > 0 {
                // Fido found, use Fido
                currentCigarette = results.first
            } else {
                // Fido not found, create Fido
                currentCigarette = Cigarette(context: managedContext)
                currentCigarette?.brand = cigaretteBrand
                try managedContext.save()
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    // MARK: - IBActions
    @IBAction func add(_ sender: UIBarButtonItem) {
        
        let smoke = Smoke(context: managedContext)
        smoke.date = NSDate()
        
        if let cigarette = currentCigarette,
            let smokes = cigarette.smokes?.mutableCopy() as? NSMutableOrderedSet {
            smokes.add(smoke)
            cigarette.smokes = smokes
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Save error: \(error), description: \(error.userInfo)")
        }
        
        tableView.reloadData()
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currentCigarette?.smokes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let smoke = currentCigarette?.smokes?[indexPath.row] as? Smoke,
            let smokeDate = smoke.date as Date? else {
                return cell
        }
        
        cell.textLabel?.text = dateFormatter.string(from: smokeDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of Smokes | # \(currentCigarette?.smokes?.count ?? 0) smokes"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let smokeToRemove = currentCigarette?.smokes?[indexPath.row] as? Smoke,
            editingStyle == .delete else {
                return
        }
        
        managedContext.delete(smokeToRemove)
        
        do {
            try managedContext.save()
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch let error as NSError {
            print("Saving error: \(error), description: \(error.userInfo)")
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}


