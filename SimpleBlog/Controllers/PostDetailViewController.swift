//
//  PostDetailViewController.swift
//  SimpleBlog
//
//  Created by Jeff Jeong on 2020/04/21.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import UIKit
import Alamofire

class PostDetailViewController: UIViewController, EditPostViewControllerDelegate {
    
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    var post: Post? {
        didSet {
            print("post - didSet : post.title : \(post?.title)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("post.id : \(post?.id)")
        print("PostDetailVC - viewDidLoad() 호출됨 / post.title : \(post?.title)")
        print("PostDetailVC - viewDidLoad() 호출됨 / post.body : \(post?.body)")
        
        titleLabel.text = post?.title
        bodyLabel.text = post?.body
        
        
        
        // 네비게이션 바 버튼을 추가한다.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정하기", style: .plain, target: self, action: #selector(goToEditPostView))
        
        self.deleteBtn.addTarget(self, action: #selector(deletePost), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    @objc fileprivate func deletePost(){
        print("deletePost() called")
        
        guard let postId = post?.id else { return }
        
        AF.request("http://13.209.73.176/api/post/\(postId)", method: .delete, parameters: nil, encoding: JSONEncoding.default)
        .responseJSON { response in
            print("포스팅 삭제 성공!~ \(response)")
            
            self.navigationController?.popViewController(animated: true)
            
            
        }
        
    }
    
    
    @objc fileprivate func goToEditPostView(){
        print("goToEditPostView() called")
        
        performSegue(withIdentifier: "goToEditPostVC", sender: self)
        
    }
    
    
    // 화면을 넘기는 부분이다.
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

           if(segue.identifier == "goToEditPostVC"){
               
               var vc = segue.destination as! EditPostViewController
               
               print("세그웨이로 넘어왔다. selectedPost.title : \(post?.title)")
               
               vc.receivedPost = self.post
                vc.delegate = self
           }
           

       }
    
    
    //MARK: - EditPostViewControllerDelegate 메소드
    func editPostCompleted(editedPostItem: Post) {
        print("PostDetailViewController - editPostCompleted / editedPostItem.title : \(editedPostItem.title)")
        titleLabel.text = editedPostItem.title
        bodyLabel.text = editedPostItem.body
    }
    
}
