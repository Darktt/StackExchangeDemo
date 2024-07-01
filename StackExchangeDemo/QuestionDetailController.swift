//
//  QuestionDetailController.swift
//  StackExchangeDemo
//
//  Created by Eden on 2024/7/1.
//

import UIKit

public class QuestionDetailController: UIViewController
{
    // MARK: - Properties -
    
    @IBOutlet private
    weak var titleLabel: UILabel!
    
    @IBOutlet private
    weak var tagLabel: UILabel!
    
    @IBOutlet private
    weak var dateLabel: UILabel!
    
    @IBOutlet private
    weak var scoreLabel: UILabel!
    
    @IBOutlet private
    weak var answersLabel: UILabel!
    
    @IBOutlet private
    weak var viewsLabel: UILabel!
    
    @IBOutlet private
    weak var contentLabel: UILabel!
    
    @IBOutlet private
    weak var contentLoadingView: UIActivityIndicatorView!
    
    @IBOutlet private
    weak var avatarImageView: UIImageView!
    
    @IBOutlet private
    weak var avatarLoadingView: UIActivityIndicatorView!
    
    @IBOutlet private
    weak var ownerNameLabel: UILabel!
    
    @IBOutlet private
    weak var reputationLabel: UILabel!
    
    private
    let store: StackExchangeStore
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public 
    init(with questionId: Int, store: StackExchangeStore)
    {
        self.store = store
        super.init(nibName: "QuestionDetailController", bundle: nil)
        
        self.store.state.questionItem(via: questionId)
    }
    
    internal required
    init?(coder: NSCoder)
    {
        self.store = kStackExchangeStore
        
        super.init(coder: coder)
    }
    
    public override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }
    
    // MARK: View Live Cycle
    
    public override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
    }
    
    public override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
    }
    
    public override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
    }
    
    public override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        
    }
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let questionItem: QuestionItem? = self.store.state.questionItem
        let numberFormatter: NumberFormatter = self.store.state.numberFormatter
        
        let title: String? = questionItem?.title
        let tags: String? = questionItem?.tags.joined(separator: ", ")
        let dateString: String = questionItem?.date?.formatted(date: .long, time: .shortened) ?? ""
        let viewCount: Int = questionItem?.viewCount ?? 0
        let views = numberFormatter.string(from: viewCount as NSNumber)
        
        self.title = title
        self.titleLabel.text = title
        self.tagLabel.text = tags
        self.dateLabel.text = "Asked on \(dateString)"
        self.scoreLabel.text = "\(questionItem?.score ?? 0)"
        self.answersLabel.text = "\(questionItem?.answerCount ?? 0)"
        self.viewsLabel.text = views
        self.contentLoadingView.fluent
            .hidesWhenStopped(true)
            .subject
            .startAnimating()
        self.avatarImageView.image = nil
        self.avatarLoadingView.fluent
            .hidesWhenStopped(true)
            .subject
            .startAnimating()
        self.ownerNameLabel.text = nil
        self.reputationLabel.text = "0"
    }
    
    deinit
    {
        
    }
}

// MARK: - Actions -

private extension QuestionDetailController
{
    
}

// MARK: - Private Methons -

private extension QuestionDetailController
{
    
}
