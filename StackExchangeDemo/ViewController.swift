//
//  ViewController.swift
//  StackExchangeDemo
//
//  Created by Eden on 2024/6/27.
//

import UIKit
import Combine

public
class ViewController: UIViewController
{
    // MARK: - Properties -
    
    @IBOutlet private
    weak var tableView: UITableView!
    
    private
    let store: StackExchangeStore
    
    private
    var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public
    init()
    {
        self.store = kStackExchangeStore
        
        super.init(nibName: "ViewController", bundle: nil)
    }
    
    required
    init?(coder: NSCoder) 
    {
        self.store = kStackExchangeStore
        
        super.init(coder: coder)
    }
    
    public override
    func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Top Questions"
        self.tableView.fluent
            .dataSource(self)
            .delegate(self)
            .rowHeight(UITableView.automaticDimension)
            .estimatedRowHeight(UITableView.automaticDimension)
            .register(QuestionCell.self)
            .discardResult
        
        self.setupSubscribes()
        self.fetchQuestions()
    }
    
    deinit
    {
        self.cancellables.forEach { $0.cancel() }
    }
}

// MARK: - Private Methods -

private
extension ViewController
{
    func setupSubscribes()
    {
        self.store
            .$state
            .throttle(for: 1.0, scheduler: DispatchQueue.main, latest: false)
            .sink { [weak self] state in
                
                self?.updateView(with: state)
            }
            .store(in: &self.cancellables)
    }
    
    func fetchQuestions()
    {
        let request = QuestionsRequest()
        let action = StackExchangeAction.fetchTopQuestions(request)
        
        self.store.dispatch(action)
    }
    
    func fetchNextPage()
    {
        let currentPage = self.store.state.page
        var request = QuestionsRequest()
        request.page = currentPage + 1
        
        let action = StackExchangeAction.fetchTopQuestions(request)
        
        self.store.dispatch(action)
    }
    
    func updateView(with state: StackExchangeState)
    {
        self.tableView.reloadData()
        
        if let error = state.error {
            
            self.presentErrorAlert(with: error)
        }
    }
    
    func presentErrorAlert(with error: StackExchangeError)
    {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        let alertController = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Delegate Methods -
// MARK: - UITableViewDataSource -

extension ViewController: UITableViewDataSource
{
    public
    func numberOfSections(in tableView: UITableView) -> Int
    {
        1
    }
    
    public
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        self.store.state.topQuestions.count
    }
    
    public
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(QuestionCell.self, for: indexPath) {
            
            let numberFormatter = self.store.state.numberFormatter
            let question = self.store.state.topQuestions[indexPath.row]
            
            cell.numberFormatter = numberFormatter
            cell.question = question
            
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate -

extension ViewController: UITableViewDelegate
{
    public 
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        guard !self.store.state.endOfPage else {
            
            return
        }
        
        let numberOfQuestions = self.store.state.topQuestions.count
        let index: Int = indexPath.row
        
        if index == (numberOfQuestions - 1) {
            
            self.fetchNextPage()
        }
    }
    
    public
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        let question = self.store.state.topQuestions[indexPath.row]
//        
//        let detailVC = QuestionDetailViewController(question: question)
//        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
