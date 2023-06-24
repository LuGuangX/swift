import SwiftUI  
import UIKit  
  
struct ContentView: View {  
      
    @State private var image: UIImage?  
    @State private var showImagePicker = false  
    @State private var showCamera = false  
      
    var body: some View {  
        VStack {  
            Button(action: {  
                self.showImagePicker = true  
            }) {  
                Text("Open Image")  
            }  
            Button(action: {  
                self.showCamera = true  
            }) {  
                Text("Take Photo")  
            }  
        }  
        .sheet(isPresented: $showImagePicker) {  
            ImagePicker(image: self.$image, showImagePicker: self.$showImagePicker, showCamera: self.$showCamera)  
        }  
        .sheet(isPresented: $showCamera) {  
            CameraView(showCamera: self.$showCamera, image: self.$image)  
        }  
    }  
}  
  
struct ImagePicker: UIViewControllerRepresentable {  
      
    @Binding var image: UIImage?  
    @Binding var showImagePicker: Bool  
    @Binding var showCamera: Bool  
      
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {  
        let picker = UIImagePickerController()  
        picker.delegate = context.coordinator  
        return picker  
    }  
      
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {  
          
    }  
      
    func makeCoordinator() -> Coordinator {  
        Coordinator(self)  
    }  
      
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {  
          
        let parent: ImagePicker  
          
        init(_ parent: ImagePicker) {  
            self.parent = parent  
        }  
          
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {  
            if let image = info[.originalImage] as? UIImage {  
                self.parent.image = image  
            }  
            self.parent.showImagePicker = false  
            self.parent.showCamera = false  
        }  
          
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {  
            self.parent.showImagePicker = false  
            self.parent.showCamera = false  
        }  
    }  
}  
  
struct CameraView: UIViewControllerRepresentable {  
      
    @Binding var showCamera: Bool  
    @Binding var image: UIImage?  
      
    func makeUIViewController(context: Context) -> UIImagePickerController {  
        let picker = UIImagePickerController()  
        picker.delegate = context.coordinator  
        picker.sourceType = .camera  
        return picker  
    }  
      
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {  
          
    }  
      
    func makeCoordinator() -> Coordinator {  
        Coordinator(self)  
    }  
      
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {  
          
        let parent: CameraView  
          
        init(_ parent: CameraView) {  
            self.parent = parent  
        }  
          
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {  
            if let image = info[.originalImage] as? UIImage {  
                self.parent.image = image  
            }  
            self.parent.showCamera = false  
        }  
          
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {  
            self.parent.showCamera = false  
        }  
    }  
}  
  
struct ContentView_Previews: PreviewProvider {  
    static var previews: some View {  
        ContentView()  
    }  
}  
