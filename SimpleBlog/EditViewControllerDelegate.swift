//
//  EditViewControllerDelegate.swift
//  SimpleBlog
//
//  Created by Jeff Jeong on 2020/04/21.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

protocol EditPostViewControllerDelegate
{
    // 포스팅 수정이 완료 되었다.
    func editPostCompleted(editedPostItem: Post)
}
