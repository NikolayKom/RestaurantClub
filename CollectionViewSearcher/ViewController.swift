import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UIGestureRecognizerDelegate, UIAlertViewDelegate {
    
    @IBOutlet weak var citySearchBox: UISearchBar!
    @IBOutlet weak var mycollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    var restorans: [Restoran]?
    
    var restoranSelected = ""
    var descriptionRestoran = ""
    
    let reuseIdentifier = "cell"
    

    func setup() {
        activityIndicator.hidesWhenStopped = true
    }
    
	
    var searchedCity = [String]()
    var searching = false

	override func viewDidLoad() {
		super.viewDidLoad()
        activityIndicator.startAnimating()
		citySearchBox.delegate = self
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboardOnSwipeDown))
                swipeDown.delegate = self
        swipeDown.direction =  UISwipeGestureRecognizer.Direction.down
                self.mycollectionView.addGestureRecognizer(swipeDown)
        
	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        obtainRestorans()
        
    }
    
    private func checkInternetConnection() -> Bool {
        guard Reachability.isConnectedToNetwork() == false else {
            return true
        }
        
        let alert = UIAlertController(title: "Error",
                                      message: "Network connection failed",
                                      preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
        alert.addAction(.init(title: "Update", style: .default, handler: { [weak self] _ in
            self?.obtainRestorans()
        }))
        present(alert, animated: true, completion: nil)
        return false
    }
	
    func obtainRestorans() {
        
        guard checkInternetConnection() else { return }
        
        // check valid else return
        guard let url = URL(string: "http://5539a0574ae2.ngrok.io/main_map_restaurants_api") else {
            return
        }
        //data - we resive with request, response - codes
        session.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let strongSelf = self else { return }
            if error == nil, let parsData = data {
                
               let restoransResponse = try? strongSelf.decoder.decode(RestorantsResponse.self,
                                                  from:parsData
               )
                
                self?.restorans = restoransResponse?.restorants
                DispatchQueue.main.async {
                    strongSelf.mycollectionView.reloadData()
                }

                print("\(self!.restorans)")
            } else {
                print("error: \(error?.localizedDescription)")
            }
            
        }.resume()
        
    }
    
    private func loadCompanyLogo(for restoranImageString: String) {
        guard checkInternetConnection() else { return }
        
        guard let url = URL(string:"http://5539a0574ae2.ngrok.io/media/\(restoranImageString)") else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, (response as? HTTPURLResponse)?.statusCode == 200, error == nil else {
                print("Network Error!")
                return
            }
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data)
                guard
                    let json = jsonObject as? [String: Any?],
                    let urlString = json["url"] as? String,
                    let RestoranLogoURL = URL(string: urlString) else { return print("invalid JSON")}
                
                DispatchQueue.main.async { [weak self] in
                    self?.displayStockLogo(restoranLogoURL: RestoranLogoURL)
                }
                
            } catch {
                print("JSON parsing error: " + error.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    private func displayStockLogo(restoranLogoURL: URL) {
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: restoranLogoURL)
            DispatchQueue.main.async { [weak self] in
                guard let data = data else { return }
               // self?.logo.image = UIImage(data: data)
            }
        }
    }
    
    func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
        return searching ? searchedCity.count : restorans?.count ?? 0
    }

    func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: reuseIdentifier,
			for: indexPath as IndexPath
		) as! MyCollectionViewCell
		
        let restoran = restorans?[indexPath.item]
        
        if searching {
            cell.myLabel.text = searchedCity[indexPath.item]
        } else {
            cell.myLabel?.text = restoran?.restaurantName
            cell.adressLabel?.text = restoran?.location
            //cell.avarageCheckLabel?.text = "\(restoran?.averageCheckRestaurant ?? 1700)"
            
            if restoran?.averageCheckRestaurant ?? 1700 < 1700 {
                cell.avarageCheckLabel?.text = "₽₽"
            } else {
                cell.avarageCheckLabel?.text = "₽₽₽"
            }
            
            //let restoranUrlImage = restoran?.image[indexPath.item]
           // print(restoranUrlImage)
           // let url = NSURL(string: "http://5539a0574ae2.ngrok.io/media/\(restoranUrlImage)")
            //print(url)
            //let data = NSData(contentsOf: url! as URL)
            
            // cell.logo.image = UIImage(data: data! as Data)
            
            
        }

        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.white.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)//CGSizeMake(0, 2.0);
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        cell.layer.cornerRadius = 10.0
        
        activityIndicator.stopAnimating()
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(
		_ collectionView: UICollectionView,
		didSelectItemAt indexPath: IndexPath
	) {
        let restoran = restorans?[indexPath.item]
        restoranSelected = restoran?.restaurantName ?? "0"
        descriptionRestoran = restoran?.descriptionRestaurant ?? "0"
		performSegue(withIdentifier: "showViewController", sender: nil)
    }
	
	// MARK: - UISearchBarDelegate
    
    func searchBar(
		_ searchBar: UISearchBar,
		textDidChange searchText: String
	) {
 
 //       searchedCity = restoran.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        mycollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        mycollectionView.reloadData()
    }
    
    override func prepare(
		for segue: UIStoryboardSegue,
		sender: Any?
	) {
        let destination: RestoranViewController = segue.destination as! RestoranViewController
        destination.restoranIndex = restoranSelected
        destination.discriptionRestoran = descriptionRestoran
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    @objc func hideKeyboardOnSwipeDown() {
            view.endEditing(true)
        }
}

