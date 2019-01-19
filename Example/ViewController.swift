//
//  ViewController.swift
//  Example
//
//  Created by Fabio Felici on 5/4/17.
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
