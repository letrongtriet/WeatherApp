//
//  RootViewModel.swift
//  WeatherApp
//
//  Created by Triet Le on 16.10.2020.
//

import Foundation
import Combine

class RootViewModel {

    // MARK: - Observables
    @Published public private(set) var weather: Weather?
    @Published public private(set) var isLoading: Bool = false

    // MARK: - Public properties
    var bag = Set<AnyCancellable>()

    // MARK: - Private properties
    private let networkManager: NetworkManager
    private var locationId: Int?

    // MARK: - Init
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        startTimer()
    }

    // MARK: - Public methods
    func getWeather(for locationId: Int) {
        self.locationId = locationId
        getWeatherFromTimeToTime()
    }

    // MARK: - Private methods
    private func startTimer() {
        Timer.publish(every: 60, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.getWeatherFromTimeToTime()
            }
            .store(in: &bag)
    }

    private func getWeatherFromTimeToTime() {
        guard let locationId = locationId else { return }

        isLoading = true

        networkManager.getWeatherFor(locationId: locationId).sink { [weak self] completion in
            self?.isLoading = false
        } receiveValue: { [weak self] weather in
            self?.weather = weather
        }
        .store(in: &bag)
    }
    
}
