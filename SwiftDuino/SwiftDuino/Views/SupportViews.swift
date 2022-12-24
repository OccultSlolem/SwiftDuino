import SwiftUI
import Foundation

struct NoCameraView: View {
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "camera")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70)
                    .foregroundColor(.gray)
                Image(systemName: "circle.slash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                
                
            }
            Text("No Camera")
                .font(.title)
                .foregroundColor(.gray)
        }
    }
}

struct NoCameraView_Previews: PreviewProvider {
    static var previews: some View {
        NoCameraView()
    }
}
