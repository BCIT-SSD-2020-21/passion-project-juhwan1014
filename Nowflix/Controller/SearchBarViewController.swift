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
            
            
            print("\(searchBar.text)")
        }
    }
   


