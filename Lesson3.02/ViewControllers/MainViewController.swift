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
}

class MainViewController: UICollectionViewController {

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
        
    }
    
    private func fetchCourses() {
        guard let url = URL(string: Link.coursesURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let courses = try decoder.decode([Course].self, from: data)
                print(courses)
                DispatchQueue.main.async {
                    self?.showAlert(withStatus: .success)
                }
            } catch let error {
                DispatchQueue.main.async {
                    self?.showAlert(withStatus: .failed)
                }
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    private func fetchInfoAboutUs() {
        guard let url = URL(string: Link.aboutUsURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let info = try decoder.decode(SwiftBookInfo.self, from: data)
                print(info)
                DispatchQueue.main.async {
                    self?.showAlert(withStatus: .success)
                }
            } catch let error {
                DispatchQueue.main.async {
                    self?.showAlert(withStatus: .failed)
                }
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    private func fetchInfoAboutUsWithEmptyFields() {
        guard let url = URL(string: Link.aboutUsURL2.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let info = try decoder.decode(SwiftBookInfo.self, from: data)
                print(info)
                DispatchQueue.main.async {
                    self?.showAlert(withStatus: .success)
                }
            } catch let error {
                DispatchQueue.main.async {
                    self?.showAlert(withStatus: .failed)
                }
                print(error.localizedDescription)
            }
        }.resume()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 32, height: 100)
    }
}
