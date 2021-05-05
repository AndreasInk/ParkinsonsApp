//
//  Social.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/5/21.
//

import SwiftUI

struct User: Hashable, Codable {
    var id: UUID
    var name: String
    var experiments: [Experiment]
    var createdExperiments: [Experiment]
    var posts: [Post]
    var habit: [Habit]?
}

struct Experiment: Hashable, Codable {
    var id: UUID
    var title: String
    var description: String
    var users: [User]
    var groupScore: [PredictedScore]
    var posts: [Post]
    var week: [Week]
    var habit: [Habit]?
}

struct Post: Hashable, Codable {
    var id: UUID
    var title: String
    var text: String
    var createdBy: User
    var comments: [Post]
}

struct Habit: Hashable, Codable {
    var id: UUID
    var title: String
    var date: Date
}
