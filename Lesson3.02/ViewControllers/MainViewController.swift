//
//  CollectionViewController.swift
//  Lesson3.02
//
//  Created by Goodwasp on 03.09.2023.
//

import UIKit

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success title"
        case .failed:
            return "Failed title"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "Success message"
        case .failed:
            return "Failed message"
        }
    }
}

enum UserAction: String, CaseIterable {
    case showImage = "Show Image"
    case fetchCourse = "Fetch Course"
    case fetchCourses = "Fetch Courses"
    case aboutSwiftBook = "About SwiftBook"
    case aboutSwiftBook2 = "About SwiftBook 2"
    case showCourses = "Show Courses"
    case postRequestDict = "POST Request Dict"
    case postRequestModel = "POST Request with Model"
}

final class MainViewController: UICollectionViewController {

    // MARK: - Private prop
    private let userActions = UserAction.allCases
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        guard let cell = cell as? UserActionCell else { return UICollectionViewCell() }
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        switch userAction {
        case .showImage:
            performSegue(withIdentifier: "showImage", sender: nil)
        case .fetchCourse:
            fetchCourse()
        case .fetchCourses:
            fetchCourses()
        case .aboutSwiftBook:
            fetchInfoAboutUs()
        case .aboutSwiftBook2:
            fetchInfoAboutUsWithEmptyFields()
        case .showCourses:
            performSegue(withIdentifier: "showCourses", sender: nil)
        case .postRequestDict:
            postRequestWithDict()
        case .postRequestModel:
            postRequestWithModel()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCourses" {
            guard let coursesVC = segue.destination as? CoursesViewController else {
                return
            }
            coursesVC.fetchCourses()
        }
    }
    
    // MARK: - Private methods
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(
            title: status.title,
            message: status.message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func fetchCourse() {
        NetworkManager.shared.fetch(
            Course.self,
            fromUrl: Link.courseURL.rawValue
        ) { [weak self] result in
            switch result {
            case .success(let course):
                print(course)
                self?.showAlert(withStatus: .success)
            case .failure(let error):
                print(error)
                self?.showAlert(withStatus: .failed)
            }
        }
    }
    
    private func fetchCourses() {
        NetworkManager.shared.fetch(
            [Course].self,
            fromUrl: Link.coursesURL.rawValue
        ) { [weak self] result in
            switch result {
            case .success(let courses):
                print(courses)
                self?.showAlert(withStatus: .success)
            case .failure(let error):
                print(error)
                self?.showAlert(withStatus: .failed)
            }
        }
    }
    
    private func fetchInfoAboutUs() {
        NetworkManager.shared.fetch(
            SwiftBookInfo.self,
            fromUrl: Link.aboutUsURL.rawValue
        ) { [weak self] result in
            switch result {
            case .success(let info):
                print(info)
                self?.showAlert(withStatus: .success)
            case .failure(let error):
                print(error)
                self?.showAlert(withStatus: .failed)
            }
        }
    }
    
    private func fetchInfoAboutUsWithEmptyFields() {
        NetworkManager.shared.fetch(
            SwiftBookInfo.self,
            fromUrl: Link.aboutUsURL2.rawValue
        ) { [weak self] result in
            switch result {
            case .success(let info):
                print(info)
                self?.showAlert(withStatus: .success)
            case .failure(let error):
                print(error)
                self?.showAlert(withStatus: .failed)
            }
        }
    }
    
    private func postRequestWithDict() {
        let course = [
            "name": "name",
            "imageUrl": "image",
            "numberOfLessons": "8",
            "numberOfTests": "10"
        ]
        NetworkManager.shared.postRequest(withData: course, toUrl: Link.postRequest.rawValue) { result in
            switch result {
            case .success(let json):
                print(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func postRequestWithModel() {
        let course = Course(name: "na", imageUrl: "im", numberOfLessons: 1, numberOfTests: 2)
        NetworkManager.shared.postRequest2(withData: course, toUrl: Link.postRequest.rawValue) { result in
            switch result {
            case .success(let course):
                print(course)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 32, height: 100)
    }
}
