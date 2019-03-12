//
//  ViewController.swift
//  MyVirtualVet
//
//  Created by Felicity Johnson on 3/11/19.
//  Copyright © 2019 FJ. All rights reserved.
//

import UIKit

private struct Layout {
    static let tableViewWidthMultiplier: CGFloat = 0.85
    static let tableViewCellHeight: CGFloat = 100
    static let signUpTableViewHeight: CGFloat = 480
    static let loginTableViewHeight: CGFloat = 180
    static let tableViewTopOffset: CGFloat = 100
    static let buttonOffset: CGFloat = 20
    static let buttonFontSize: CGFloat = 20
    static let infoButtonFontSize: CGFloat = 12
    static let infoButtonOffset: CGFloat = 5
}

class SignUpLoginViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Private properties
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let signUpLoginButton = UIButton()
    private let changeStateButton = UIButton()
    private var viewModel: SignUpLoginViewModel
    
    init(state: State) {
        viewModel = SignUpLoginViewModel(state: state)
        
        super.init(nibName: nil, bundle: nil)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private funcs
    private func setUpView() {
        
        navigationItem.title = "My Virtual Vet"
        navigationController?.navigationBar.backgroundColor = .lightGray
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .white
        
        tableView.rowHeight = Layout.tableViewCellHeight
        tableView.estimatedRowHeight = Layout.tableViewCellHeight
        tableView.register(TitleDetailTableViewCell.self, forCellReuseIdentifier: "TitleDetailTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(Layout.tableViewWidthMultiplier)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Layout.tableViewTopOffset)
            let height = viewModel.state == .signUp ? Layout.signUpTableViewHeight : Layout.loginTableViewHeight
            make.height.equalTo(height)
        }
        
        signUpLoginButton.setTitle(viewModel.state.buttonText, for: .normal)
        signUpLoginButton.setTitleColor(.black, for: .normal)
        signUpLoginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Layout.buttonFontSize)
        signUpLoginButton.addTarget(self, action: #selector(signUpLoginButtonAction), for: .touchUpInside)
        view.addSubview(signUpLoginButton)
        signUpLoginButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(Layout.buttonOffset)
            make.centerX.equalToSuperview()
        }
        
        changeStateButton.setTitle(viewModel.state.changeStateButtonText, for: .normal)
        changeStateButton.setTitleColor(.black, for: .normal)
        changeStateButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Layout.buttonFontSize)
        changeStateButton.layer.borderColor = UIColor.black.cgColor
        changeStateButton.layer.borderWidth = 2
        changeStateButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        changeStateButton.addTarget(self, action: #selector(changeStateButtonAction), for: .touchUpInside)
        view.addSubview(changeStateButton)
        changeStateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpLoginButton.snp.bottom).offset(Layout.buttonOffset)
        }
    }
    
    @objc private func signUpLoginButtonAction() {
        // navigate to next screen
    }
    
    @objc private func changeStateButtonAction() {
        let rootVC = viewModel.state == .login ? SignUpLoginViewController(state: .signUp) : SignUpLoginViewController(state: .login)
        let navVC = UINavigationController(rootViewController: rootVC)
        present(navVC, animated: false, completion: nil)
    }
    
    // MARK: - Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRow(at: indexPath)
    }
}

