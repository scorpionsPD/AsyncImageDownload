import Foundation
import UIKit

public class ImageDowloader {
    
    private let imageCache = NSCache<AnyObject, AnyObject>()
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) ->()) {
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            completion(imageFromCache)
        }
        else{
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                if let image = UIImage(data: data){
                    self.imageCache.setObject(image, forKey: url as AnyObject)
                    completion(image)
                }
            }
        }
    }
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
