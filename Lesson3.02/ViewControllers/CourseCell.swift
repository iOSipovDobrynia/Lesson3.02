//
//  CourseCell.swift
//  Lesson3.02
//
//  Created by Goodwasp on 07.09.2023.
//

import UIKit

class CourseCell: UITableViewCell {
    @IBOutlet var courseImage: UIImageView!
    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var numberOfLessons: UILabel!
    @IBOutlet var numbersOfTests: UILabel!
    
    func configure(withCourse course: Course) {
        courseNameLabel.text = course.name
        numberOfLessons.text = "Number of lessons: \(course.number_of_lessons ?? 0)"
        numbersOfTests.text = "Number of tests: \(course.number_of_tests ?? 0)"
    }
}
