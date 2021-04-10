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
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
            // search start
            
            print("\(searchBar.text)")
        }
    }
   


