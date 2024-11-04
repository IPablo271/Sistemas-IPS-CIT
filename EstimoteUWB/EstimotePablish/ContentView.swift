
//  ContentView.swift
//  EstimoteAPP
//
//  Created by Guillermo Santos Barrios on 5/19/24.
//

import SwiftUI
import EstimoteUWB

struct ContentView: View {
    @ObservedObject
    var uwb = EstimoteUWBManagerExample()
    
    var body: some View {
        VStack {
            // Agregar el logo arriba del texto
            Image("Imagen1") // Asegúrate que el nombre coincida con el de tu imagen en el proyecto
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100) // Ajusta el tamaño según sea necesario
                .padding(.bottom, 10) // Espacio entre la imagen y el texto
            
            Text("Distance 1 \(uwb.distance1)")
            Text("Distance 2 \(uwb.distance2)")
            Text("Distance 3 \(uwb.distance3)")
            
            HStack {
                Text("X: \(uwb.x, specifier: "%.2f")")
                Text("Y: \(uwb.y, specifier: "%.2f")")
            }
        }
        .padding()
        Text("Estimote UWB")
            .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class EstimoteUWBManagerExample: NSObject, ObservableObject {
    private var uwbManager: EstimoteUWBManager?
    let sensor1Id = "fd7d34c180ba4e9610a4439cd205712c"
    //Blanco
    let sensor2Id = "8cc2e0a06f1666b863df2ea773e7ad02" //Cafe
    
    let sensor3Id = "4056668d19dfe5fab47c9e83c82a982b" //Amarillo
    
    @Published var distance1: Float = 0.0
    @Published var distance2: Float = 0.0
    @Published var distance3: Float = 0.0
    @Published var x: Float = 0.0
    @Published var y: Float = 0.0
    

    override init() {
        super.init()
        setupUWB()
    }

    private func setupUWB() {
        print("Estimote setup")
        uwbManager = EstimoteUWBManager(delegate: self,
                                        options: EstimoteUWBOptions(shouldHandleConnectivity: true,
                                                                    isCameraAssisted: false))
        uwbManager?.startScanning()
    }
}

// REQUIRED PROTOCOL
extension EstimoteUWBManagerExample: EstimoteUWBManagerDelegate {
   
    func didUpdatePosition(for device: EstimoteUWBDevice) {
        let id = device.id
        print("Device ID: ")
        switch id {
        case sensor1Id:
            distance1 = device.distance
            break
        case sensor2Id:
            distance2 = device.distance
            break
        case sensor3Id:
            distance3 = device.distance
        default:
            break
        }
        // calcular x,y
        calculatePosition()
        
    }
    func calculatePosition() {
        // Coordenadas de los sensores
        let sensor1 = (x: 0.0, y: 0.0)
        let sensor2 = (x: 4.0, y: 0.0)
        let sensor3 = (x: 2.0, y: 4.0)
        
        let d1 = Double(distance1)
        let d2 = Double(distance2)
        let d3 = Double(distance3)
        
        let x1 = sensor1.x
        let y1 = sensor1.y
        let x2 = sensor2.x
        let y2 = sensor2.y
        let x3 = sensor3.x
        let y3 = sensor3.y
        
        let A = 2 * (x2 - x1)
        let B = 2 * (y2 - y1)
        let C = 2 * (x3 - x1)
        let D = 2 * (y3 - y1)
        
        let E = d1 * d1 - d2 * d2 - x1 * x1 + x2 * x2 - y1 * y1 + y2 * y2
        let F = d1 * d1 - d3 * d3 - x1 * x1 + x3 * x3 - y1 * y1 + y3 * y3
        
        // Resolver para x
        let denominatorX = A * D - B * C
        let numeratorX = E * D - B * F
        let x = denominatorX != 0 ? numeratorX / denominatorX : 0.0
        
        // Resolver para y
        let denominatorY = C * B - A * D
        let numeratorY = E * C - A * F
        let y = denominatorY != 0 ? numeratorY / denominatorY : 0.0
        
        self.x = Float(x)
        self.y = Float(y)
    }




    

   
    
    // OPTIONAL
    func didConnect(to device: UWBIdentifiable) {
        print("Successfully connected to: \(device.publicIdentifier)")
    }
    
    // OPTIONAL
    func didDisconnect(from device: UWBIdentifiable, error: Error?) {
        print("Disconnected from device: \(device.publicIdentifier)- error: \(String(describing: error))")
    }
    
    // OPTIONAL
    func didFailToConnect(to device: UWBIdentifiable, error: Error?) {
        print("Failed to conenct to: \(device.publicIdentifier) - error: \(String(describing: error))")
    }

    // OPTIONAL PROTOCOL FOR BEACON BLE RANGING
//    func didRange(for beacon: EstimoteBLEDevice) {
//        print("Beacon did range: \(beacon)")
//    }
}


