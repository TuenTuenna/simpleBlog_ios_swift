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



//        // Create a basic toast that appears at the top
//        var attributes = EKAttributes.topToast
//
//        // Set its background to white
//        attributes.entryBackground = .color(color: .white)
//
//        // Animate in and out using default translation
//        attributes.entranceAnimation = .translation
//        attributes.exitAnimation = .translation
//
//
//
//
////        let customView = UIView()
//
//        var testView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
//        testView.backgroundColor = .blue
//        testView.alpha = 0.5
//        testView.tag = 100
//        testView.isUserInteractionEnabled = true
//
//        /*
//        ... Customize the view as you like ...
//        */
//
//        // Display the view with the configuration
//        SwiftEntryKit.display(entry: testView, using: attributes)

    }
    
    
//    @objc func showSomePopUp(){
//
//        print("extension - showSomePopUp() called")
//
//        // Generate top floating entry and set some properties
//        var attributes = EKAttributes.topFloat
////        attributes.entryBackground = .gradient(gradient: .init(colors: [red, .green], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
//        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))
//        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
//        attributes.statusBar = .dark
//        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
////        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
//
//        let title = EKProperty.LabelContent(text: "titleText", style: .init(font: UIFont.init(), color: .black))
//        let description = EKProperty.LabelContent(text: "descText", style: .init(font: UIFont.boldSystemFont(ofSize: 20), color: .black))
//        let image = EKProperty.ImageContent(image: UIImage(named: "up")!, size: CGSize(width: 35, height: 35))
//        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
//        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
//
//        let contentView = EKNotificationMessageView(with: notificationMessage)
//        SwiftEntryKit.display(entry: contentView, using: attributes)
//
//    }
    
    
    
}
