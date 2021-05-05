//
//  CardView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI

struct CardView: View {
    @State var image = "doc"
    @State var text = "Share your data with your doctor"
    @State var cta = "Export Data"
  
    @State var open = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color(.lightText))
                .opacity(0.4)
            VStack {
                Spacer()
                HStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    
                }
                HStack {
                    Text(text)
                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .title))
                        .foregroundColor(Color("blue"))
                }
                if cta != ""  {
                    Spacer()
                HStack {
                Button(action: {
                    open = true
                }) {
                    Text(cta)
                        
                        .font(.custom("Poppins-Bold", size: 18, relativeTo: .title))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.horizontal, 92)
                        .background(RoundedRectangle(cornerRadius: 25.0).foregroundColor(Color("blue")))
                } .sheet(isPresented: $open) {
                    if cta == "Share" {
                       // ShareView()
                    } else if cta == "Read More" {
                      //  ReadMore()
                    } else if cta == "Join" {
                        ShareSheet(activityItems: ["Hello World"])
                        
                    }
                }
                    
                   
            }
                }
            } .padding(.horizontal)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
struct ShareSheet: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}
