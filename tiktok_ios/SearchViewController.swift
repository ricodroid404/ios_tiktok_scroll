import UIKit

class SearchViewController: UIViewController {
    
    let searchContainerView = UIView()
    let searchTextView = UITextView()
    let searchButton = UIButton(type: .system)
    let tagsStackView = UIStackView()
    let backButton = UIButton(type: .system)
    let headerContainerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        layoutViews()
    }
    
    private func setupViews() {
        // Header Container View Configuration
        headerContainerView.backgroundColor = .white
        
        // Header Container View Configuration
        view.addSubview(headerContainerView)
        headerContainerView.addSubview(backButton)
        headerContainerView.addSubview(searchContainerView)
    
        // Search Container View Configuration
        searchContainerView.backgroundColor = .white
        searchContainerView.layer.cornerRadius = 10
        searchContainerView.layer.borderWidth = 1
        searchContainerView.layer.borderColor = UIColor.lightGray.cgColor
        
        
        // Search Text View Configuration
        searchTextView.isScrollEnabled = true
        searchTextView.showsHorizontalScrollIndicator = true
        searchTextView.showsVerticalScrollIndicator = false
        searchTextView.alwaysBounceVertical = false
        searchTextView.alwaysBounceHorizontal = true
        searchTextView.contentSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: searchTextView.frame.height)
        searchTextView.textContainer.widthTracksTextView = false

        // Search Button Configuration
        searchButton.setTitle("検索", for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        // Tags Stack View Configuration
        tagsStackView.axis = .horizontal
        tagsStackView.alignment = .center
        tagsStackView.distribution = .fillProportionally
        tagsStackView.spacing = 8
        
        // Add tags to the stack view with an action
        let tags = ["食事療法", "筋力トレーニング", "気象病", "FCS カウンセリング", "運動療法"]
        for tag in tags {
            let tagButton = UIButton(type: .system)
            tagButton.setTitle(tag, for: .normal)
            tagButton.backgroundColor = UIColor.systemBlue
            tagButton.setTitleColor(.white, for: .normal)
            tagButton.layer.cornerRadius = 14
            tagButton.clipsToBounds = true
            tagButton.addTarget(self, action: #selector(tagButtonTapped(_:)), for: .touchUpInside)
            tagsStackView.addArrangedSubview(tagButton)
            tagButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        }
        
        // Configure the back button
               backButton.setImage(UIImage(named: "backIcon"), for: .normal)
               backButton.tintColor = .blue // Set the tint color if needed
               backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
               
               // Add the back button to the view
               view.addSubview(backButton)
        
        // Add subviews to search container
        searchContainerView.addSubview(searchTextView)
        searchContainerView.addSubview(searchButton)
        
        // Add subviews to view
        view.addSubview(searchContainerView)
        view.addSubview(tagsStackView)
    }
    
    @objc private func backButtonTapped() {
            // Define the action for the back button tap
            // For instance, dismiss the current view controller or pop it from the navigation stack
            self.dismiss(animated: true, completion: nil)
        }
    
    private func layoutViews() {
        headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        searchContainerView.translatesAutoresizingMaskIntoConstraints = false
        searchTextView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        tagsStackView.translatesAutoresizingMaskIntoConstraints = false

        // Header Container View Constraints
        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // Back Button Constraints
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
            backButton.centerYAnchor.constraint(equalTo: headerContainerView.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 25)
        ])

        // Search Container View Constraints
        NSLayoutConstraint.activate([
            searchContainerView.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 8),
            searchContainerView.centerYAnchor.constraint(equalTo: headerContainerView.centerYAnchor),
            searchContainerView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            searchContainerView.heightAnchor.constraint(equalToConstant: 50),
            headerContainerView.bottomAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant: 8)  // This ensures the headerContainerView's height is dynamic
        ])

        // Search TextView Constraints
        NSLayoutConstraint.activate([
            searchTextView.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor, constant: 8),
            searchTextView.topAnchor.constraint(equalTo: searchContainerView.topAnchor, constant: 8),
            searchTextView.bottomAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant: -8),
            searchTextView.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -8)
        ])

        // Search Button Constraints
        NSLayoutConstraint.activate([
            searchButton.trailingAnchor.constraint(equalTo: searchContainerView.trailingAnchor, constant: -8),
            searchButton.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 60)
        ])

        // Tags Stack View Constraints
        NSLayoutConstraint.activate([
            tagsStackView.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: 20),
            tagsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tagsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    
    @objc private func searchButtonTapped() {
        // Perform the search action
        print("検索ボタン")
        let searchResultsVC = SearchResultsViewController()
        // myListVC.modalPresentationStyle = .fullScreen // iOS 13以降では、モーダルの全画面表示を指定する場合。
        searchResultsVC.modalPresentationStyle = .fullScreen
        present(searchResultsVC, animated: false, completion: nil)
    }
    
    private func updateTextViewContentSize() {
        // Set the text container's height to match the UITextView height
        let fixedHeight = searchTextView.frame.size.height
        searchTextView.textContainer.size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: fixedHeight)
        // Calculate the right width for the content
        let newSize = searchTextView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: fixedHeight))
        searchTextView.contentSize = CGSize(width: newSize.width, height: fixedHeight)
    }
    
    @objc private func tagButtonTapped(_ sender: UIButton) {
        if let tagTitle = sender.titleLabel?.text {
            // Paddingを加えたタグ文字列
            let tagString = " \(tagTitle) "
            let attributes: [NSAttributedString.Key: Any] = [
                .backgroundColor: UIColor.systemBlue, // 濃い水色の背景
                .foregroundColor: UIColor.white, // 白色のテキスト
                .font: UIFont.systemFont(ofSize: 14) // フォントサイズは適宜調整
            ]
            let attributedString = NSMutableAttributedString(string: tagString, attributes: attributes)
            
            // 各タグの後に余白を追加
            let spacing = NSAttributedString(string: " ", attributes: [.font: UIFont.systemFont(ofSize: 14)])
            
            if let textViewText = searchTextView.attributedText {
                let mutableAttributedString = NSMutableAttributedString(attributedString: textViewText)
                mutableAttributedString.append(spacing) // タグ間のスペースを追加
                mutableAttributedString.append(attributedString)
                searchTextView.attributedText = mutableAttributedString
            } else {
                searchTextView.attributedText = attributedString
            }
        }
        updateTextViewContentSize()
    }


}

// Usage in AppDelegate or SceneDelegate
// let viewController = SearchViewController()
// window?.rootViewController = viewController
