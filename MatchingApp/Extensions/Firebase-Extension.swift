//
//  Firebase-Extension.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/17.
//

import FirebaseAuth
import FirebaseFirestore

// MARK: - Auth
extension Auth {
    
    static func createUserToFireAuth(email: String?, password: String?, name: String?, completion: @escaping (Bool) -> Void) {
        guard let email = email else { return }
        guard let password = password else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (auth, err) in
            if let err = err {
                print("auth createUser err: ", err)
                return
            }
            guard let uid = auth?.user.uid else { return }
            print("auth createUser Success uid: ",uid)
            Firestore.setUserDataToFirestore(uid: uid,email: email, name: name) { success in
                completion(success)
            }
            
            
        }
        
    }
    
    static func loginWithFireAuth(email: String, password: String, completion: @escaping (Bool) -> Void) {

        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print("ログイン失敗: ",err)
                completion(false)
                return
            }
            guard let uid = Auth.auth().currentUser?.uid else { return }
            completion(true)
            print("ログイン成功 uid: ",uid)

        }
    }
    
}

// MARK: - Firestore
extension Firestore {
    
    static func setUserDataToFirestore(uid: String, email: String, name: String?, completion: @escaping (Bool) -> ()) {
        guard let name = name else { return }
        let doc = [
            "name": name,
            "email": email,
            "creatAt": Timestamp()
        ] as [String : Any]
        
        Firestore.firestore().collection("users").document(uid).setData(doc) { (err) in
            if let err = err {
                print("set firestore err: ",err)
                return
            }
            print("set firestore success uid: ", uid)
            completion(true)
        }
        
        
    }
    
    // Firestoreからユーザー情報を取得
    static func fetchUserFromFirestore(uid: String,completion: @escaping (User?) -> Void) {

        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print("ユーザー情報の取得に失敗: ",err)
                completion(nil)
                return
            }
            guard let dic = snapshot?.data() else { return }
//            print("data: ", data)
            let user = User(dic: dic)
            completion(user)
            
        }
        
    }

 
}

