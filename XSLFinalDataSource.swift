//
//  XSLFinalDataSource.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2019/1/22.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit


class XSLFinalDataSource: XSLPhotoBrowserBaseDataSource {
    /// 弱引用 PhotoBrowser
    weak public var browser: PSPhotoBrowser?
    let cellID = "XSLPhotoBrowserNetWorkCell"
    /// 共有多少项
    public var numberOfItemsCallback: () -> Int

    /// 每一项的图片对象
    public var placehodleImageCallback: (Int) -> UIImage?

    /// 每一项的图片的URL
    public var loadURLImageCallback: (Int) -> String?


    public init(numberOfItems: @escaping () -> Int, placeholder: @escaping (Int) -> UIImage?, urlCallback: @escaping (Int) -> String?) {
        self.numberOfItemsCallback = numberOfItems
        self.placehodleImageCallback = placeholder
        self.loadURLImageCallback = urlCallback
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsCallback()
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! XSLPhotoBrowserNetWorkCell
        let str = loadURLImageCallback(indexPath.item)
        if str?.hasPrefix("http") ?? false {
//            let path = NSHomeDirectory() +
            cell.reloadData(placeholder: placehodleImageCallback(indexPath.item), autoloadURLString: loadURLImageCallback(indexPath.item))
            return cell
        }
        cell.imageView.image = UIImage(named: str ?? "")
        cell.progressView.isHidden = true
        return cell
    }

    public func registerCell(for collectionView: UICollectionView) {
        collectionView.register(XSLPhotoBrowserNetWorkCell.self, forCellWithReuseIdentifier: "XSLPhotoBrowserNetWorkCell")
    }

}
