//
//  ViewController.swift
//  MemeGenerator
//
//  Created by Julian Silvestri on 2025-04-02.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var memeImage: UIImageView!
}


class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var memCollectionView: UICollectionView!
    
    var countOfCells = 0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        NetworkService.sharedService.getMemes(completionHandler: {result in
//            if(result == true){
//                print("SUCCESS !")
//                self.countOfCells = MemeModel.dataResults.count
//            } else {
//                self.showError()
//            }
//        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        memCollectionView.dataSource = self
        memCollectionView.delegate = self
    }
    
    func showError(){
        DispatchQueue.main.async{
            let errorAlert = UIAlertController(title: "Error", message: "Could not load memes", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: .default) )
            self.present(errorAlert, animated: true)
        }

    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("COUNT OF CELLS -> \(MemeModel.dataResults.count)")
        return MemeModel.dataResults.count
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//     layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        return CGSize(width: 250, height: 250)
//    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memCollectionViewCell", for: indexPath) as! MemeCollectionViewCell

        setImageFromStringrURL(stringUrl: MemeModel.dataResults[indexPath.row].url, imageView: cell.memeImage)
        
        return cell
        
    }
    func setImageFromStringrURL(stringUrl: String, imageView: UIImageView) {
      if let url = URL(string: stringUrl) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          // Error handling...
          guard let imageData = data else { return }

          DispatchQueue.main.async {
              imageView.image = UIImage(data: imageData)
          }
        }.resume()
      }
    }

}

//extension UIImageView {
//    func setImage(url: URL, placeholder: UIImage?) {
//        self.image = placeholder
//
//        Task { [weak self] in
//            let (data, _) = try await URLSession.shared.data(from: url)
//            self?.image = UIImage(data: data)
//        }
//    }
//}
//
