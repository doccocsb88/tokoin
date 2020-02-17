//
//  TokoinWebview.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class TokoinWebview: UIViewController {
    let urlToPost: String
    private lazy var headerView: UIView = {
        let view = UIView()
        view.forAutoLayout()
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.forAutoLayout()
        button.setImage(UIImage(named: "back_icon"), for: .normal)
        button.addTarget(self, action: #selector(tappedBack(_:)), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.forAutoLayout()
        label.textAlignment = .left
        return label
    }()
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.forAutoLayout()
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        return webView
    }()
    
    init(with urlToPost: String) {
        self.urlToPost = urlToPost
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        load(with: urlToPost)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            if let title = webView.title {
                titleLabel.text = title
            }
        }
    }
    
    func setupViews() {
        initHeaderView()
        initWebView()
    }
    
    private func initWebView() {
        view.addSubview(webView)
        var webConstraint: [NSLayoutConstraint] = [
            webView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ]
        if #available(iOS 11, *) {
          let guide = view.safeAreaLayoutGuide
            webConstraint.append(webView.bottomAnchor.constraint(equalTo: guide.bottomAnchor))
        } else {
            webConstraint.append(webView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        }
        NSLayoutConstraint.activate(webConstraint)
    }
    
    private func initHeaderView() {
        view.addSubview(headerView)
        headerView.addSubview(backButton)
        headerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 44),
            
            backButton.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 8),
            backButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            backButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 4),
            backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),

            titleLabel.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 8)
        ])
    }
    
    private func load(with urlString: String) {
      let myURL = URL(string: urlString)
      let myRequest = URLRequest(url: myURL!)
      webView.load(myRequest)
    }
    
    @objc func tappedBack(_ button: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
