//
//  TableNodeController.swift
//  TextureSimply
//
//  Created by Di on 2019/2/11.
//

import Foundation
import AsyncDisplayKit

public class TableNodeController<Item>: ASViewController<ASTableNode>, ASTableDataSource, ASTableDelegate {
    
    typealias DataHandle = (([Item]?) -> Void)
    typealias RequestHandle = ((DataHandle?, ASBatchContext?) -> Void)
    
    var itemList: [Item] = []
    
    var requestData: RequestHandle?
    var cellNodeBlock: ((Item?) -> ASCellNodeBlock?)?
    var didSelectRow: ((Item?, IndexPath) -> Void)?
    
    var disableAdjustmentInsets = false
    var tableNodeBackgroundColor = UIColor.white
    var separatorColor = UIColor.lightGray
    var separatorStyle: UITableViewCell.SeparatorStyle = .singleLine
    var tableFooterView = UIView()
    
    public init(_ tableStyle: UITableView.Style = .plain) {
        super.init(node: ASTableNode(style: tableStyle))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }
    
    func prepare() {
        node.dataSource = self
        node.delegate = self
        node.view.separatorStyle = separatorStyle
        node.backgroundColor = tableNodeBackgroundColor
        node.view.separatorColor = separatorColor
        node.view.tableFooterView = tableFooterView
        if #available(iOS 11, *) {
            node.view.contentInsetAdjustmentBehavior = disableAdjustmentInsets ? .never : .automatic
        } else {
            automaticallyAdjustsScrollViewInsets = !disableAdjustmentInsets
        }
    }
    
    // MARK: Handle
    
    func loadData(_ context: ASBatchContext? = nil) {
        requestData?({ [weak self] result in
            self?.loadMoreDataHandle(result ?? [], context)
        }, context)
    }
    
    func loadMoreDataHandle(_ value: [Item], _ context: ASBatchContext? ) {
        insertRows(value)
        context?.completeBatchFetching(true)
    }
    
    func insertRows(_ value: [Item]) {
        var indexPaths: [IndexPath] = []
        for (index, _) in value.enumerated() {
            indexPaths.append(IndexPath(row: index + itemList.count, section: 0))
        }
        itemList.append(contentsOf: value)
        node.insertRows(at: indexPaths, with: .none)
    }
    
    // MARK: ASTableDelegate
    
    public func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    public func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return itemList.count > 0
    }
    
    public func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        loadData(context)
    }
    
    public func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let item = itemList[safe: indexPath.row]
        return cellNodeBlock?(item) ?? { return ASCellNode() }
    }
    
    public func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        let item = itemList[safe: indexPath.row]
        didSelectRow?(item, indexPath)
    }
    
    public func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
}
