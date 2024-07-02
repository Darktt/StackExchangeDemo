//
//  QuestionCell.swift
//  StackExchangeDemo
//
//  Created by Darktt on 2024/7/1.
//

import UIKit

public
class QuestionCell: UITableViewCell
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
    
    public
    var question: QuestionItem? {
        
        didSet {
            
            self.updateView()
        }
    }
    
    public
    weak var numberFormatter: NumberFormatter?
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
    }
    
    public
    override func prepareForReuse()
    {
        self.titleLabel.text = nil
        self.tagLabel.text = nil
        self.dateLabel.text = "Asked on "
        self.scoreLabel.text = "0"
        self.answersLabel.text = "0"
        self.viewsLabel.text = "0"
    }
    
    deinit
    {
        
    }
}

// MARK: - Private Method -

extension QuestionCell
{
    private
    func updateView()
    {
        guard let question = self.question,
                let date = question.date,
                let score = question.score,
                let answerCount = question.answerCount,
                let viewCount = question.viewCount else {
            
            return
        }
        
        let dateString = date.formatted(date: .long, time: .shortened)
        let views = self.numberFormatter?.string(from: viewCount as NSNumber) ?? "\(viewCount)"
        
        self.titleLabel.text = question.title
        self.tagLabel.text = question.tags.joined(separator: ", ")
        self.dateLabel.text = "Asked on \(dateString)"
        self.scoreLabel.text = "\(score)"
        self.answersLabel.text = "\(answerCount)"
        self.viewsLabel.text = views
    }
}

// MARK: - Confirm Protocol -

extension QuestionCell: CustomCellRegistrable
{
    public static var cellNib: UINib? {
        
        let nib = UINib(nibName: "QuestionCell", bundle: nil)
        
        return nib
    }
 
    public static var cellIdentifier: String {
        
        return "QuestionCell"
    }
}
