//
//  EditPostViewController.swift
//  SimpleBlog
//
//  Created by Jeff Jeong on 2020/04/21.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import UIKit
import Alamofire

class EditPostViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var bodyInput: UITextView!
    @IBOutlet weak var titleInput: UITextField!
    
    var receivedPost: Post?
    
    var delegate: EditPostViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        print("에딧 VC - viewDidLoad() 호출됨 / receivedPost.id : \(receivedPost?.id)")
        
        navigationItem.title = "포스팅 수정하기"
        // 네비게이션 바 버튼을 추가한다.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정완료", style: .plain, target: self,
                                                            
                                                            action: #selector(editComplete))
        
        bodyInput.delegate = self
        titleInput.delegate = self
        
        titleInput.text = receivedPost?.title
        bodyInput.text = receivedPost?.body
        
        
    }
    
    
    @objc fileprivate func editComplete(){
        print("editComplete() called")
        
        print("입력된 타이틀:  \(titleInput.text ?? "")")
               print("입력된 바디:  \(bodyInput.text ?? "")")
               
               let parameters: [String: Any] = [
                   "title" : (titleInput.text ?? "") as String,
                   "body" : (bodyInput.text ?? "") as String
               ]

        AF.request("http://13.209.73.176/api/post/\(receivedPost?.id ?? "")", method: .put, parameters: parameters, encoding: JSONEncoding.default)
               .responseJSON { response in
                   print("포스팅 수정 성공!~ \(response)")
                   
                if let value = response.value as? [String: AnyObject] {
                //                print(value)
                    print(value["id"] as Any)
                    print(value["title"] as Any)
                    print(value["body"] as Any)
                    
                        if let dict = value as? NSDictionary {
                                                
                            guard let id = dict.value(forKey: "id") else { return }
                            guard let title = dict.value(forKey: "title") else { return }
                            guard let body = dict.value(forKey: "body") else { return }
                            
                            print("파싱된. id: \(id) / title: \(title) / body: \(body)")
                            
                            let responsePostItem = Post(id: "\(id)", title: title as! String, body: body as! String)
                                                
                           self.delegate?.editPostCompleted(editedPostItem: responsePostItem)
                            
                        }
                   
                    }
                                
                }
                            
                
                

                
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
    
    

