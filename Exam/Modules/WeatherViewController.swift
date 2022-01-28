//
//  WeatherViewController.swift
//  Exam
//
//  Created by Kirill Varshamov on 28.01.2022.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    var viewModel: WeatherViewModel = WeatherViewModel(sections: [])

    let networkService = NetworkService()
    let weatherViewModelFactory = WeatherViewModelFactory()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "baseCell")
        return tableView
    }()
    
    let cityTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите название города"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTextField.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(cityTextField)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            cityTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cityTextField.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    
    func searchCity(for cityName: String) {
        networkService.getWeather(for: cityName) { result in
            switch result {
            case .success(let model):
                self.viewModel = self.weatherViewModelFactory.viewModel(from: model)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
                // MARK: обработать свои ошибки, отобразить UIAlertController
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchCity(for: textField.text ?? "")
        textField.text = ""
        return textField.resignFirstResponder()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].rows.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "baseCell", for: indexPath)
        
        let rowModel = viewModel.sections[indexPath.section].rows[indexPath.row]
        
        cell.textLabel?.text = rowModel.title
        cell.detailTextLabel?.text = rowModel.data
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

