//
//  CreatePostViewController.swift
//  SimpleBlog
//
//  Created by Jeff Jeong on 2020/04/21.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import UIKit
import Alamofire


class CreatePostViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var titleInput: UITextField!
    
    @IBOutlet weak var bodyInput: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleInput.delegate = self
        bodyInput.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "등록하기", style: .plain, target: self, action: #selector(registerPost))
        
        // 화면을 터치 했을때 키보드를 내린다.
        hideKeyboardSetting()
        
    }
 
    
    //MARK: - fileprivate 메소드
    @objc fileprivate func registerPost(){
        print("registerPost() called")
        
        print("입력된 타이틀:  \(titleInput.text ?? "")")
        print("입력된 바디:  \(bodyInput.text ?? "")")
        
        let parameters: [String: Any] = [
            "title" : (titleInput.text ?? "") as String,
            "body" : (bodyInput.text ?? "") as String
        ]

        AF.request("http://13.209.73.176/api/post", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .responseJSON { response in
            print("포스팅 등록 성공!~ \(response)")
            
            self.navigationController?.popViewController(animated: true)
            
            
        }
    }
    
    
    
    //MARK: - TextField 델리겟 메소드
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing / textField : \(textField.text)")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing / textField : \(textField.text)")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print("타이틀입력: \(textField.text)")
        return true
        
    }
    
    //MARK: - textView 델리겟 메소드
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("바디입력: \(textView.text)")
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("textViewDidBeginEditing / textView : \(textView.text)")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("textViewDidEndEditing / textView : \(textView.text)")
    }
    
    
    
    
}
