//
//  ListViewController.swift
//  Transition
//
//  Created by CJ on 2017/7/5.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    let transitionManager = TransitionManager()
    
    var lists = [String]()
    
    fileprivate struct Config {
        static let cellID = "ImageCell"
    }
    
    // 懒加载 collectionView
    public lazy var collectionView:UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout();
        
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - 35), collectionViewLayout: flowLayout)
        
        collectionView.backgroundColor = UIColor.black
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: Config.cellID, bundle: Bundle.main), forCellWithReuseIdentifier: Config.cellID)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = transitionManager
        
        for i in 1...12 {
            lists.append("\(i).jpg")
        }
        
        view.addSubview(collectionView)
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension ListViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Config.cellID, for: indexPath) as! ImageCell
        
        cell.imageName = lists[indexPath.row]
        
        return cell
    }
    
    // 设置 CollectionViewCell 的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.bounds.width / 2 - 10, height: (view.bounds.width / 2 - 10) * 1.5)
    }
}









