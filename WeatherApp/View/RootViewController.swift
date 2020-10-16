//
//  RootViewController.swift
//  WeatherApp
//
//  Created by Triet Le on 16.10.2020.
//

import UIKit
import Combine
import SnapKit

class RootViewController: UIViewController {

    // MARK: - Init
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Properties
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    private lazy var updatedDateLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.font = UIFont.italicSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.numberOfLines = 2
        return label
    }()

    private lazy var helsinkiButton: BottomBorderButton = {
        let button = BottomBorderButton()
        button.setTitle("Helsinki", for: .normal)
        button.setTitleColor(UIColor(red: 0.0, green: 84.0 / 255.0, blue: 159.0 / 255.0, alpha: 1.0), for: .normal)
        button.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var londonButton: BottomBorderButton = {
        let button = BottomBorderButton()
        button.setTitle("Lodon", for: .normal)
        button.setTitleColor(UIColor(red: 0.0, green: 84.0 / 255.0, blue: 159.0 / 255.0, alpha: 0.6), for: .normal)
        button.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var locationStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.backgroundColor = .clear

        stackView.addArrangedSubview(helsinkiButton)
        stackView.addArrangedSubview(londonButton)

        return stackView
    }()

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.tintColor = .black
        view.startAnimating()
        return view
    }()

    // MARK: - Private properties
    private let viewModel: RootViewModel
    private var weather: Weather?

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        helsinkiButton.isSelecting = true
        londonButton.isSelecting = false
    }

    // MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(cityLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(updatedDateLabel)
        view.addSubview(locationStackView)
        view.addSubview(loadingIndicator)

        setupConstraints()
    }

    private func setupConstraints() {
        locationStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(80)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        updatedDateLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        loadingIndicator.snp.makeConstraints { make in
            make.top.equalTo(updatedDateLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        binding()
    }

    private func binding() {
        viewModel.getWeather(for: AppPantry.helsinkiLocationId)

        viewModel.$weather.sink { [weak self] weather in
            self?.weather = weather
            self?.updateUI()
        }
        .store(in: &viewModel.bag)

        viewModel.$isLoading.sink { [weak self] isLoading in
            self?.loadingIndicator.isHidden = !isLoading
        }
        .store(in: &viewModel.bag)
    }

    private func updateUI() {
        guard let weather = weather else { return }

        cityLabel.text = weather.title
        temperatureLabel.text = weather.consolidatedWeather.filter({ Calendar.current.isDateInToday($0.applicableDate) }).first?.theTemp.celciusDisplayString
        updatedDateLabel.text = Date().hourMinuteDisplayString
    }

    @objc private func handleButtonTapped(_ sender: BottomBorderButton) {
        if sender == helsinkiButton {
            helsinkiButton.isSelecting = true
            londonButton.isSelecting = false
            viewModel.getWeather(for: AppPantry.helsinkiLocationId)
        } else {
            helsinkiButton.isSelecting = false
            londonButton.isSelecting = true
            viewModel.getWeather(for: AppPantry.londonLocationId)
        }
    }

}
