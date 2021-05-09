//import UIKit
//
//class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UIGestureRecognizerDelegate, UIAlertViewDelegate {
//
//    @IBOutlet weak var citySearchBox: UISearchBar!
//    @IBOutlet weak var mycollectionView: UICollectionView!
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
//
//    let sessionConfiguration = URLSessionConfiguration.default
//    let session = URLSession.shared
//    let decoder = JSONDecoder()
//
//    var restorans: [Restoran]?
//    var searchRestorans: [RestoranSearched]?
//
//    var restoranSelected = ""
//    var aboutRestoran = ""
//
//    let reuseIdentifier = "cell"
//
//
//    func setup() {
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.startAnimating()
//    }
//
//
//    var searching = false
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//        activityIndicator.startAnimating()
//		citySearchBox.delegate = self
//
//
//
//        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboardOnSwipeDown))
//                swipeDown.delegate = self
//        swipeDown.direction =  UISwipeGestureRecognizer.Direction.down
//                self.mycollectionView.addGestureRecognizer(swipeDown)
//
//	}
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        obtainRestorans()
//        obtainSearch()
//    }
//
//    private func checkInternetConnection() -> Bool {
//        guard Reachability.isConnectedToNetwork() == false else {
//            return true
//        }
//
//        let alert = UIAlertController(title: "Error",
//                                      message: "Network connection failed",
//                                      preferredStyle: .alert)
//        alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
//        alert.addAction(.init(title: "Update", style: .default, handler: { [weak self] _ in
//            self?.obtainRestorans()
//        }))
//        present(alert, animated: true, completion: nil)
//        return false
//    }
//
//
//
//    func collectionView(
//		_ collectionView: UICollectionView,
//		numberOfItemsInSection section: Int
//	) -> Int {
//        return (searching ? searchRestorans?.count : restorans?.count) ?? 0
//    }
//
//    func collectionView(
//		_ collectionView: UICollectionView,
//		cellForItemAt indexPath: IndexPath
//	) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(
//			withReuseIdentifier: reuseIdentifier,
//			for: indexPath as IndexPath
//		) as! MyCollectionViewCell
//
//
//        if searching {
//            let restoranSearch = searchRestorans?[indexPath.item]
//            cell.myLabel.text = restoranSearch?.restaurantName
//        } else {
//            let restoran = restorans?[indexPath.item]
//            cell.myLabel?.text = restoran?.restaurantName
//            cell.adressLabel?.text = restoran?.location
//            //-cell.avarageCheckLabel?.text = "\(restoran?.averageCheckRestaurant ?? 1700)"
//
//            if restoran?.averageCheckRestaurant ?? 1700 < 1700 {
//                cell.avarageCheckLabel?.text = "₽₽"
//            } else {
//                cell.avarageCheckLabel?.text = "₽₽₽"
//            }
//
//            /*let restoranUrlImage = restoran?.image[indexPath.item]
//             print(restoranUrlImage)
//            let url = NSURL(string: "http://5539a0574ae2.ngrok.io/media/\(restoranUrlImage)")
//            print(url)
//            let data = NSData(contentsOf: url as URL)
//
//            cell.logo.image = UIImage(data: data! as Data)
//            */
//
//            func stars(rating: Double) {
//                switch rating {
//                case 0:
//                    print("Переменная равна 0")
//                    cell.starsImage.image = #imageLiteral(resourceName: "Star_rating_0_of_5")
//                case 0.1...0.5:
//                    cell.starsImage.image = #imageLiteral(resourceName: "Star_rating_0.5_of_5")
//                case 0.6...1:
//                    cell.starsImage.image = #imageLiteral(resourceName: "Star_rating_1_of_5")
//                case 1.1...1.5:
//                    cell.starsImage.image = #imageLiteral(resourceName: "Star_rating_1.5_of_5")
//                case 1.6...2:
//                    cell.starsImage.image = #imageLiteral(resourceName: "Star_rating_2_of_5")
//                case 2.1...2.5:
//                    cell.starsImage.image = #imageLiteral(resourceName: "Star_rating_2.5_of_5")
//                case 2.6...3:
//                    cell.starsImage.image = #imageLiteral(resourceName: "Star_rating_3_of_5")
//                case 3.1...3.5:
//                    cell.starsImage.image = #imageLiteral(resourceName: "Star_rating_3.5_of_5")
//                case 3.6...4:
//                    cell.starsImage.image = #imageLiteral(resourceName: "Star_rating_4_of_5")
//                case 4.1...4.5:
//                    cell.starsImage.image = #imageLiteral(resourceName: "Star_rating_4.5_of_5")
//                case 4.6...5:
//                    cell.starsImage.image = #imageLiteral(resourceName: "Star_rating_5_of_5")
//                default:
//                    print("не удалось распознать число")
//                }
//            }
//
//            stars(rating: restoran?.rating ?? 0)
//        }
//
//        cell.contentView.layer.cornerRadius = 2.0
//        cell.contentView.layer.borderWidth = 1.0
//        cell.contentView.layer.borderColor = UIColor.clear.cgColor
//        cell.contentView.layer.masksToBounds = true
//        cell.layer.shadowColor = UIColor.white.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)//CGSizeMake(0, 2.0);
//        cell.layer.shadowRadius = 2.0
//        cell.layer.shadowOpacity = 1.0
//        cell.layer.masksToBounds = false
//        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
//        cell.layer.cornerRadius = 10.0
//
//        activityIndicator.stopAnimating()
//
//        return cell
//    }
//
//    // MARK: - UICollectionViewDelegate
//
//    func collectionView(
//		_ collectionView: UICollectionView,
//		didSelectItemAt indexPath: IndexPath
//	) {
//        let restoran = restorans?[indexPath.item]
//        restoranSelected = restoran?.restaurantName ?? "0"
//        //aboutRestoran = restoran?.aboutRestaurant ?? "0"
//		performSegue(withIdentifier: "showViewController", sender: nil)
//    }
//
//	// MARK: - UISearchBarDelegate
//
//    func searchBar(
//		_ searchBar: UISearchBar,
//		textDidChange searchText: String
//	) {
//
// //       searchedCity = restoran.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
//
//        searching = true
//        mycollectionView.reloadData()
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searching = false
//        searchBar.text = ""
//        searchBar.resignFirstResponder()
//
//        mycollectionView.reloadData()
//    }
//
//    override func prepare(
//		for segue: UIStoryboardSegue,
//		sender: Any?
//	) {
//        let destination: RestoranViewController = segue.destination as! RestoranViewController
//        destination.restoranIndex = restoranSelected
//        destination.aboutRestoran = aboutRestoran
//    }
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//            return true
//        }
//    @objc func hideKeyboardOnSwipeDown() {
//            view.endEditing(true)
//        }
//}
//
