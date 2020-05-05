//
//  PostDetailViewController.swift
//  SimpleBlog
//
//  Created by Jeff Jeong on 2020/04/21.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftEntryKit


class PostDetailViewController: UIViewController, EditPostViewControllerDelegate {
    
    
    @IBOutlet weak var popupButton: UIButton!
    @IBOutlet weak var player: UIButton!
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
        
        
        popupButton.addTarget(self, action: #selector(showSomePopUp), for: .touchUpInside)
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func showPopupPlease(){
        self.showPopup(title: "타이틀", body: "바디", image: UIImage.init(named: "up")!, action: {
            print("호호")
        })
    }
    
    func showPopup(title: String, body: String, image: UIImage, action: @escaping () -> Void) {
        var attributes = EKAttributes.topFloat
        attributes.displayDuration = .infinity
        attributes.entryBackground = .gradient(gradient: .init(colors: [EKColor(UIColor.purple), EKColor(UIColor.blue)], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.screenBackground = .visualEffect(style: .prominent)
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.width), height: .intrinsic)
        // これがないとアクションが実行されない
        attributes.entryInteraction = .absorbTouches

        // UIFont() は任意の形に変更する必要がある
        let title = EKProperty.LabelContent(text: title, style: .init(font: UIFont(), color: .white))
        let description = EKProperty.LabelContent(text: body, style: .init(font: UIFont(), color: .white))
        let image = EKProperty.ImageContent(image: image, size: CGSize(width: 35, height: 35))
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)

        let label = EKProperty.LabelContent(text: "OK", style: .init(font: UIFont(), color: .black))
        let button = EKProperty.ButtonContent(label: label, backgroundColor: .white, highlightedBackgroundColor: .standardBackground) {
            // dismissを自分で呼ばないとビューが消えない
            SwiftEntryKit.dismiss()
            action()
        }
        let content = EKProperty.ButtonBarContent(with: [button], separatorColor: EKColor(UIColor.black), expandAnimatedly: true)

        let alertMessage = EKAlertMessage(simpleMessage: simpleMessage, buttonBarContent: content)
        let view = EKAlertMessageView(with: alertMessage)
        
        let titleLabel: UILabel = {
                let label = UILabel()
                label.text = "사진 공유하기 화면"
                label.textColor = .black
                label.textAlignment = .center
        //        label.font = UIFont.systemFont(ofSize: 20.0)
                label.font = UIFont.boldSystemFont(ofSize: 40)
        //        label.font = UIFont.italicSystemFont(ofSize: 20.0)
                return label
            }()
        
        
        
        SwiftEntryKit.display(entry: titleLabel, using: attributes)
    }
    
    
    @objc fileprivate func deletePost(){
        print("deletePost() called")
        
        guard let postId = post?.id else { return }
        
        
        
        print("delete api : \(Constants.API.GET_POST_DETAIL + "/" + postId)")
        
        ApiService.shared.deleteRequest(url: Constants.API.GET_POST_DETAIL + "/" + postId, parameters: nil, success: {
            response in
            
//            print("response : \(response)")
            print("포스팅 삭제 성공!~ \(response)")
            self.navigationController?.popViewController(animated: true)
            
        }, failure: {
            errorResponse in
            
            
            
            print("errorResponse : \(errorResponse)")
            
        })
        
//        AF.request("http://13.209.73.176/api/post/\(postId)", method: .delete, parameters: nil, encoding: JSONEncoding.default)
//        .responseJSON { response in
//
//        }
        
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
        
        self.post = editedPostItem
        
        titleLabel.text = editedPostItem.title
        bodyLabel.text = editedPostItem.body
        
    }
    
}
