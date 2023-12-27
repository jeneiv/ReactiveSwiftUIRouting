//
//  ApplicationRoute.swift
//  ReactiveSwiftUIRouting
//
//  Created by Viktor Jenei on 2023. 12. 27..
//

import Foundation
import os

class ApplicationRoute: ObservableObject, Codable {
    enum RootPath: Codable, Hashable {
        case items
        case settigns
    }
    
    private static let userDefaultsKey = "ApplicationRouteUserDefaultsKey"
    @Published var rootPath: RootPath
    
    init(rootPath: RootPath) {
        self.rootPath = rootPath
    }

    // MARK: State Restoration
    
    static func load() -> ApplicationRoute {
        if let data = UserDefaults.standard.value(forKey: ApplicationRoute.userDefaultsKey) as? Data {
            do {
                let route = try JSONDecoder().decode(ApplicationRoute.self, from: data)
                Logger.generic.info("Loading `ApplicationRoute`")
                return route
            } catch {
                Logger.generic.error("Failed to load `ApplicationRoute`")
            }
        }
        return ApplicationRoute(rootPath: .items)
    }
    
    func save() {
        Logger.generic.info("Saving `ApplicationRoute`")
        do {
            let routeData = try JSONEncoder().encode(self)
            UserDefaults.standard.setValue(routeData, forKey: ApplicationRoute.userDefaultsKey)
        } catch {
            Logger.generic.error("Failed to save `ApplicationRoute`")
        }
    }

    // MARK: Codable Implementation
    
    enum CodingKeys: CodingKey {
        case rootPath
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rootPath = try container.decode(RootPath.self, forKey: .rootPath)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rootPath, forKey: .rootPath)
    }
}
