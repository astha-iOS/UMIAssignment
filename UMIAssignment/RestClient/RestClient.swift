//
//  RestClient.swift
//  UMIAssignment
//
//  Created by Astha yadav on 28/06/21.
//

import UIKit
import os
import SystemConfiguration

class RestClient {
    
    static var sharedInstance:RestClient {
        let instance = RestClient()
        return instance
    }
    
    private init() {
        os_log("Creating Singlton object. Should be called once", log: .default, type: .debug)
        
    }
    
    //MARK:- getMostPopularGitRepo
    func getMostPopularGitRepo(_ sub_url: String ,page:Int,per_page_count:Int,viewcontroller:UIViewController,completion:@escaping (_ response:Dictionary<String, Any>?)->()) {
                
        let url = String(format:"%@%@?q=%@&sort=%@&page=%d&per_page=%d",BASE_URL,sub_url,"stars:%3E1","stars",page,per_page_count)
        let nsUrl = NSURL(string: url)
        URLSession.shared.dataTask(with: nsUrl! as URL, completionHandler: {
            (data, response, error) in
            if(error != nil){
                os_log("Failed to get response from api: %@ \nCause by: %@ ", log: .default, type: .error, url, String(describing: error))
                completion(nil)
                return
            }
            do{
                let response = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! Dictionary<String,Any>
                
                completion(response)
                
            }catch let error as NSError{
                os_log("Failed to parse response from api: %@ \n Cause by: %@ ", log: .default, type: .error, url, String(describing: error))
                completion(nil)
                
            }
            
        }).resume()
    }
    
    //MARK:- getRepoDetail
    func getRepoDetail(_ url: String,viewcontroller:UIViewController,completion:@escaping (_ response:Dictionary<String, Any>?)->()) {
                
        let url = String(format:"%@",url)
        let nsUrl = NSURL(string: url)
        URLSession.shared.dataTask(with: nsUrl! as URL, completionHandler: {
            (data, response, error) in
            if(error != nil){
                os_log("Failed to get response from api: %@ \nCause by: %@ ", log: .default, type: .error, url, String(describing: error))
                completion(nil)
                return
            }
            do{
                let response = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! Dictionary<String,Any>
                
                completion(response)
                
            }catch let error as NSError{
                os_log("Failed to parse response from api: %@ \n Cause by: %@ ", log: .default, type: .error, url, String(describing: error))
                completion(nil)
                
            }
            
        }).resume()
    }
    
}

public class Reachability {

    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret

    }
}
