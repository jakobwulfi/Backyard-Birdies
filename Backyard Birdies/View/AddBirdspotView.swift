//
//  AddBirdspotVIew.swift
//  Backyard Birdies
//
//  Created by dmu mac 31 on 11/12/2024.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore

struct AddBirdspotView: View {
    @Environment(BirdspotController.self) var birdspotController : BirdspotController
    @Environment(LocationController.self) var locationController : LocationController
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var species: Species? = nil
    @State private var note: String = ""
    @State private var location: CLLocationCoordinate2D = CLLocationCoordinate2D()
    @State private var showAlert = false
    @State private var showSuccessAlert = false
    
    var birdImage: Image {
        guard let data = selectedImageData,
              let image = UIImage(data: data) else {
            return Image(systemName: "bird")
        }
        return Image(uiImage: image)
    }
    var body: some View {
        Form {
            VStack {
                birdImage
                    .resizable()
                    .frame(width: 150, height: 150)
                    .background(Color.black.opacity(0.2))
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                PhotosPicker(
                    selection: $selectedPhoto,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Label("Select Photo", systemImage: "photo")
                }
            }
            Picker("Pick a species", selection: $species) {
                ForEach(Species.allCases.sorted(by: { $0.rawValue < $1.rawValue }), id: \.self) { s in
                    Text(s.rawValue).tag(Optional(s))
                }
            }
            
            TextField("Enter Note", text: $note)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Add birdspotting") {
                if species == nil {
                    showAlert = true
                } else {
                    let point = GeoPoint(
                        latitude: locationController.lastLocation.coordinate.latitude,
                        longitude: locationController.lastLocation.coordinate.longitude
                    )
                    
                    let newBirdspot = Birdspot(
                        date: Date.now,
                        location: point,
                        note: note,
                        species: Species(rawValue: (species?.rawValue)!)!,
                        image: selectedImageData ?? UIImage(systemName: "bird")!.pngData()!
                    )
                    birdspotController.add(birdspot: newBirdspot)
                    showSuccessAlert = true
                }
            }
            .fontWeight(.bold)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("You can't add a birdspotting if you haven't picked a species.")
            }
            .alert("Birdspotting Added", isPresented: $showSuccessAlert) {
                Button("OK") {
                    presentationMode.wrappedValue.dismiss()
                }
            } message: {
                Text("Your birdspotting has been added successfully!")
            }
        }
        .onChange(of: selectedPhoto) { oldValue, newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self) {
                    let image = UIImage(data: data)
                    let compression = 0.5
                    let compressedImage = image?.jpegData(compressionQuality: compression)
                    
                    selectedImageData = compressedImage
                }
            }
        }
        .onAppear {
            locationController.startLocationUpdates()
        }
        .padding()
    }
}

#Preview {
    AddBirdspotView()
        .environment(BirdspotController())
        .environment(LocationController())
}
