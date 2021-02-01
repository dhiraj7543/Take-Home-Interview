

import UIKit
import Alamofire

class Api: NSObject {
    
    
    private static var api:Api!
    
    private static var apiLinker:ApiLinker!

    
    
    
    class func share() -> Api{
        if api == nil {
            api = Api()
            apiLinker = ApiLinker()
        }
        return api
    }
    

    
}

// Mark: - Auth Api
extension Api {
    // Mark: - Signup
  
    func getCateogrys(url: String, params: [String: AnyObject], completion:@escaping (Bool, String?, [CategoryModel]?)->Void) {
        
        Loader.shared.show()
        
        Api.apiLinker.requestMethod(method: .post).execute(url: url, parameters: { () -> [String : AnyObject]? in
            params
        }, onResponse: { (response) in
            Loader.shared.hide()
            if let resp = response{
                let status = resp["success"] as? Bool ?? false
                if status{
                    if resp["data"] != nil{

                            let responseData = resp["data"] as! [Dictionary<String, Any>]
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: responseData , options: .prettyPrinted)
                                do {
                                    let jsonDecoder = JSONDecoder()
                                    let opportunitesListData = try jsonDecoder.decode([CategoryModel].self, from: jsonData)
                                    print(opportunitesListData)
                                    
                                    
                                        
                                    
                                    Loader.shared.hide()
                                    completion(true, "" , opportunitesListData)
                                } catch {
                                    print("Unexpected error: \(error).")
                                    Loader.shared.hide()
                                    completion(false, error.localizedDescription, nil)
                                }
                                
                            } catch {
                                print(error.localizedDescription)
                                  completion(false, "", nil)
                                Loader.shared.hide()
                            }
                           
                            
                    
                    }
                    else{
                        let msg = resp["message"] ?? "Some error Occured"
                        completion(false, msg as! String, nil)
                        
                    }
                } else {
                    let msg = resp["message"] ?? "Some error Occured"
                    completion(false, msg as! String, nil)
                }
            }}) { (error) in
                completion(false, error ?? "", nil)
                Loader.shared.hide()
        }
        
        
        
    }
    
    func loginUser(url: String, params: [String: AnyObject], completion:@escaping (Bool, String?, UserModel?)->Void) {
        
        let header = ["Accept" : "application/json"]
        Loader.shared.show()
        
        Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
            params   
        }, onResponse: { (response) in
            Loader.shared.hide()
            if let resp = response{
                let status = resp["success"] as? Bool ?? false
                if status{
                    if resp["data"] != nil{

                            let responseData = resp["data"] as! Dictionary<String, Any>
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: responseData , options: .prettyPrinted)
                                do {
                                    let jsonDecoder = JSONDecoder()
                                    let opportunitesListData = try jsonDecoder.decode(UserModel.self, from: jsonData)
                                    print(opportunitesListData)
                                    Loader.shared.hide()
                                    completion(true, "" , opportunitesListData)
                                } catch {
                                    print("Unexpected error: \(error).")
                                    Loader.shared.hide()
                                    completion(false, error.localizedDescription, nil)
                                }
                                
                            } catch {
                                print(error.localizedDescription)
                                  completion(false, "", nil)
                                Loader.shared.hide()
                            }
                           
                            
                    
                    }
                    else{
                        let msg = resp["message"] ?? "Some error Occured"
                        completion(false, msg as! String, nil)
                        
                    }
                } else {
                    let msg = resp["message"] ?? "Some error Occured"
                    completion(false, msg as! String, nil)
                }
            }}) { (error) in
                completion(false, error ?? "", nil)
                Loader.shared.hide()
        }
        
        
        
    }
    
    
    func signupUser(url: String, params: [String: AnyObject], completion:@escaping (Bool, String?, RegisterModel?)->Void) {
        
        Loader.shared.show()
        
        let header = ["Accept" : "application/json"]
        
        Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
            params
        }, onResponse: { (response) in
            Loader.shared.hide()
            if let resp = response{
                let status = resp["success"] as? Bool ?? false
                if status{
                    if resp["data"] != nil{

                            let responseData = resp["data"] as! Dictionary<String, Any>
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: responseData , options: .prettyPrinted)
                                do {
                                    let jsonDecoder = JSONDecoder()
                                    let opportunitesListData = try jsonDecoder.decode(RegisterModel.self, from: jsonData)
                                    print(opportunitesListData)
                                    Loader.shared.hide()
                                    let msg = (resp["message"] ?? "Some error Occured") as! String
                                
                                    completion(true, msg , opportunitesListData)
                                } catch {
                                    print("Unexpected error: \(error).")
                                    Loader.shared.hide()
                                    completion(false, error.localizedDescription, nil)
                                }
                                
                            } catch {
                                print(error.localizedDescription)
                              completion(false, error.localizedDescription, nil)
                                Loader.shared.hide()
                            }
                           
                            
                    
                    }
                    else{
                        let msg = resp["message"] ?? "Some error Occured"
                        completion(false, msg as! String, nil)
                        
                    }
                } else {
                    let msg = resp["message"] ?? "Some error Occured"
                    completion(false, msg as! String, nil)
                }
            }}) { (error) in
                completion(false, error ?? "", nil)
                Loader.shared.hide()
        }
        
        
        
    }
    
    
    func forgotPassword(url: String, params: [String: AnyObject], completion:@escaping (Bool, String?)->Void) {
        
        Loader.shared.show()
        
        Api.apiLinker.requestMethod(method: .post).execute(url: url, parameters: { () -> [String : AnyObject]? in
            params
        }, onResponse: { (response) in
            Loader.shared.hide()
            if let resp = response{
                let status = resp["success"] as? Bool ?? false
                if status{
                    if resp["data"] != nil{
                        let status = resp["success"] as? Bool
                        if (status ?? false) {
                            let responseMessage = (resp["message"] as? String) ?? "Some error Occured"
                            
                            completion(true, responseMessage)
                            
                        } else{
                            
                        }
                    }
                    else{
                        let msg = resp["message"] ?? "Some error Occured"
                        completion(false, msg as! String)
                        
                    }
                } else{
                    let msg = resp["message"] ?? "Some error Occured"
                    completion(false, msg as? String)
                }
            } else{
                let msg = response?["message"] ?? "Some error Occured"
                completion(false, msg as? String)
            }
            
        }) { (error) in
                completion(false, error ?? "")
                Loader.shared.hide()
        }
        
        
        
    }
    
    func likeOrFavUser(url: String, params: [String: AnyObject],token: String, completion:@escaping (Bool, String?)->Void) {
        
       // Loader.shared.show()
        let header = ["Authorization" : "Bearer \(token)",
        "Accept" : "application/json"]
        
        Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
            params
        }, onResponse: { (response) in
            //    Loader.shared.hide()
            if let resp = response{
                let status = resp["success"] as? Bool ?? false
                if status{
                    if resp["data"] != nil{
                        let status = resp["success"] as? Bool
                        if (status ?? false) {
                            let responseMessage = (resp["message"] as? String) ?? "Some error Occured"
                            
                            completion(true, responseMessage)
                            
                        } else{
                            
                        }
                    }
                    else{
                        let msg = resp["message"] ?? "Some error Occured"
                        completion(false, msg as! String)
                        
                    }
                } else{
                    let msg = resp["message"] ?? "Some error Occured"
                    completion(false, msg as? String)
                }
            } else{
                let msg = response?["message"] ?? "Some error Occured"
                completion(false, msg as? String)
            }
            
        }) { (error) in
                completion(false, error ?? "")
                Loader.shared.hide()
        }
        
        
        
    }
    
    
    func getProfile(url: String, params: [String: AnyObject],token: String, completion:@escaping (Bool, String?, UserProfileModel?)->Void) {
        
        Loader.shared.show()
        
        let header = ["Authorization" : "Bearer \(token)",
        "Accept" : "application/json"]
        
        Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
            params
        }, onResponse: { (response) in
            Loader.shared.hide()
            if let resp = response{
                let status = resp["success"] as? Bool ?? false
                if status{
                    if resp["data"] != nil{

                            let responseData = resp["data"] as! Dictionary<String, Any>
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: responseData , options: .prettyPrinted)
                                do {
                                    let jsonDecoder = JSONDecoder()
                                    let opportunitesListData = try jsonDecoder.decode(UserProfileModel.self, from: jsonData)
                                    print(opportunitesListData)
                                    Loader.shared.hide()
                                    let msg = (resp["message"] ?? "Some error Occured") as! String
                                
                                    completion(true, msg , opportunitesListData)
                                } catch {
                                    print("Unexpected error: \(error).")
                                    Loader.shared.hide()
                                    completion(false, error.localizedDescription, nil)
                                }
                                
                            } catch {
                                print(error.localizedDescription)
                                  completion(false, "", nil)
                                Loader.shared.hide()
                            }
                           
                            
                    
                    }
                    else{
                        let msg = resp["message"] ?? "Some error Occured"
                        completion(false, msg as! String, nil)
                        
                    }
                } else {
                    let msg = resp["message"] ?? "Some error Occured"
                    completion(false, msg as! String, nil)
                }
            }}) { (error) in
                completion(false, error ?? "", nil)
                Loader.shared.hide()
        }
        
        
        
    }

    
   
}

