//
//  CheckPermission.swift
//  MatchingApp
//
//  Created by yasuyoshi on 2021/04/22.
//

import Foundation
import Photos

class CheckPermission {

    func checkCamera()  {
        // ユーザーに許可を促す
        // 最初に起動した時に、許可の選択画面が表示される。２回目からは、最初に選択されたものが格納されていて、許可を促す画面は出ない
        PHPhotoLibrary.requestAuthorization { (status) in

            switch(status){
            case .authorized:
                print("authorized")
            case .denied:
                print("denied")
            case .limited:
                print("limited")
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            default:
                break
            }
        }
    }

}
