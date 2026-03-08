import SwiftUI

// ─────────────────────────────────────────────────────────────
//  휴식시간 편성 계산기
//
//  Setup (new Xcode project):
//  1. File › New › Project › iOS App
//  2. Product Name: RestTimeCalculator
//  3. Interface: SwiftUI  |  Language: Swift
//  4. Deployment Target: iOS 17.0
//  5. Delete the generated ContentView.swift
//  6. Drag all .swift files from this folder into the Xcode project group
//  7. Build & run (⌘R)
// ─────────────────────────────────────────────────────────────

@main
struct RestTimeCalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
