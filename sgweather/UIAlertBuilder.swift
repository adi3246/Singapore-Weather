//
//  UIAlertBuilder.swift
//  sgweather
//
//  Created by Isa Andi on 02/12/2017.
//  Copyright © 2017 Massive Infinity. All rights reserved.
//

import UIKit

class UIAlertBuilder {
    func showMessage(title: String, msg: String,  controller: UIViewController) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
        
//        uiAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//            uiAlert.dismiss(animated: true, completion: {
//
//            })
//        }))
    }
}
