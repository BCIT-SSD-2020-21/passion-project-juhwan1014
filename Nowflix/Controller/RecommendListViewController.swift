//
//  RecommendListViewController.swift
//  Nowflix
//
//  Created by APPLE on 2021-04-09.
//

import UIKit

class RecommendListViewController: UIViewController {

    
    
    @IBOutlet weak var sectionTitle: UILabel!
    
    let viewModel = RecommentListViewModel()
    
    
   
//    var apiCalling = MovieAPI()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieAPI.PopularMovieData{(result) in print("쿨쿨 여기서 부터 리절트 \(result)")}

        
        
        
//        MovieAPI.getPopularData(){
//            jsonData in
//               // collectionView
//               print("how many ? \(movies.count)")
//               DispatchQueue.main.async {
//                   self.jsonData = m
//                   self.resultCollectionView.reloadData()
//
//               }
//
//        }
      
     
//        print("바로여기바로여기바로여기 밑에밑에밑에바로밑에")
//        apiCalling.getPopularData{
//        (result) in print("\(result)")
//        }
//        print("위위위위위위위위위")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func updateUI() {
        sectionTitle.text = viewModel.type.title
    }

}


extension RecommendListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCell", for: indexPath) as? RecommendCell else {
            return UICollectionViewCell()
        }
        
        let movie = viewModel.item(at: indexPath.item)
        cell.updateUI(movie: movie)
        return cell
    }
}

//extension RecommendListViewController: UICollectionViewDelegate{
//    func gettingData() {
//    MovieAPI.PopularMovieData{ popMovies in
//        print("how many ? \(popMovies.count)")
//        DispatchQueue.main.async {
//            self.popMovies = popMovies
//            self.resultCollectionView.reloadData()
//
//        }
//    }
//    }
//}


extension RecommendListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 160)
    }
}

class RecommentListViewModel {
    enum RecommendingType {
        case award
        case hot
        case my
        
        var title: String {
            switch self {
            case .award: return "아카데미 호평 영황"
            case .hot: return "취한저격 HOT 콘텐츠"
            case .my: return "내가 찜한 콘텐츠"
            
            }
        }
    }
    
    private (set) var type: RecommendingType = .my
    private var items: [DummyItem] = []
    
    var numOfItems: Int {
        return items.count
    }
    
    func item(at index: Int) -> DummyItem {
        return items[index]
    }
    
    func updateType(_ type: RecommendingType) {
        self.type = type
    }
    
    func fetchItems() {
        if MovieFetcher.fetch(type) != nil{
        self.items = MovieFetcher.fetch(type)
        }
    }
}


class RecommendCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    func updateUI(movie: DummyItem) {
        thumbnailImage.image = movie.thumbnail
    }
}

class MovieFetcher {
   
 
//    private var apiSevice = MovieAPI()
//    private var popularMovie = [TheMovie]()
//
//
//    func fetchPopularMovieData(completion: @escaping () -> ()){
//        apiSevice.getPopularData{[weak self] (result) in
//
//            switch result {
//            case .success(let listOf):
//                self?.popularMovie = listOf.TheMovies
//                completion()
//            case .failure(let error):
//                print("Error processing json data: \(error)")
//            }
//        }
//    }
//
//
//    private var urlString: String = ""
//
//    private func updateUI(poster: String?) {
//        guard let posterString = poster else { return }
//        urlString = "http://image.tmdb.org/t/p/w300" + posterString
//
//        guard let posterImageURL = URL(string: urlString) else {
//            return
//        }
//
//    }
    
  
    
