//
//  ViewController.swift
//  SwiftyImageCacheDemo
//
//  Created by gowri anguraj on 25/09/19.
//  Copyright © 2019 gowri anguraj. All rights reserved.
//


import UIKit
import SwiftyImageCache

class ViewController: UIViewController {
    
    var urlStrings: [String] = [
        "http://i.annihil.us/u/prod/marvel/i/mg/9/a0/4ce18a834b7f5.jpg",
        "http://i.annihil.us/u/prod/marvel/i/mg/f/60/4c0042121d790.jpg",
        "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec.jpg",
        "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16.jpg",
        "http://i.annihil.us/u/prod/marvel/i/mg/8/a0/4c002e4aa7e27.jpg",
        "http://i.annihil.us/u/prod/marvel/i/mg/8/c0/4ce5a0e31f109.jpg",
        "http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04.jpg",
        "http://i.annihil.us/u/prod/marvel/i/mg/1/b0/5269678709fb7.jpg",
        "http://i.annihil.us/u/prod/marvel/i/mg/e/e0/4c004214c1502.jpg",
        "http://i.annihil.us/u/prod/marvel/i/mg/a/f0/5202887448860.jpg",
       
    ]
    
    var nameStrings :[String]=["Atlas","Agent Zero","A.I.M","A-Bomb","3-D Man","Hank Pym","Abomination","Absorbing Man","Abyss","Adam Warlock"]
    @IBOutlet weak var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        //Navigation Controller Tittle
        self.navigationItem.title = "Heroes"
        
        //Pull and Refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullAndRefresh), for: .valueChanged)
    
        //iOS 10 or later compatablity check for refresh controll
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            // Fallback on earlier versions
        }
       
        
    }
    @objc func pullAndRefresh(refreshControl: UIRefreshControl) {
        print("Refreshed!")
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController,
            let urlString = sender as? String,
            let url = URL(string: urlString) {
            detailVC.url = url
            
        }
    }
    
}
// Tableview Delegates
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "showDetailSegue", sender: urlStrings[indexPath.row])
        
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlStrings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.url = URL(string: urlStrings[indexPath.row])
        cell.tittlelabel.text = nameStrings[indexPath.row]
        tableView.layer.masksToBounds = true
        tableView.layer.borderColor = UIColor( red: 153/255, green: 153/255, blue:0/255, alpha: 1.0 ).cgColor
        tableView.layer.borderWidth = 2.0
        return cell
    }
    
}
//Custom Tableview cell Class
class Cell: UITableViewCell {
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var tittlelabel : UILabel!
    var url: URL? {
        didSet {
            if let url = url {
                contentImageView.image = nil
                contentImageView.setUrl(url, qualityFactor: 2.0)
                
            }
        }
    }
}
