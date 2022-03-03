//
//  AppState.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 03/03/2022.
//

import Foundation

final class AppState : ObservableObject {
    @Published var rootViewId = UUID()
}
