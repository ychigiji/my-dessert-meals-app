//
//  myMealsAppApp.swift
//  myMealsApp
//
//  Created by Yolanda Chigiji on 4/11/23.
//

import SwiftUI

@main
struct myMealsAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MealListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
