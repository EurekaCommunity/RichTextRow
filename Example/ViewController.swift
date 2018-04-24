//
//  ViewController.swift
//  Example
//
//  Created by Fabio Felici on 5/4/17.
//  Copyright © 2017 HubSpot. All rights reserved.
//

import UIKit
import Eureka
import RichTextRow

class ViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ RichTextRow() {
            $0.title = "Placeholder"
        }
    }
}
