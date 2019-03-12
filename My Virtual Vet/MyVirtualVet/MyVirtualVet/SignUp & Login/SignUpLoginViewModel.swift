//
//  SignUpLoginViewModel.swift
//  MyVirtualVet
//
//  Created by Felicity Johnson on 3/11/19.
//  Copyright © 2019 FJ. All rights reserved.
//

import UIKit

enum State {
    case login, signUp
    
    var cellTitles: [String] {
        switch self {
            case .login: return ["Username", "Password"]
            case .signUp: return ["Username", "Password", "Confirm Password", "Animal Type", "Vet Practice Code"]
        }
    }
    
    var cellDetails: [String] {
        switch self {
            case .login: return ["Required", "Required"]
            case .signUp: return ["Required", "Required", "Required", "Required", "Required"]
        }
    }
    
    var buttonText: String {
        switch self {
            case .login: return "LOGIN"
            case .signUp: return "SIGN UP"
        }
    }
    
    var changeStateButtonText: String {
        switch self {
        case .login: return "New to My Virtual Vet? SIGN UP"
        case .signUp: return "Already a user? LOGIN"
        }
    }
}

final class SignUpLoginViewModel {
    
    // MARK: - Public properties
    var state: State
    
    init(state: State) {
        self.state = state
    }
    
    // MARK: - Public funcs
    func numOfRows() -> Int {
        return state.cellTitles.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> UITableViewCell {
        let title = state.cellTitles[indexPath.row]
        let details = state.cellDetails[indexPath.row]
        
        let cell = TitleDetailTableViewCell(frame: .zero)
        cell.titleText = title
        cell.detailsText = details
        
        return cell
    }
}
