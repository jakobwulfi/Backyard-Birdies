//
//  BirdspotRow.swift
//  Backyard Birdies
//
//  Created by dmu mac 31 on 11/12/2024.
//

import SwiftUI
import MapKit
import CoreLocation
import FirebaseFirestore

struct DetailView: View {
    let birdspot: Birdspot
    
    @State private var cameraPosition = MapCameraPosition.automatic
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    DetailRow(title: "Species", content: birdspot.species.rawValue)
                    DetailRow(title: "Date", content: birdspot.date.formatted(date: .abbreviated, time: .shortened))
                    DetailRow(title: "Note", content: birdspot.note)
                }
                .padding()
                .background(Color(UIColor.systemGroupedBackground))
                .cornerRadius(12)
                .shadow(radius: 5)
                
                Image(uiImage: UIImage(data: birdspot.image)!)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 10)
            }
            
            VStack {
                Map(position: $cameraPosition) {
                    Marker(coordinate: CLLocationCoordinate2D(latitude: birdspot.location.latitude, longitude: birdspot.location.longitude)) {
                        Image(systemName: "bird.fill")
                            .foregroundColor(.blue)
                    }
                }
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 10)
                .onAppear {
                    cameraPosition = .camera(
                        MapCamera(
                            centerCoordinate: CLLocationCoordinate2D(latitude: birdspot.location.latitude, longitude: birdspot.location.longitude),
                            distance: 2500
                        )
                    )
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Birdspot Details")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(UIColor.systemGroupedBackground))
        }
    }




#Preview {
    let testSpot = Birdspot(date: Date.now, location: GeoPoint(latitude: 51.509865, longitude: -0.118092), note: "Test", species: Species.altaria, image: UIImage(systemName: "bird")!.pngData()!)
    DetailView(birdspot: testSpot).environment(BirdspotController())
}
