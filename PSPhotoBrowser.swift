//
//  PSPhotoBrowser.swift
//  Hero
//
//  Created by 廖佩志 on 2019/7/31.
//

import UIKit
import Hero
enum PSHeroType {
    case fade
    case zoom
}
class PSPhotoBrowser: UIViewController, UICollectionViewDelegate {

    var pageCounts: Int
    var heroIds: [String] = ["cell1", "cell2"]
    let photoSpacing: CGFloat = 8

    public lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = photoSpacing
        layout.itemSize = view.bounds.size
        return layout
    }()
    public lazy var collectionView: UICollectionView = {
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionV.backgroundColor = UIColor.clear
        collectionV.showsVerticalScrollIndicator = false
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.isPagingEnabled = true
        collectionV.alwaysBounceVertical = false
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.frame = view.bounds
        collectionV.frame.size.width = view.bounds.width + photoSpacing
        collectionV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: photoSpacing)
        collectionV.register(XSLBaseCollectionViewCell.self, forCellWithReuseIdentifier: "XSLBaseCollectionViewCell")
        return collectionV
    }()
    /// 初始化，如果需要hero动画，需要传入对应的id，能不能默认分配一个id，以cell的
    init(pageCounts: Int) {
        self.pageCounts = pageCounts
        super.init(nibName: nil, bundle: nil)
        self.hero.isEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension PSPhotoBrowser: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageCounts
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XSLBaseCollectionViewCell", for: indexPath)
        cell.contentView.hero.id = heroIds[indexPath.item]
        return cell
    }
}
