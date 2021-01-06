//
//  WebserviceClass.swift
//  mavfilms
//
//  Created by Satheesh Speed Mac on 30/12/20.
//

import UIKit
import Alamofire
import MBProgressHUD

class WebserviceClass {
    
    static let sharedAPI : WebserviceClass = WebserviceClass()
    
    typealias Response<T> = (_ result: AFDataResponse<T>) -> Void
       
    func performRequest <T:Codable>(type: T.Type, urlString:String, success:@escaping ((T) -> Void), failure: @escaping ((T) -> Void)) -> Void {
                        
        print("**************************")
        
        print("Request urlString", urlString)

        print("**************************")
            
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        AF.request(request).responseString { response in

            MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)

            switch response.result {
            case .success(_):
                if let data = response.data {
                    print(response.result)
                    // Convert This in JSON
                    do {
                        let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8)
                        let responseDecoded = try JSONDecoder().decode(T.self, from: utf8Data!)
                        success(responseDecoded)
                    }catch let error as NSError{
                        print(error)
                    }

                }
            case .failure(let error):
                print("Error:", error)
            }

        }
        
    }
    
}
