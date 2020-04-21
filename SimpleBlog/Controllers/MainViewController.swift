//
//  ViewController.swift
//  SimpleBlog
//
//  Created by Jeff Jeong on 2020/04/16.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import UIKit
import Alamofire

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
        
        // 데이터 가져오기
        loadMoreData(page: 1)
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        //
        tableView.refreshControl = refreshControl
        
        // 네비게이션 바 버튼을 추가한다.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToCreateView))
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
        
        // 컴플레션 블락
        AF.request(Constants.API.GET_POSTS, parameters: parameters).responseJSON { response in
                    if let value = response.value as? [String: AnyObject] {
        //                print(value)
                        print(value["data"] as Any)
                        
                        if let array = value["data"] as? NSArray {
                            
                            print(array.count)
                            
                            for obj in array {
                                if let dict = obj as? NSDictionary {
                                    // Now reference the data you need using:
        //                            let title = dict.value(forKey: "title")
        //                            let body = dict.value(forKey: "body")
                                    
                                    guard let title = dict.value(forKey: "title") else { return }
                                    guard let body = dict.value(forKey: "body") else { return }
                                    guard let id = dict.value(forKey: "id") else { return }
                                    print("id: \(id)")
                                    print("title: \(title)")
                                    print("body: \(body)")
                                    
                                    // 포스팅 배열에 넣는다.
                                    self.posts.append(Post(id: "\(id)" , title: title as! String, body: body as! String))
                                    
                                    
                                    print("포스팅 배열에 들어있다. : \(self.posts.count)")
                                    
                                    self.tableView.reloadData()
                                    self.tableView?.refreshControl?.endRefreshing()
        //                            print("title: \(title ?? "")")
        //                            print("body: \(body ?? "")")
                                    
                                }
                            }
                        }
                        
                    }
                    
          
                }
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
    
    
    // 즉 쎌을 랜더링 한다
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        
        cell.title.text = self.posts[indexPath.row].title as String
        cell.body.text = self.posts[indexPath.row].body as String
        
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

