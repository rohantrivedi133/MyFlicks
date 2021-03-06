//
//  MovieCollectionViewController.swift
//  MyFlicks
//
//  Created by Rohan Trivedi on 2/3/17.
//  Copyright © 2017 Rohan Trivedi. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MovieCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    let refreshControl: UIRefreshControl = UIRefreshControl()
    var movies: [NSDictionary]?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(MoviesViewController.uiRefreshControlAction), for: UIControlEvents.valueChanged)
        self.moviesCollectionView.addSubview(refreshControl)
        
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let task: URLSessionDataTask = session.dataTask(with: request)
        { (data: Data?, response: URLResponse?, error: Error?) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let data = data
            {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                {
                    print(dataDictionary)
                    self.movies = (dataDictionary["results"] as! [NSDictionary])
                    self.moviesCollectionView.reloadData()
                }
            }
        }
        task.resume()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func uiRefreshControlAction()
    {
        self.moviesCollectionView.reloadData()
        refreshControl.endRefreshing()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
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
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell", for: indexPath) as! MovieCollectionViewCell
        
        let movie = movies![indexPath.row]
        let baseURL = "https://image.tmdb.org/t/p/w500"
        let posterPath = movie["poster_path"] as! String
        let imageURL = NSURL(string: baseURL + posterPath)
        
        cell.movieImageView.setImageWith(imageURL as! URL)
        print("row \(indexPath.row)")
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
