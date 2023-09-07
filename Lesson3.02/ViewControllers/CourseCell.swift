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
        
        guard let imageURL = URL(string: course.imageUrl ?? "") else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async { [weak self] in
                self?.courseImage.image = UIImage(data: imageData)
            }
        }
    }
}
