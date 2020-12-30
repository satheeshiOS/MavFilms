//
//  ViewController.swift
//  mavfilms
//
//  Created by Satheesh Speed Mac on 30/12/20.
//

import UIKit
import Alamofire
import MBProgressHUD

enum ApiEndPoint: String {
    case FilmList = "http://www.omdbapi.com/?apikey=b9bd48a6&s="
    case FilmDetails = "http://www.omdbapi.com/?apikey=b9bd48a6&i="
}

struct KeyWindow {
    static let windowView = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
}



class FilmListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var collectionView: UICollectionView!
    
    var filmModel: FilmModel?

    var defaultSearchFilms = "Marvel"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        self.navigationItem.title = "Movies"

        collectionView.delegate = self
        collectionView.dataSource = self
        
        getFilmList(defaultSearchFilms)
        
    }
    
    func getFilmList(_ searchText: String) {
        
        let search = "\(searchText)&type=movie"
        
        MBProgressHUD.showAdded(to: KeyWindow.windowView!, animated: true)
        
        WebserviceClass.sharedAPI.performRequest(type: FilmModel.self, urlString: ApiEndPoint.FilmList.rawValue + search, methodType:  HTTPMethod.get, success: { (response) in
            print(response)
            self.filmModel = response
            self.collectionView.reloadData()
            MBProgressHUD.hide(for: KeyWindow.windowView!, animated: true)
        
        }) { (response) in
            MBProgressHUD.hide(for: KeyWindow.windowView!, animated: true)
        }
        
    }
    
    
}

extension FilmListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowLayout?.minimumInteritemSpacing ?? 0.0) + (flowLayout?.sectionInset.left ?? 0.0) + (flowLayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (self.collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filmModel?.search?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilmCollectionViewCell", for: indexPath) as? FilmCollectionViewCell
        if let movieData = self.filmModel?.search?[indexPath.row] {
            let image = URL(string: movieData.poster ?? "")!
            cell?.movieImageView.af.setImage(withURL: image, placeholderImage: nil)
            cell?.movieTitleLable.text = movieData.title ?? ""
        }
        return cell ?? UICollectionViewCell()
    }
    
    
}

extension FilmListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(FilmListViewController.reload), object: nil)
        self.perform(#selector(FilmListViewController.reload), with: nil, afterDelay: 0.5)
    }
        
    @objc func reload() {
        guard let searchText = searchBar.text else { return }
        if searchText.count == 0{
            getFilmList(defaultSearchFilms)
        } else {
            getFilmList(searchText)
        }
    }
}

