//
//  SearchBarViewController.swift
//  Nowflix
//
//  Created by APPLE on 2021-04-09.
//

import UIKit

class SearchBarViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
    
    extension SearchBarViewController: UISearchBarDelegate{
        
        private func dismissKeyboard(){
            searchBar.resignFirstResponder()
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
          // Treat the keyboard to go down when it comes up
            dismissKeyboard()
         // whether or not the search term exists
            guard let searchTerm = searchBar.text,
                  searchTerm.isEmpty == false
            else {return}
            
            SearchAPI.search(searchTerm) { movies in
                // collectionView
                
            }
            
            print("\(searchBar.text)")
        }
    }
   

class SearchAPI {
    static func search(_ term: String, completion: @escaping ([Movie])-> Void){
        let session = URLSession(configuration: .default)
        
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")!
        let mediaQuery = URLQueryItem(name: "media", value: "movie")
        let entityQuery = URLQueryItem(name: "entity", value: "movie")
        let termQuery = URLQueryItem(name: "term", value: term)
        urlComponents.queryItems?.append(mediaQuery)
        urlComponents.queryItems?.append(entityQuery)
        urlComponents.queryItems?.append(termQuery)
        
        let requestURL = urlComponents.url!
        
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
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
             
            print("---> 여기가 리절트 \(string)")
            
//            completion([Movie])
            
        }
        dataTask.resume()
    }
}

struct Response {
    
}

struct Movie {
    
}

