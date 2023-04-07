//
//  URLImage.swift
//  myMealsApp
//
//  Created by Yolanda Chigiji on 4/13/23.
//

import Foundation
import SwiftUI


struct URLImage: View {
    @ObservedObject private var imageLoader: ImageLoader

    init(urlString: String) {
        imageLoader = ImageLoader(urlString: urlString)
    }

    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            ProgressView()
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    init(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