// Home Api
extension Api {
    
    func dashboardData(url: String, token: String, showLoader: Bool, params: [String: AnyObject], completion:@escaping (Bool, String?, [DashboardModel]?)->Void) {
        
        if showLoader {
            Loader.shared.show()
        }
        
        
        let header = ["Authorization" : "Bearer \(token)",
        "Accept" : "application/json"]
        
        Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
            params
        }, onResponse: { (response) in
            print(response)
            
            Loader.shared.hide()
            if let resp = response{
                let status = resp["success"] as? Bool ?? false
                if status{
                    if resp["data"] != nil{

                            let responseData = resp["data"] as! [Dictionary<String, Any>]
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: responseData , options: .prettyPrinted)
                                do {
                                    let jsonDecoder = JSONDecoder()
                                    let opportunitesListData = try jsonDecoder.decode([DashboardModel].self, from: jsonData)
                                    print(opportunitesListData)
                                    Loader.shared.hide()
                                    let msg = (resp["message"] ?? "Some error Occured") as! String
                                
                                    completion(true, msg , opportunitesListData)
                                } catch {
                                    print("Unexpected error: \(error).")
                                    Loader.shared.hide()
                                    completion(false, error.localizedDescription, nil)
                                }
                                
                            } catch {
                                print(error.localizedDescription)
                                  completion(false, "", nil)
                                Loader.shared.hide()
                            }
                           
                            
                    
                    }
                    else{
                        let msg = resp["message"] ?? "Some error Occured"
                        completion(false, msg as! String, nil)
                        
                    }
                } else {
                    let msg = resp["message"] ?? "Some error Occured"
                    completion(false, msg as! String, nil)
                }
            }}) { (error) in
                completion(false, error ?? "", nil)
                Loader.shared.hide()
        }
        
        
        
    }
    
    
    func getMyBusiness(url: String, token: String, params: [String: AnyObject], completion:@escaping (Bool, String?, [DashboardModel]?)->Void) {
        
        Loader.shared.show()
        
        let header = ["Authorization" : "Bearer \(token)",
        "Accept" : "application/json"]
        
        Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
            params
        }, onResponse: { (response) in
            print(response)
            Loader.shared.hide()
            if let resp = response{
                let status = resp["success"] as? Bool ?? false
                if status{
                    if resp["data"] != nil{

                            let responseData = resp["data"] as! [Dictionary<String, Any>]
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: responseData , options: .prettyPrinted)
                                do {
                                    let jsonDecoder = JSONDecoder()
                                    let opportunitesListData = try jsonDecoder.decode([DashboardModel].self, from: jsonData)
                                    print(opportunitesListData)
                                    Loader.shared.hide()
                                    let msg = (resp["message"] ?? "Some error Occured") as! String
                                
                                    completion(true, msg , opportunitesListData)
                                } catch {
                                    print("Unexpected error: \(error).")
                                    Loader.shared.hide()
                                    completion(false, error.localizedDescription, nil)
                                }
                                
                            } catch {
                                print(error.localizedDescription)
                                  completion(false, "", nil)
                                Loader.shared.hide()
                            }
                           
                            
                    
                    }
                    else{
                        let msg = resp["message"] ?? "Some error Occured"
                        completion(false, msg as! String, nil)
                        
                    }
                } else {
                    let msg = resp["message"] ?? "Some error Occured"
                    completion(false, msg as! String, nil)
                }
            }}) { (error) in
                completion(false, error ?? "", nil)
                Loader.shared.hide()
        }
        
        
        
    }
   
   
   func deleteBusiness(url: String, token: String, params: [String: AnyObject], completion:@escaping (Bool, String?, [DashboardModel]?)->Void) {
       
       Loader.shared.show()
       
       let header = ["Authorization" : "Bearer \(token)",
       "Accept" : "application/json"]
       
       Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
           params
       }, onResponse: { (response) in
           print(response)
           Loader.shared.hide()
           if let resp = response{
               let status = resp["success"] as? Bool ?? false
               if status{
                    let msg = resp["message"] ?? "Some error Occured"
                     completion(true, msg as! String, nil)
                       
               } else {
                   let msg = resp["message"] ?? "Some error Occured"
                   completion(false, msg as! String, nil)
               }
           }}) { (error) in
               completion(false, error ?? "", nil)
               Loader.shared.hide()
       }
       
       
       
   }
   
   
   func getKeywords(url: String, token: String, params: [String: AnyObject], completion:@escaping (Bool, String?, [KeywordModel]?)->Void) {
       
       Loader.shared.show()
       
       let header = ["Accept" : "application/json"]
       
       Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
           params
       }, onResponse: { (response) in
           print(response)
           Loader.shared.hide()
           if let resp = response{
               let status = resp["success"] as? Bool ?? false
               if status{
                   if resp["data"] != nil{

                           let responseData = resp["data"] as! [Dictionary<String, Any>]
                           do {
                               let jsonData = try JSONSerialization.data(withJSONObject: responseData , options: .prettyPrinted)
                               do {
                                   let jsonDecoder = JSONDecoder()
                                   let opportunitesListData = try jsonDecoder.decode([KeywordModel].self, from: jsonData)
                                   print(opportunitesListData)
                                   Loader.shared.hide()
                                   let msg = (resp["message"] ?? "Some error Occured") as! String
                               
                                   completion(true, msg , opportunitesListData)
                               } catch {
                                   print("Unexpected error: \(error).")
                                   Loader.shared.hide()
                                   completion(false, error.localizedDescription, nil)
                               }
                               
                           } catch {
                               print(error.localizedDescription)
                                 completion(false, "", nil)
                               Loader.shared.hide()
                           }
                          
                           
                   
                   }
                   else{
                       let msg = resp["message"] ?? "Some error Occured"
                       completion(false, msg as! String, nil)
                       
                   }
               } else {
                   let msg = resp["message"] ?? "Some error Occured"
                   completion(false, msg as! String, nil)
               }
           }}) { (error) in
               completion(false, error ?? "", nil)
               Loader.shared.hide()
       }
       
       
       
   }
    
    
    func myLocation(url: String, token:String,showLoader: Bool, params: [String: AnyObject], completion:@escaping (Bool, String?, [MyLocationModel]?)->Void) {
        
        if showLoader {
            Loader.shared.show()
        }
        
        
            let header = ["Authorization" : "Bearer \(token)",
        "Accept" : "application/json"]
        
        Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
            params
        }, onResponse: { (response) in
            Loader.shared.hide()
            if let resp = response{
                let status = resp["success"] as? Bool ?? false
                if status{
                    if resp["data"] != nil{

                            let responseData = resp["data"] as! [Dictionary<String, Any>]
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: responseData , options: .prettyPrinted)
                                do {
                                    let jsonDecoder = JSONDecoder()
                                    let opportunitesListData = try jsonDecoder.decode([MyLocationModel].self, from: jsonData)
                                    print(opportunitesListData)
                                    Loader.shared.hide()
                                    let msg = (resp["message"] ?? "Some error Occured") as! String
                                
                                    completion(true, msg , opportunitesListData)
                                } catch {
                                    print("Unexpected error: \(error).")
                                    Loader.shared.hide()
                                    completion(false, error.localizedDescription, nil)
                                }
                                
                            } catch {
                                print(error.localizedDescription)
                                  completion(false, "", nil)
                                Loader.shared.hide()
                            }
                           
                            
                    
                    }
                    else{
                        let msg = resp["message"] ?? "Some error Occured"
                        completion(false, msg as! String, nil)
                        
                    }
                } else {
                    let msg = resp["message"] ?? "Some error Occured"
                    completion(false, msg as! String, nil)
                }
            }}) { (error) in
                completion(false, error ?? "", nil)
                Loader.shared.hide()
        }
        
        
        
    }
    
    // 
    func location(url: String, token:String, params: [String: AnyObject], completion:@escaping (Bool, String?, LocationModel?)->Void) {
        
        Loader.shared.show()
        
            let header = ["Authorization" : "Bearer \(token)",
        "Accept" : "application/json"]
        
        Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
            params
        }, onResponse: { (response) in
            Loader.shared.hide()
            if let resp = response{
                let status = resp["success"] as? Bool ?? false
                if status{
                    if resp["data"] != nil{

                            let responseData = resp["data"] as! Dictionary<String, Any>
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: responseData , options: .prettyPrinted)
                                do {
                                    let jsonDecoder = JSONDecoder()
                                    let opportunitesListData = try jsonDecoder.decode(LocationModel.self, from: jsonData)
                                    print(opportunitesListData)
                                    Loader.shared.hide()
                                    let msg = (resp["message"] ?? "Some error Occured") as! String
                                
                                    completion(true, msg , opportunitesListData)
                                } catch {
                                    print("Unexpected error: \(error).")
                                    Loader.shared.hide()
                                    completion(false, error.localizedDescription, nil)
                                }
                                
                            } catch {
                                print(error.localizedDescription)
                                  completion(false, "", nil)
                                Loader.shared.hide()
                            }
                           
                            
                    
                    }
                    else{
                        let msg = resp["message"] ?? "Some error Occured"
                        completion(false, msg as! String, nil)
                        
                    }
                } else {
                    let msg = resp["message"] ?? "Some error Occured"
                    completion(false, msg as! String, nil)
                }
            }}) { (error) in
                completion(false, error ?? "", nil)
                Loader.shared.hide()
        }
        
        
        
    }
    
    
    func discountData(url: String, token: String, params: [String: AnyObject], completion:@escaping (Bool, String?, [DashboardModel]?)->Void) {
        
        Loader.shared.show()
        
        let header = ["Authorization" : "Bearer \(token)",
        "Accept" : "application/json"]
        
        Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
            params
        }, onResponse: { (response) in
            Loader.shared.hide()
            if let resp = response{
                let status = resp["success"] as? Bool ?? false
                if status{
                    if resp["data"] != nil{

                            let responseData = resp["data"] as! [Dictionary<String, Any>]
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: responseData , options: .prettyPrinted)
                                do {
                                    let jsonDecoder = JSONDecoder()
                                    let opportunitesListData = try jsonDecoder.decode([DashboardModel].self, from: jsonData)
                                    print(opportunitesListData)
                                    Loader.shared.hide()
                                    let msg = (resp["message"] ?? "Some error Occured") as! String
                                
                                    completion(true, msg , opportunitesListData)
                                } catch {
                                    print("Unexpected error: \(error).")
                                    Loader.shared.hide()
                                    completion(false, error.localizedDescription, nil)
                                }
                                
                            } catch {
                                print(error.localizedDescription)
                                  completion(false, "", nil)
                                Loader.shared.hide()
                            }
                           
                            
                    
                    }
                    else{
                        let msg = resp["message"] ?? "Some error Occured"
                        completion(false, msg as! String, nil)
                        
                    }
                } else {
                    let msg = resp["message"] ?? "Some error Occured"
                    completion(false, msg as! String, nil)
                }
            }}) { (error) in
                completion(false, error ?? "", nil)
                Loader.shared.hide()
        }
        
        
        
    }
    
    
    func uploadMultipleImage(url:String, token: String, parameters:Dictionary<String, String>,imagesArr:[UIImage] ,ownerimagesArr:[UIImage], completion: @escaping (_ result:Dictionary<String, Any>?, _ message:String) -> Void, uploadProgress:@escaping (_ progress:Double)->Void){
        
        
        let header = ["Authorization" : "Bearer \(token)",
            "Accept" : "application/json"]
        
        
        Loader.shared.show()
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in parameters {
                if let data = value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                    multipartFormData.append(data, withName: key)
                    
                }
            }
            
            for i in 0..<imagesArr.count{
                let imageData1 = imagesArr[i].jpegData(compressionQuality: 0.6)!
                multipartFormData.append(imageData1, withName: "images[]" , fileName: "images" + String(i) + ".jpg", mimeType: "image/jpeg")
            }
            
            for i in 0..<imagesArr.count{
                let imageData1 = imagesArr[i].jpegData(compressionQuality: 0.6)!
                multipartFormData.append(imageData1, withName: "owner_images[]" , fileName: "owner_images" + String(i) + ".jpg", mimeType: "image/jpeg")
            }
            
        },
                         to: url,method:HTTPMethod.post,
                         headers:header, encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload
                                    .validate(statusCode: 200..<600)
                                    .responseJSON { (response) in
                                        Loader.shared.hide()
                                        
                                        if response.error != nil {
                                            return
                                        }
                                        
                                        response.result.ifSuccess {
                                            /// Success
                                            upload.uploadProgress { progress in
                                                
                                                print(progress.fractionCompleted)
                                            }
                                            if let dict: Dictionary<String, Any> = response.result.value as? Dictionary<String, Any> {
                                                
                                                let status = (dict["status"]) as? Int
                                                if status == 0 {
                                                    let allData = dict["data"] as? Dictionary<String, Any>
                                                    completion(allData, (dict["message"] as? String) ?? "")
                                                    return
                                                    
                                                }else{
                                                    
                                                }
                                            }
                                        }
                                        response.result.ifFailure {
                                            /// Failed
                                            if let error = response.result.error {
                                                print(error)
                                                
                                                
                                                return
                                            }
                                        }
                                        
                                }
                            case .failure(let encodingError):
                                print("encodingError: \(encodingError)")
                                let errorDesc = (encodingError as NSError).localizedDescription
                                print(errorDesc as NSString,false)
                            }
        })
        
        
    }

    
    
    
    func addBusiness(url: String, token: String, params: [String: AnyObject], completion:@escaping (Bool, String?, [DiscountModel]?)->Void) {
        
        Loader.shared.show()
        
        let header = ["Authorization" : "Bearer \(token)",
        "Accept" : "application/json"]
        
        Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
            params
        }, onResponse: { (response) in
            Loader.shared.hide()
            if let resp = response{
                let status = resp["success"] as? Bool ?? false
                if status{
                    if resp["data"] != nil{

                            let responseData = resp["data"] as! [Dictionary<String, Any>]
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: responseData , options: .prettyPrinted)
                                do {
                                    let jsonDecoder = JSONDecoder()
                                    let opportunitesListData = try jsonDecoder.decode([DiscountModel].self, from: jsonData)
                                    print(opportunitesListData)
                                    Loader.shared.hide()
                                    let msg = (resp["message"] ?? "Some error Occured") as! String
                                
                                    completion(true, msg , opportunitesListData)
                                } catch {
                                    print("Unexpected error: \(error).")
                                    Loader.shared.hide()
                                    completion(false, error.localizedDescription, nil)
                                }
                                
                            } catch {
                                print(error.localizedDescription)
                                  completion(false, "", nil)
                                Loader.shared.hide()
                            }
                           
                            
                    
                    }
                    else{
                        let msg = resp["message"] ?? "Some error Occured"
                        completion(false, msg as! String, nil)
                        
                    }
                } else {
                    let msg = resp["message"] ?? "Some error Occured"
                    completion(false, msg as! String, nil)
                }
            }}) { (error) in
                completion(false, error ?? "", nil)
                Loader.shared.hide()
        }
        
        
        
    }
    
    
    func addLocation(url: String, token: String, params: [String: AnyObject], completion:@escaping (Bool, String?)->Void) {
        
        Loader.shared.show()
        
        let header = ["Authorization" : "Bearer \(token)",
        "Accept" : "application/json"]
        
        Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
            params
        }, onResponse: { (response) in
            Loader.shared.hide()
            if let resp = response{
                let status = resp["success"] as? Bool ?? false
                if status{
                    let msg = resp["message"] ?? "Some error Occured"
                    completion(false, msg as? String)
                } else {
                    let msg = resp["message"] ?? "Some error Occured"
                    completion(false, msg as? String)
                }
            }}) { (error) in
                completion(false, error ?? "")
                Loader.shared.hide()
        }
        
        
        
    }
   
   
   func resendEmail(url: String, params: [String: AnyObject], completion:@escaping (Bool, String?)->Void) {
       
       Loader.shared.show()
       
     //  let header = ["Accept" : "application/json"]
       
       Api.apiLinker.requestMethod(method: .post).execute(url: url, parameters: { () -> [String : AnyObject]? in
           params
       }, onResponse: { (response) in
           Loader.shared.hide()
           if let resp = response{
               let status = resp["success"] as? Bool ?? false
               if status{
                   let msg = resp["message"] ?? "Some error Occured"
                   completion(true, msg as? String)
               } else {
                   let msg = resp["message"] ?? "Some error Occured"
                   completion(false, msg as? String)
               }
           }}) { (error) in
               completion(false, error ?? "")
               Loader.shared.hide()
       }
       
       
       
   }
    
    
    func updateProfile(url:String, token: String, parameters:Dictionary<String, String>,image:UIImage?, imageName:String, completion: @escaping (_ result:UserProfileModel?, _ message:String, _ status: Bool) -> Void, uploadProgress:@escaping (_ progress:Double)->Void){
        
        let headerData = ["Authorization" : "Bearer \(token)",
            "Accept" : "application/json"]
        
        Loader.shared.show()
        Alamofire.upload (
            multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                    
                    
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
                
                if let img = image {
                    multipartFormData.append(img.jpegData(compressionQuality: 0.6) ?? Data(), withName: imageName, fileName: "image.png", mimeType:  "image/png")
                }
                
                
        },
            to: url,
            headers: headerData,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload,_, _):
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                        uploadProgress(progress.fractionCompleted)
                    })
                    upload.responseJSON { (response) in
                        
                        
                        if response.error != nil {
                            completion(nil,"Technical issue", false)
                            // Loader.shared.hide()
                            return
                        }
                        
                        response.result.ifSuccess {
                            /// Success
                            upload.uploadProgress { progress in
                                
                                print(progress.fractionCompleted)
                            }
                            if let dict: Dictionary<String, Any> = response.result.value as? Dictionary<String, Any> {
                                
                                let status = (dict["success"]) as? Bool ?? false
                                let responseData = dict["message"] as? String ?? ""
                                
                                if status {
                                    let profileResp = dict["data"] as! Dictionary<String, Any>
                                    do {
                                        let jsonDecoder = JSONDecoder()
                                        let jsonData = try JSONSerialization.data(withJSONObject: profileResp , options: .prettyPrinted)
                                        
                                        let updatedData = try jsonDecoder.decode(UserProfileModel.self, from: jsonData)
                                        
                                        completion(updatedData, responseData, true)
                                        
                                    } catch {
                                        print("Unexpected error: \(error).")
                                         completion(nil, responseData, true)
                                        
                                    }
                                    
                                    
                                    
                                    // completion(nil,responseData, true)
                                    
                                    
                                    
                                    return
                                    
                                }else{
                                    completion(nil,responseData, false)
                                }
                            }
                        }
                        response.result.ifFailure {
                            /// Failed
                            if let error = response.result.error {
                                print(error)
                                completion(nil,error.localizedDescription, false)
                                
                                return
                            }
                        }
                        
                    }
                case .failure(_):
                    completion(nil,"APP_MESSAGES.technicalIssueMessage", false)
                }
        }
        )
    }
    
    
}
















