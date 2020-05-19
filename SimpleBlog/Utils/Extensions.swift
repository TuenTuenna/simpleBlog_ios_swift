//
//  Extensions.swift
//  SimpleBlog
//
//  Created by Jeff Jeong on 2020/04/28.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//
import Foundation
import UIKit
import SwiftEntryKit


// Put this piece of code anywhere you like
extension UIViewController {
    
    // 화면 클릭을 감지한다.
    func hideKeyboardSetting() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    // 키보드를 내린다.
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
//    @objc func showSomePopUp(){
////        show(<#T##vc: UIViewController##UIViewController#>, sender: <#T##Any?#>)
//    } 
    
    
    
    
    
    
    @objc func showSomePopUp(){

        print("extension - showSomePopUp() called")

        //MARK:- views
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

//        let message = EKSimpleMessage(title: EKProperty.LabelContent("타이틀"), description: EKProperty.TextFieldContent("컨텐츠"))
//
//        ​let notificationMessage = EKNotificationMessage(simpleMessage: message)


//        self.present(alert, animated: true, completion: nil)

        // Create a basic toast that appears at the top
        var attributes = EKAttributes.centerFloat



        // Set its background to white
        attributes.entryBackground = .color(color: EKColor.init(red: 255, green: 255, blue: 255))

        attributes.displayMode = .dark

        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 10, offset: .zero))



        attributes.screenBackground = .clear



        // Animate in and out using default translation
        attributes.entranceAnimation = .translation


        attributes.exitAnimation = .translation

        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)

        let screenSize: CGRect = UIScreen.main.bounds
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width - 10, height: 10))
        
        SwiftEntryKit.display(entry: titleLabel, using: attributes)

    }
    
 
    
    
    
    
    
}
