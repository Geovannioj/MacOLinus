//
//  CalendarCell.swift
//  MiniChallenge
//
//  Created by Gabriel Rodrigues on 25/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

import JTAppleCalendar

class CalendarCell: JTAppleCell {

    @IBOutlet weak var appointmentOnDay: UILabel!
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet weak var selectedCell: UIView!
}
