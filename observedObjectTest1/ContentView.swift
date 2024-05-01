//
//  ContentView.swift
//  observedObjectTest1
//
//  Created by MsMacM on 2024/04/30.
//  https://qiita.com/0102_0102johnny/items/fba13b2e7cfa61d437e9


import SwiftUI

final class DataSource: ObservableObject{
//    監視したい値には@Publishedをつける
    @Published var count = 0
    @Published var omosa = 0
}
//  ボタンをタップするとサークルのカラーが切り替わるメインView
struct ContentView: View {
    // 値型のデータをView自身に保持させるnode@Stateを使用
    @State private var isFire = false
    @ObservedObject private var dataSource = DataSource()
    
    var body: some View {
        VStack {
            Spacer()
            Text("親View")
            // true = 赤色, false = 無色
            isFire == true ?
            Image(systemName: "flame")
                .font(.system(size: 200))
                .foregroundColor(.none)
            :
            Image(systemName: "flame.fill")
                .font(.system(size: 200))
                .foregroundColor(.red)
            
            // 処理を実行するとデータに変更が加えられる為,bodyが再描画される
            // bodyが再描画されると@ObservedObjectのライフサイクルが呼ばれる
            HStack {
                Button("Change") {
                    // isFireのBool値を反転させる
                    isFire.toggle()
                }
                Text("isFire: \(isFire)")
            }
            // 🍏作成した二つのViewを追加
            Spacer()
//            dataSourceをViewに渡す
            ObservedObjectCountView(dataSource: dataSource)
            Spacer()
//            こちらは渡すものはない
            StateObjectCountView()
            Spacer()
//            dataSourceをViewに渡す
            ObservedObjectCountView2(dataSource: dataSource)
            Spacer()

        }
    }}
struct ObservedObjectCountView: View {
    //    DataSource型のdataSourceを引っ張ってくる
    //    ObservedObjectなので、どこかで変更があるとこのViewが変更される
    @ObservedObject var dataSource : DataSource
    
    var body: some View {
        VStack {
            Text("子View")
            Text("ObservedObject count: \(dataSource.count)")
            Text("omosa: \(dataSource.omosa)")
            Button("increment") {
                dataSource.count += 1
            }
            Button("omosa") {
                dataSource.omosa = 100
            }
            
        }
    }
}
struct StateObjectCountView: View {
    @StateObject private var dataSource = DataSource()
    
    var body: some View {
        VStack {
            Text("子View")
            Text("StateObject count: \(dataSource.count)")
            Text("omosa: \(dataSource.omosa)")
            Button("increment") {
                dataSource.count += 1
            }
        }
    }
}
struct ObservedObjectCountView2: View {
    //    DataSource型のdataSourceを引っ張ってくる
    //    ObservedObjectなので、どこかで変更があるとこのViewが変更される
    @ObservedObject var dataSource : DataSource
    
    var body: some View {
        VStack {
            Text("子View")
            Text("ObservedObject count: \(dataSource.count)")
            Text("omosa: \(dataSource.omosa)")
            Button("increment") {
                dataSource.count += 1
            }
            Button("omosa") {
                dataSource.omosa += 100
            }
            
        }
    }
}
#Preview {
    ContentView()
}
