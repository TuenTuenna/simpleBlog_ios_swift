//
//  ProfileViewController.swift
//  SimpleBlog
//
//  Created by Jeff Jeong on 2020/05/12.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import UIKit
// 카메라 오픈소스
import SwiftyCam

// 프로필 화면
class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imgSettingBtn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    
//    var cameraViewController: CameraViewController?
    
    //MARK:- override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ProfileViewController - viewDidLoad() Called")
        
        
        // 프로필 이미지
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.layer.borderWidth = 5
        profileImg.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
        imgSettingBtn.addTarget(self, action: #selector(showImageSelectDialog), for: .touchUpInside)
        
    }
    
    
    @objc fileprivate func showImageSelectDialog(){
        
        // 알림창
        let alert = UIAlertController(title: "이미지설정", message: "이미지를 선택해주세요", preferredStyle: .alert)
        
        
        
        let shootCamera = UIAlertAction(title: "카메라 촬영", style: .default, handler: { (done) in
            print("카메라 촬영을 클릭 했다!")
            // 카메라 촬영 뷰컨트롤러 보여주기
            
            let myCameraVC = CameraController()
            self.present(myCameraVC, animated: true, completion: nil)
            
            
        })
        
        let choosePhoto = UIAlertAction(title: "앨범에서 사진선택", style: .default, handler: { (done) in
            print("앨범에서 사진선택!")
            // 앨범 보여주기
        })
        
        let deletePhoto = UIAlertAction(title: "프사 지우기", style: .destructive, handler: { (done) in
            print("프사 지우기 선택!")
            // 현재 프사 지우기
        })
        
        let cancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        
        // 알림창에 액션추가
        alert.addAction(shootCamera)
        alert.addAction(choosePhoto)
        alert.addAction(deletePhoto)
        alert.addAction(cancel)
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
}
