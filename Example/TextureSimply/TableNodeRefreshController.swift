//
//  TableNodeRefreshController.swift
//  TextureSimply
//
//  Created by Di on 2019/2/11.
//

import Foundation
import AsyncDisplayKit
import TextureSimply
import MJRefresh

public class TableNodeRefreshController<Item>: TableNodeController<Item> {
    
    typealias elementsEqualHandle = ((Item, Item) -> Bool)
    
    var lastRefreshItemList: [Item] = []
    
    var elementsEqual: elementsEqualHandle?
    
    var refreshHeaderEnable = true
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if refreshHeaderEnable {
            node.view.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
                self?.refreshHandle()
            })
        }
        let footer = MJRefreshAutoNormalFooter()
        footer.setTitle("", for: .idle)
        node.view.mj_footer = footer
        node.view.mj_header.beginRefreshing()
    }
    
    func refreshHandle() {
        loadData(nil)
    }
    
    override func loadMoreDataHandle(_ value: [Item], _ context: ASBatchContext?) {
        let refresh = (context == nil)
        node.view.mj_header.endRefreshing()
        node.view.mj_footer.endRefreshing()
        if value.isEmpty {
            node.view.mj_footer.endRefreshingWithNoMoreData()
        }
        if refresh {
            node.view.mj_footer.resetNoMoreData()
            optionalRefreshData(value)
        } else {
            super.loadMoreDataHandle(value, context)
        }
    }
    
    func optionalRefreshData(_ value: [Item]) {
        if lastRefreshItemList.elementsEqual(value, by: { return elementsEqual?($0, $1) ?? false }) == false {
            lastRefreshItemList = value
            itemList = value
            node.reloadData()
        }
    }
    
    public override func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        let noMoreData = tableNode.view.mj_footer.state == .noMoreData
        return itemList.count > 0 && noMoreData == false
    }
    
}
