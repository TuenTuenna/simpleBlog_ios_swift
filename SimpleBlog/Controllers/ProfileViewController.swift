//
//  ProfileViewController.swift
//  SimpleBlog
//
//  Created by Jeff Jeong on 2020/05/12.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imgSettingBtn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ProfileViewController - viewDidLoad() Called")
        
        
        
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.layer.borderWidth = 5
        profileImg.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
        imgSettingBtn.addTarget(self, action: #selector(showImageSelectDialog), for: .touchUpInside)
        
    }
    
    
    @objc fileprivate func showImageSelectDialog(){
        let alert = UIAlertController(title: "이미지설정", message: "이미지를 선택해주세요", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { action in
              switch action.style{
              case .default:
                    print("default")

              case .cancel:
                    print("cancel")

              case .destructive:
                    print("destructive")


        }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
