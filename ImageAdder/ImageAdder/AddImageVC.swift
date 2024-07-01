import Foundation
import UIKit
import PhotosUI

class AddImageVC: UIViewController {
    
    static let name = "AddImageVC"
    static let storyBoard = "AddImage"
    
    class func instantiateFromStoryboard() -> AddImageVC {
        let vc = UIStoryboard(name: AddImageVC.storyBoard, bundle: nil).instantiateViewController(withIdentifier: AddImageVC.name) as! AddImageVC
        return vc
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let collCellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(collCellNib, forCellWithReuseIdentifier: "CollectionViewCell")
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func backButton(){
        let vc = ViewController.instantiateFromStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func plusButtonTapped(_ sender: UITapGestureRecognizer) {
            showImagePicker()
        }
    
    func showImagePicker() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let chooseExistingAction = UIAlertAction(title: "Choose Existing Image", style: .default) { _ in
            self.presentImagePicker()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(chooseExistingAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    /// PHPickerConfiguration and setting delegate of PHPickerViewController to presenting screen
    func presentImagePicker() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 10
        let phPickerVC = PHPickerViewController(configuration: config)
        phPickerVC.delegate = self
        self.present(phPickerVC, animated: true, completion: nil)
    }
    
    @IBAction func uploadButton() {
        
    }
}

extension AddImageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        if indexPath.item == images.count {
            cell.addImageButton.isEnabled = true
            cell.addImageButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        } else {
            cell.addImageButton.isEnabled = false
            cell.imageView.image = images[indexPath.item]
            cell.imageView.contentMode = .scaleAspectFill
            cell.plusBtnV.isHidden = true
            cell.addImageButton.isEnabled = false
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
}

extension AddImageVC: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                    if let image = image as? UIImage {
                        self?.images.append(image)
                        
                        DispatchQueue.main.async {
                            self?.collectionView.reloadData()
                        }
                    } else if let error = error {
                        // Handle error
                        print("Error loading image: \(error)")
                    }
                }
            }
        }
    }
}
