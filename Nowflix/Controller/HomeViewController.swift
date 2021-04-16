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
    
    
    var awardRecommendListViewController: RecommendListViewController!
    var hotRecommendListViewController: RecommendListViewController!
    var myRecommendListViewController: RecommendListViewController!

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "award" {
            let destinationVC = segue.destination as? RecommendListViewController
            awardRecommendListViewController = destinationVC
            awardRecommendListViewController.viewModel.updateType(.award)
            awardRecommendListViewController.viewModel.fetchItems()
        } else if segue.identifier == "hot" {
            let destinationVC = segue.destination as? RecommendListViewController
            hotRecommendListViewController = destinationVC
            hotRecommendListViewController.viewModel.updateType(.hot)
            hotRecommendListViewController.viewModel.fetchItems()
        } else if segue.identifier == "my" {
            let destinationVC = segue.destination as? RecommendListViewController
            myRecommendListViewController = destinationVC
            myRecommendListViewController.viewModel.updateType(.my)
            myRecommendListViewController.viewModel.fetchItems()
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
