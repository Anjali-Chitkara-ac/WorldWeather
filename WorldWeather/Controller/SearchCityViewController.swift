//
//  SearchCityViewController.swift
//  WorldWeather
//
//  Created by Anjali Chitkara on 10/29/21.
//

import UIKit
import Alamofire
import PromiseKit
import SwiftyJSON
import SwiftSpinner
import RealmSwift

class SearchCityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tblView: UITableView!
    
    var arrCityInfo : [CityInfo] = [CityInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.delegate = self
        tblView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCityInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city = arrCityInfo[indexPath.row]
        cell.textLabel?.text = "\(city.localizedName) \(city.administrativeID), \(city.countryLocalizedName)"
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count < 3 {
            return
        }
        getCitiesFromSearch(searchText)

    }
    
    func getSearchURL(_ searchText : String) -> String{
        return locationSearchURL + "apikey=" + apiKey + "&q=" + searchText
    }
    
    func getCitiesFromSearch(_ searchText : String) {
        let url = getSearchURL(searchText)
        print(url)
    
        AF.request(url).responseJSON { response in
            
            if response.error != nil {
                print(response.error?.localizedDescription)
            }
            
            let searchResult = JSON( response.data!).array
            print(searchResult)
            
            for location in searchResult! {
                let cityInfo = CityInfo()
                cityInfo.localizedName = location["LocalizedName"].stringValue
                cityInfo.countryLocalizedName = location["Country"]["ID"].stringValue
                cityInfo.administrativeID = location["AdministrativeArea"]["ID"].stringValue
                cityInfo.key = location["Key"].stringValue
                cityInfo.type = location["Type"].stringValue
                
                self.arrCityInfo.append(cityInfo)
             }
            
            self.tblView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cityDetail = arrCityInfo[indexPath.row]
        addCityInDB(cityDetail)
        
        navigationController?.popViewController(animated: true)
    }

    
    func addCityInDB(_ cityInfo : CityInfo){
            do{
                let realm = try Realm()
                try realm.write({
                    realm.add(cityInfo, update: .modified)
                })
            } catch {
                print("Error in getting values from db \(error)")
            }
    }

}
