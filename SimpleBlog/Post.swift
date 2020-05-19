//
//  Post.swift
//  SimpleBlog
//
//  Created by Jeff Jeong on 2020/04/16.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import Foundation

// 데이터 클래스
struct Post : Codable{
    
    let title: String
    let body: String
    let id: String
    
    // 기본 생성자
    init(id: String, title: String, body: String){
        self.id = id
        self.title = title
        self.body = body
    }
    
//    init() {
//        self.title = "hoho"
//    }
    
}
