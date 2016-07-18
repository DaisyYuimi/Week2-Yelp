//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FiltersViewControllerDelegate {

    var businesses: [Business]!
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    var searchBar: UISearchBar!
    var shouldShowSearchResults = false
    var hud: MBProgressHUD = MBProgressHUD()
    
    func configureSearchController() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        configureSearchController()
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            self.tableView.reloadData()
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })
        
        

/* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
*/
    }
    
      override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
                
        cell.business = businesses[indexPath.row]
        
        return cell
    }

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        let navigationController = segue.destinationViewController as! UINavigationController
        let filterVC = navigationController.topViewController as! FiltersViewController
        filterVC.delegate = self
    }
    
    func filtersViewController(filterVC: FiltersViewController, didUpdateFileter filter: [String]) {
        print("got the signal #2")
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        Business.searchWithTerm("", sort: filterVC.sortStates, categories: filter, deals: filterVC.dealOnOff, distance: filterVC.distance) { (businesses: [Business]!, error: NSError!) in
            self.businesses = businesses
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            self.tableView.reloadData()
        }
    }
}

extension BusinessesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        Business.searchWithTerm(searchBar.text!, sort: nil, categories: nil, deals: nil, distance: nil) { (businesses: [Business]!, error: NSError!) in
            self.businesses = businesses
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            self.tableView.reloadData()
            searchBar.resignFirstResponder()
        }

    }
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        Business.searchWithTerm(searchBar.text! + text, sort: nil, categories: nil, deals: nil, distance: nil) { (businesses: [Business]!, error: NSError!) in
            self.businesses = businesses
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            self.tableView.reloadData()
            
        }
        return true
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
            searchBar.text = ""
            searchBar.resignFirstResponder()
    }
}
