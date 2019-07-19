//
//  DataService.swift
//  breakpoint
//
//  Created by Anthony Cozzi on 7/17/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService{
    
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE: DatabaseReference{
        return _REF_BASE
    }
    var REF_USERS: DatabaseReference{
        return _REF_USERS
    }
    var REF_GROUPS: DatabaseReference{
        return _REF_GROUPS
    }
    var REF_FEED: DatabaseReference{
        return _REF_FEED
    }
    
    func createDBUser(uid: String, userData: Dictionary<String,Any>){
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func uploadPost(withMessage message:String, forUID uid: String, withGroupKey groupKey: String?, completion: @escaping (_ status: Bool) -> ()){
        if groupKey != nil{
            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content" : message, "senderId":uid])
            completion(true)
        }
        else{
            REF_FEED.childByAutoId().updateChildValues(["content":message,"senderId": uid])
            completion(true)
        }
    }
    
    func getUsername (uid:String, handler: @escaping (_ username: String) -> ()){
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot{
                if user.key == uid {handler(user.childSnapshot(forPath: "email").value as! String)}
            }
        }
    }
    
    func getEmails(forGroup group: Group, handler: @escaping (_ emailArray: [String])-> ()){
        var emailArray = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (returnedUserSnapshot) in
            guard let userSnapshot = returnedUserSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot{
                if group.members.contains(user.key){
                    let email = user.childSnapshot(forPath: "email").value as! String
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func getAllFeedMessages(handler: @escaping (_ messages: [Message]) -> ()){
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else{return}
            for message in feedMessageSnapshot{
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let message = Message(content: content, senderId: senderId)
                messageArray.append(message)
            }
            handler(messageArray)
        }
    }
    
    func getAllMessages(forGroup group: Group, handler: @escaping (_ messageArray: [Message])-> ()){
        var messageArray = [Message]()
        REF_GROUPS.child(group.key).child("messages").observeSingleEvent(of: .value) { (messageSnapshot) in
            guard let groupMessageSnapshot = messageSnapshot.children.allObjects as? [DataSnapshot] else {return}
            print (groupMessageSnapshot.count)
            for message in groupMessageSnapshot{
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let message = Message(content: content, senderId: senderId)
                messageArray.append(message)
            }
            handler(messageArray)
        }
    }
    
    func getEmail(forSearchQuery query: String, handler: @escaping (_ emailArray: [String]) -> ()){
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot{
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) && email != Auth.auth().currentUser?.email{
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func getIds(forUsernames usernames: [String],handler: @escaping (_ uidArray: [String]) -> ()){
        var idArray = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (returnedUserSnapshot) in
            guard let userSnapshot = returnedUserSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot{
                let email = user.childSnapshot(forPath: "email").value as! String
                if usernames.contains(email) {idArray.append(user.key)}
            }
            handler(idArray)
        }
    }
    
    func createGroup(withTitle title:String, andDescription description:String, andUserIds userIds: [String], handler: @escaping (_ groupCreated: Bool) -> ()){
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "members":userIds])
        handler(true)
    }
    
    func getAllGroups(handler: @escaping (_ groupList: [Group]) -> ()){
        var groupList = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (returnGroupSnapshot) in
            guard let groupSnapshot = returnGroupSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for group in groupSnapshot{
                let memberArray = group.childSnapshot(forPath: "members").value as! [String]
                if memberArray.contains((Auth.auth().currentUser?.uid)!){
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let desc = group.childSnapshot(forPath: "description").value as! String
                    let group = Group(title: title, description: desc, key: group.key, memberCount: memberArray.count, members: memberArray)
                    groupList.append(group)
                }
            }
            handler(groupList)
        }
    }
}
