//
//  Popup.swift
//  SimpleBlog
//
//  Created by Jeff Jeong on 2020/05/06.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import Foundation
import SwiftEntryKit

struct Popup {
    static func show(title: String, body: String, action: @escaping () -> Void) {
        var attributes = EKAttributes.centerFloat
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

        let label = EKProperty.LabelContent(text: "OK", style: .init(font: UIFont(), color: .black))
        let button = EKProperty.ButtonContent(label: label, backgroundColor: .white, highlightedBackgroundColor: .standardBackground)
        let action: EKPopUpMessage.EKPopUpMessageAction = {
            SwiftEntryKit.dismiss()
            // ここにボタン押下時のアクションを入れることができる
            action()
        }
        let popupMessage = EKPopUpMessage(title: title, description: description, button: button, action: action)
        let view = EKPopUpMessageView(with: popupMessage)

        SwiftEntryKit.display(entry: view, using: attributes)
    }
}
