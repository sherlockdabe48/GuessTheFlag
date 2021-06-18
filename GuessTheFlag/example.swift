
//
//import SwiftUI
//
//struct ContentView: View {
//    @State private var showingAlert = false
//
//    var body: some View {
//        ZStack {
//
//            LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//            VStack(spacing: 20) {
//
//                Button("Show Alert") {
//                    self.showingAlert = true
//                }
//                .alert(isPresented: $showingAlert) {
//                    Alert(title: Text("Hello SwiftUI"),message: Text("Swift is the best language!"), dismissButton: .default(Text("OK")))
//                }
//
//
//                Button("Hi") {
//                    print("Tapped")
//                }
//                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                .background(RadialGradient(gradient: Gradient(colors: [Color.gray, Color.black]), center: .bottom, startRadius: 0, endRadius:70)
//                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50))
//
//                Button(action: {
//                    print("Button2 Tapped")
//                }) {
//                    HStack(spacing:10) {
//                        Image(systemName: "pencil")
//                        Text("Edit")
//                    }.frame(width: 100, height: 50)
//                }
//                .background(AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
//                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50))
//
//                Text("Hello, world!").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                Text("This is a wonderful place.")
//            }.foregroundColor(.white)
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
