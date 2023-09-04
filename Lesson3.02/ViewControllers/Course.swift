//
//  Course.swift
//  Lesson3.02
//
//  Created by Goodwasp on 04.09.2023.
//

struct Course: Decodable {
    let name: String
    let imageUrl: String
    let number_of_lessons: Int
    let number_of_tests: Int
}
