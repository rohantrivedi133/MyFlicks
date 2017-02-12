//
//  MoviesViewController.swift
//  MyFlicks
//
//  Created by Rohan Trivedi on 1/30/17.
//  Copyright © 2017 Rohan Trivedi. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIApplicationDelegate, UISearchBarDelegate{

    @IBOutlet weak var tableView: UITableView!
    let refreshControl: UIRefreshControl = UIRefreshControl()
    var movies: [NSDictionary]?
    var window: UIWindow?
    var endpoint: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(MoviesViewController.uiRefreshControlAction), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl)
        
        tableView.dataSource = self
        tableView.delegate = self
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
        MBProgressHUD.hide(for: self.view, animated: true)
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(dataDictionary)
                    self.movies = (dataDictionary["results"] as! [NSDictionary])
                    self.tableView.reloadData()
                }
            }
        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
//    {
//        UIApplication.shared.statusBarStyle = .lightContent
//        return true
//    }
    
    func uiRefreshControlAction()
    {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let movies = movies
        {
            return movies.count
        }
        else
        {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let rating = movie["vote_average"] as! Double
        
        let baseURL = "https://image.tmdb.org/t/p/w500"
        if let backdropPath = movie["backdrop_path"] as? String
        {
            let imageURL = NSURL(string: baseURL + backdropPath)
            cell.posterView.setImageWith(imageURL as! URL)
        }
        
        let releaseDate = movie["release_date"] as! String
        let overview = movie["overview"] as! String
        
        
        cell.overviewLabel.text = overview
        cell.titleLabel.text = title
        
        cell.ratingLabel.text = String(rating)
        cell.releaseLabel.text = releaseDate
        
        if rating < 5
        {
            cell.ratingLabel.textColor = UIColor.red
        }
        else if rating >= 7
        {
            cell.ratingLabel.textColor = UIColor.green
        }
        else
        {
            cell.ratingLabel.textColor = UIColor.yellow
        }
        
        print("row \(indexPath.row)")
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let movie = movies![indexPath!.row]
        
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.movie = movie
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
