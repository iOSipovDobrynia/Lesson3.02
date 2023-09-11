//
//  CourseCell.swift
//  Lesson3.02
//
//  Created by Goodwasp on 07.09.2023.
//

import UIKit

final class CourseCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet var courseImage: UIImageView!
    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var numberOfLessons: UILabel!
    @IBOutlet var numbersOfTests: UILabel!
    
    // MARK: - Public func
    func configure(withCourse course: Course) {
        courseNameLabel.text = course.name
        numberOfLessons.text = "Number of lessons: \(course.numberOfLessons ?? 0)"
        numbersOfTests.text = "Number of tests: \(course.numberOfTests ?? 0)"
        
        NetworkManager.shared.fetchImage(fromUrl: course.imageUrl) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.courseImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
