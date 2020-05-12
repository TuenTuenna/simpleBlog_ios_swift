//
//  ViewController.swift
//  SimpleBlog
//
//  Created by Jeff Jeong on 2020/04/16.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import UIKit
import Alamofire
import Floaty
import SwiftyJSON
import SwiftEntryKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // 포스팅 배열 초기화
    var posts = [Post]()
    
    var page = 0
    
    var selectedPost: Post?
    
    
    
    //MARK: - 오버라이드 메소드
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("MainViewController - viewDidLoad() 호출됨")
        tableView.delegate = self
        tableView.dataSource = self
        
//        self.tableView.separatorColor = [UIColor clearColor];
        tableView.separatorColor = .clear
        
        // 데이터 가져오기
        loadMoreData(page: 1)
        
        let parameters = ["page": String(1)]
        
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        //
        tableView.refreshControl = refreshControl
        
        // 네비게이션 바 버튼을 추가한다.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToCreateView))
        
        
        //
        let floaty = Floaty()
//        floaty.addItem(title: "Hello, World!")
        floaty.addItem(icon: UIImage(named: "up"), handler: { item in
            print("플로팅 버튼이 클릭되었음")
            
            if #available(iOS 11.0, *) {
                self.tableView.setContentOffset(CGPoint(x: 0, y: -self.tableView.adjustedContentInset.top), animated: true)
            } else {
                self.tableView.setContentOffset(CGPoint(x: 0, y: -self.tableView.contentInset.top), animated: true)
            }
            
            floaty.close()
            
        })
        self.view.addSubview(floaty)
        
        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
            print("viewWillAppear() called")
        
        handleRefresh()
        
    }
    
    
    
    
    //MARK: - selector 메소드
    
    
    
    @objc fileprivate func goToCreateView(){
        print("goToCreateView()")
        // 화면 전환을 발동시킨다.
        performSegue(withIdentifier: "goToCreatePostVC", sender: self)
    }
    
//    @objc fileprivate func rightBtnClicked(){
//        print("rightBtnClicked()")
//    }
    
    @objc fileprivate func handleRefresh(){
        print("handleRefresh 호출됨")
        posts.removeAll()
        
        self.page = 1
        loadMoreData(page: page)
    }
    
    //MARK: - fileprivate 메소드
    
    fileprivate func loadMoreData(page: Int){
        print("loadMoreData 호출됨")
        
        self.page = page + 1
        
        let parameters = ["page": String(page)]
        
        // 싱글턴 적용 api get 메소드 호출
        ApiService.shared.getRequest(url: Constants.API.GET_POSTS, parameters: parameters, success: {
            
            response in
            
            print("싱글턴 response : \(response)")
            
            let jsonArray = response["data"]
            
            print("jsonArray.count : \(jsonArray.count)")
            
            // If json is .Array
            // The `index` is 0..<json.count's string value
            for (index,subJson):(String, JSON) in jsonArray {
                // Do something you want
                
//                print("subJson title : \(subJson["title"])")

                let id = subJson["id"].stringValue
                
                // 포스팅 배열에 넣는다.
                self.posts.append(Post(id: subJson["id"].stringValue, title: subJson["title"].stringValue, body: subJson["body"].stringValue))
                
                
//                print("싱글턴 포스팅 배열에 들어있다. : \(self.posts.count)")
            }
            
            self.tableView.reloadData()
            self.tableView?.refreshControl?.endRefreshing()
            
        }, failure: {
            
            errorResponse in
            
            print("싱글턴 errorResponse : \(errorResponse)")
            
        })
        
        
    }
    
    
    //MARK: - 테이블뷰 델리겟 메소드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        self.selectedPost = posts[indexPath.row]
        
//        let vc = PostDetailViewController(nibName: "PostDetailViewController", bundle: nil)
//
//        vc.post = self.selectedPost
//
//        navigationController?.pushViewController(vc, animated: true)
        
        // 화면 전환을 발동시킨다.
        performSegue(withIdentifier: "goToPostDetailVC", sender: self)
        
        
        
        
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 100
//    }
    
    // 즉 쎌을 랜더링 한다
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        
        
        
        cell.title.text = self.posts[indexPath.row].title as String
        cell.body.text = self.posts[indexPath.row].body as String
        
//        containerView.layer.cornerRadius = cornerRadius
        
        cell.bgView.layer.cornerRadius = 15
        
        cell.bgView.backgroundColor = .white
        
        // set the shadow of the view's layer
        cell.bgView.layer.shadowColor = #colorLiteral(red: 0.4313471503, green: 0.4313471503, blue: 0.4313471503, alpha: 1)
        cell.bgView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cell.bgView.layer.shadowOpacity = 0.8
        cell.bgView.layer.shadowRadius = 10.0
        
        cell.selectionStyle = .none
        
        // Check if the last row number is the same as the last current data element
       if indexPath.row == self.posts.count - 1 {
        self.loadMoreData(page: self.page)
       }
        
        
        return cell
    }
    
    
    // 화면을 넘기는 부분이다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "goToPostDetailVC"){
            
            var vc = segue.destination as! PostDetailViewController
            
            print("세그웨이로 넘어왔다. selectedPost.title : \(selectedPost?.title)")
            
            vc.post = self.selectedPost
        }
        

    }


}

