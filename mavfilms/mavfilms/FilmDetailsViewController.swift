//
//  FilmDetailsViewController.swift
//  mavfilms
//
//  Created by Satheesh Speed Mac on 31/12/20.
//

import UIKit
import AlamofireImage
import Alamofire
import MBProgressHUD

class FilmDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genereLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var imdbVotesLabel: UILabel!
    @IBOutlet weak var boxOfficeLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var synopsisTextView: UITextView!

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var ratingsImage: UIImageView!

    var searchedFilm: Search?
    var filmDetails: FilmDetailsModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.getFilmDetails(searchedFilm?.imdbID ?? "")
        
    }
    
    func getFilmDetails(_ imdbID: String) {
                
        MBProgressHUD.showAdded(to: KeyWindow.windowView!, animated: true)
        
        WebserviceClass.sharedAPI.performRequest(type: FilmDetailsModel.self, urlString: ApiEndPoint.FilmDetails.rawValue + imdbID, success: { [weak self] (response) in
            
            MBProgressHUD.hide(for: KeyWindow.windowView!, animated: true)

            print(response)
            
            self?.filmDetails = response
            
            self?.setUpViewModel(self?.filmDetails! ?? nil)
            
        }) { (response) in
            MBProgressHUD.hide(for: KeyWindow.windowView!, animated: true)
        }
        
    }
    
    func setUpViewModel(_ filmDetail: FilmDetailsModel?) {
        
        self.titleLabel.text = filmDetail?.title ?? ""
        self.yearLabel.text = filmDetail?.year ?? ""
        self.genereLabel.text = filmDetail?.genre ?? ""
        
        let hours = "\(self.minutesToHoursAndMinutes(filmDetail?.runtime ?? "").hours)"
        let minutes = "\(self.minutesToHoursAndMinutes(filmDetail?.runtime ?? "").leftMinutes)"
        
        self.hoursLabel.text = "\(hours)h \(minutes)m"
        
        if let rating: Double = Double(filmDetail?.imdbRating ?? "") {
            
            self.ratingsImage.image = rating < 10 ? UIImage(systemName: "star.leadinghalf.fill") : UIImage(systemName: "star.fill")
            
        }
        
        self.ratingsLabel.text = filmDetail?.imdbRating ?? ""
        self.synopsisTextView.text = filmDetail?.plot ?? ""
        self.scoreLabel.text = filmDetail?.metascore ?? ""
        self.imdbVotesLabel.text = filmDetail?.imdbVotes ?? ""
        self.boxOfficeLabel.text = filmDetail?.boxOffice ?? ""
        self.directorLabel.text = filmDetail?.director ?? ""
        self.writerLabel.text = filmDetail?.writer ?? ""
        self.actorLabel.text = filmDetail?.actors ?? ""

        if let poster = self.searchedFilm?.poster {
            let image = URL(string: poster)!
            self.posterImage.af.setImage(withURL: image, placeholderImage: #imageLiteral(resourceName: "Placeholder"))
        }
        
    }
    
    func minutesToHoursAndMinutes (_ minutes : String) -> (hours : Int , leftMinutes : Int) {
        
        if let intMinutes = Int(minutes.components(separatedBy: " ")[0]) {
            return (intMinutes / 60, (intMinutes % 60))
        } else {
            return (0,0)
        }
    }
    
    @IBAction func goBack(_ sender: Any)  {
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