    static func fetch(_ type: RecommentListViewModel.RecommendingType) -> [DummyItem] {
    
    let session = URLSession(configuration: .default)
    
    var ImageUrlComponents = URLComponents(string: "http://image.tmdb.org/t/p/w300")!
    
   
    
    
        switch type {
        
        case .award:
            
//            let myGroup = DispatchGroup()
//
//            var ImageURL: [String] = []
//            var movies: [DummyItem]?
//
//
//            MovieAPI.PopularMovieData
//            { popMovies in
//
//                print("how many ? \(popMovies.count)")
//                print("how many ? \(popMovies[0].posterImage)")
//                print("제발 요놈 위에꺼가 출력되길....")
//
//                for i in 0...10{
//                    ImageURL.append("http://image.tmdb.org/t/p/w300\(popMovies[i].posterImage!)")
//
//                }
//
//                print(ImageURL[0])
//                print(ImageURL[1])
//                print(ImageURL[2])
//
//                print("위에꺼 도나리도나리...")
////                  return ImageURL
//            }
//
//            DispatchQueue.main.async  {
//            print("아래꺼 밖에서 선언한 이미지유알엘...")
//            print(ImageURL)
//            print("위에꺼 밖에서 선언한 이미지유알엘...")
//
////                 movies = (1..<10).map
////                 {
////                    DummyItem(thumbnail: UIImage(named: "img_movie_\($0)")!)
////
////                 }
//            do{
//                   let url = URL(string: "http://image.tmdb.org/t/p/w300/tbVZ3Sq88dZaCANlUcewQuHQOaE.jpg")!
//
//                   let data = try Data(contentsOf: url)
//
//                myGroup.enter()
//                movies?.append(DummyItem(thumbnail: UIImage(data: data)!))
//                myGroup.leave()
//
////                       ImageMovies.append(DummyItem(thumbnail: UIImage(data: data)!))
//   //                    return ImageMovies!
//                   }
//            catch let error {
//                print("깔깔깔깔깔깔깔깔깔")
//                       print("\(error)")
//                   }
//
//
//            return movies!
//            let movies = (1..<10).map { DummyItem(thumbnail: UIImage(named: "img_movie_\($0)")!) }
//            return movies
//            if let imageUrl = URL(string: "http://image.tmdb.org/t/p/w300/pgqgaUx1cJb5oZQQ5v0tNARCeBp.jpg" ){
//                DispatchQueue.global().async{
//                    if let data = try? Data(contentsOf: imageUrl){
//                        DispatchQueue.main.async {
//                            let movies = (1..<10).map { DummyItem(thumbnail: UIImage(data: data))
//
//                            }
//                            return movies
//                        }
//
//                    }
//                }
//            }
            
            
            
            
            
            
            
            
            
            
////                       let movies = (1..<10).map
////                        {
////                           DummyItem(thumbnail: UIImage(named: "img_movie_\($0)")!)
////
////                        }
////            return movies
//
//            var ImageMovies: [DummyItem] = []
//            DispatchQueue.main.async{
//            for _ in (1..<10){
//
//                do{
//                let url = URL(string: "http://image.tmdb.org/t/p/w300/tbVZ3Sq88dZaCANlUcewQuHQOaE.jpg")!
//
//                let data = try Data(contentsOf: url)
//
//                    ImageMovies.append(DummyItem(thumbnail: UIImage(data: data)!))
////                    return ImageMovies!
//                } catch let error {
//                    return
//                }
//
//            }
//            }
//
//            print(ImageMovies)
//            print("호이잇 시험 이거 위에")
//            return ImageMovies
//
            
            
            
            
            
            
            
            
//            let url = URL(string: "http://image.tmdb.org/t/p/w300/tbVZ3Sq88dZaCANlUcewQuHQOaE.jpg")!
//
//            let data = try Data(contentsOf: url!)
//            let movies = (1..<10).map
//             {
//                DummyItem(thumbnail: UIImage(data: data)!)
//
//             }
// return movies
                let movies = (1..<10).map { DummyItem(thumbnail: UIImage(named: "img_movie_\($0)")!) }
            return movies
        case .hot:
            let movies = (10..<19).map { DummyItem(thumbnail: UIImage(named: "img_movie_\($0)")!) }
        

            return movies
        case .my:
            let movies = (1..<10).map { $0 * 2 }.map { DummyItem(thumbnail: UIImage(named: "img_movie_\($0)")!) }
          
            return movies
        }
            
  
            
  }
    
    
    
    
  
 
}






class MovieAPI {
    
//    static func PopularMovieData(completion: @escaping ([TheMovie])-> [DummyItem]){
    static func PopularMovieData(completion: @escaping ([TheMovie])-> Void){
        let session = URLSession(configuration: .default)
        
        var UrlComponents = URLComponents(string: "https://api.themoviedb.org/3/movie/popular?api_key=6e4ef717279fab32a9cd5fb1cda17e55&language=en-US&page=1")!
        
        let RequestURL = UrlComponents.url!
        
        let DataTask = session.dataTask(with: RequestURL) {
            data, response, error in
            let successRange = 200..<300
            
            guard error == nil,
                  let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else {
                completion([])
                return
            }
            
            guard let resultData = data else {
                completion([])
                return
            }
            
            let string = String(data: resultData, encoding: .utf8)
            
            let popMovies = MovieAPI.parseTheMovies(resultData)
            completion(popMovies)
            print("--> result: \(popMovies.count)")
        }
        
        DataTask.resume()
        
    }
    
    static func parseTheMovies(_ data: Data) -> [TheMovie] {
        let decoder = JSONDecoder()
        
        do {
            let response = try decoder.decode(MoviesData.self, from: data)

            let movies = response.TheMovies
            return movies
        }catch let error {
            print("--> parsing error: \(error.localizedDescription)")
            return []
        }
        
    }

    
    
    
    
    
    
//
//    private var dataTask:URLSessionDataTask?
//
//    func getPopularData(completion: @escaping (Result<MoviesData, Error>) -> Void){
//
//        let PopularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=6e4ef717279fab32a9cd5fb1cda17e55&language=en-US&page=1"
//        guard let url = URL(string: PopularMoviesURL) else {return}
//
//        dataTask = URLSession.shared.dataTask(with: url) {
//             (data, response, error) in
//
//            if let error = error {
//                completion(.failure(error))
//                print("DataTask error: \(error.localizedDescription)")
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else {
//                print("Empty Response")
//                return
//            }
//            print("Response status code: \(response.statusCode)")
//
//            guard let data = data else {
//                print("Empty Data")
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let jsonData = try decoder.decode(MoviesData.self, from: data)
//
//                DispatchQueue.main.async{
//                    completion(.success(jsonData))
//                }
//            }catch let error{
//                completion(.failure(error))
//            }
//
//
//        }
//
//        dataTask?.resume()
//    }

}




struct MoviesData: Codable {
    let TheMovies: [TheMovie]

    private enum CodingKeys: String, CodingKey{
        case TheMovies = "results"
    }
}

struct TheMovie: Codable{
    let title: String?
    let year: String?
    let rate: Double?
    let posterImage: String?
    let overview: String?
    
   private enum CodingKeys: String, CodingKey{
        case title, overview
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
    }
}



struct DummyItem {
    let thumbnail: UIImage
}



