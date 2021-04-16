//
//  HomeViewController.swift
//  Nowflix
//
//  Created by APPLE on 2021-04-09.
//

import UIKit
import Kingfisher
import AVFoundation

class HomeViewController: UIViewController {

    
    @IBOutlet private weak var ImageHeader: UIImageView!
    
    
    var popularRecommendListViewController: RecommendListViewController!
    var ratedRecommendListViewController: RecommendListViewController!
    var nowPlayingRecommendListViewController: RecommendListViewController!

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popular" {
            let destinationVC = segue.destination as? RecommendListViewController
            popularRecommendListViewController = destinationVC
            popularRecommendListViewController.viewModel.updateType(.popular)
            popularRecommendListViewController.viewModel.fetchItems()
        } else if segue.identifier == "rated" {
            let destinationVC = segue.destination as? RecommendListViewController
            ratedRecommendListViewController = destinationVC
            ratedRecommendListViewController.viewModel.updateType(.rated)
            ratedRecommendListViewController.viewModel.fetchItems()
        } else if segue.identifier == "nowPlaying" {
            let destinationVC = segue.destination as? RecommendListViewController
            nowPlayingRecommendListViewController = destinationVC
            nowPlayingRecommendListViewController.viewModel.updateType(.nowPlaying)
            nowPlayingRecommendListViewController.viewModel.fetchItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var HeaderImageString: [String] = []
        let semaphore = DispatchSemaphore(value: 0)
        
        MovieAPI.PopularMovieData
        { popMovies in
            for i in 0...10{
            HeaderImageString.append("http://image.tmdb.org/t/p/w300\(popMovies[i].posterImage!)")
        }
            semaphore.signal()
        }
        _ = semaphore.wait(wallTimeout: .distantFuture)
        
        let HeaderUrl = HeaderImageString[0]
        
        self.ImageHeader.setHeaderImage(HeaderUrl, placeholder: "placeholder")
      
        // Do any additional setup after loading the view.
    }
    
 
    
    
    @IBAction func playButtonTapped(_ sender: Any) {
                SearchAPI.search("interstella") { movies in
                    guard let interstella = movies.first else { return }
        
                    DispatchQueue.main.async {
                        let url = URL(string: interstella.previewURL)!
                        let item = AVPlayerItem(url: url)
                        let sb = UIStoryboard(name: "Player", bundle: nil)
                        let vc = sb.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
                        vc.player.replaceCurrentItem(with: item)
        
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: false, completion: nil)    }
        
//        SearchAPI.search("interstella") { movies in
//            guard let interstella = movies.first else { return }
//
//            DispatchQueue.main.async {
//                let url = URL(string: interstella.previewURL)!
//                let item = AVPlayerItem(url: url)
//                let sb = UIStoryboard(name: "Player", bundle: nil)
//                let vc = sb.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
//                vc.player.replaceCurrentItem(with: item)
//
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: false, completion: nil)
            }
        }
    }
  

extension UIImageView{
    func setHeaderImage(_ imageUrl: String, placeholder: String){
        
        
      
        print(imageUrl)
        print("위에가 받아온 이미지 유알엘")
        
        self.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: placeholder))
        
//        ImageHeader.kf.indicatorType = .activity
//        ImageHeader.kf.setImage(with: URL(string: "http://image.tmdb.org/t/p/w300/pgqgaUx1cJb5oZQQ5v0tNARCeBp.jpg") , placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil )
//
        
    }
}
