//
//  ApiSerivce.swift
//  SimpleBlog
//
//  Created by Jeff Jeong on 2020/05/05.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FFPopup

final class ApiService: NSObject {

    static let shared = ApiService()

    private override init() {
        // Private initialization to ensure just one instance is created.
    }
    
    
    // 겟 메소드 호출
    func getRequest(url: String, parameters: [String: String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        print("ApiSerivce - getRequest() called")
        // 컴플레션 블락
        AF.request(url, method: .get, parameters: parameters)
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    print("성공입니다.")
                    
                    let resJson = JSON(response.value!)
                    
                    // 성공 컴플레션 블락 실행
                    success(resJson)
                    
                case let .failure(error):
                    print("실패입니다.")
                    print(error)
                    
                    
                    
                    // 실패 컴플레션 블락 실행
                    failure(error)
                }
          }
    }
    
    
    
    
    
    func deleteRequest(url: String, parameters: [String: String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        print("ApiSerivce - getRequest() called")
        // 컴플레션 블락
        AF.request(url, method: .delete, parameters: parameters)
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    print("성공입니다.")
                    
                    let resJson = JSON(response.value!)
                    
                    // 성공 컴플레션 블락 실행
                    success(resJson)
                    
                case let .failure(error):
                    print("실패입니다.")
                    print(error)
                    
                    // 실패 컴플레션 블락 실행
                    failure(error)
                }
          }
    }
    
    
    
    
//    func requestBlogPosts(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void)
//      {
//          AF.request(strURL).responseJSON { (responseObject) -> Void in
//              //print(responseObject)
//              if responseObject.result.isSuccess {
//                  let resJson = JSON(responseObject.result.value!)
//                  //let title = resJson["title"].string
//                  //print(title!)
//                  success(resJson)
//              }
//
//              if responseObject.result.isFailure {
//                  let error : Error = responseObject.result.error!
//                  failure(error)
//              }
//          }
//      }
}
