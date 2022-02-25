//
//  ContentView.swift
//  MovieUI
//
//  Created by Joao Victor on 24/02/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portraitUpsideDown)
          
        }
    }
}

struct Home: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVStack(spacing: 15, pinnedViews: [.sectionFooters], content: {
                Section(footer: FooterView()) {
                    HStack {
                        Button(action: {}, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.title2)
                        })
                        Spacer()
                        Button(action: {}, label: {
                            Image(systemName: "bookmark")
                                .foregroundColor(.white)
                                .font(.title2)
                        })
                    }.overlay(
                        Text("Detalhes do Filme")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    )
                        .padding()
                        .foregroundColor(.white)
                    ZStack {
                        //Criando sombra
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.12))
                            .padding()
                            .offset(y: 12)
                        //Adicionando a imagem do filme
                        Image("poster")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(10)
                    }
                    .frame(width: getReact().width / 2.5, height: getReact().height / 2)
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 15, content: {
                        Text("The Batman")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(.white)
                        Text("Matt Reeves")
                            .font(.callout)
                            .foregroundColor(.white)
                            .overlay(
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .offset(x: 30, y: -2),
                                alignment: .trailing
                            )
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], alignment: .leading, content: {
                            ForEach(genre, id: \ .self) {genereText in
                                Text(genereText)
                                    .font(.caption2)
                                    .padding(.vertical, 10)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .background(Color("button"))
                                    .clipShape(Capsule())
                            }
                        })
                            .padding(.top, 20)
                        
                        Text("Sobre o filme")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.vertical)
                        Text(synopsi)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.white)
                    })
                        .padding(.top, 15)
                        .padding(.horizontal)
                        .padding(.leading, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            })
        }).background(.black)
    }
}


struct FooterView: View {
    var body: some View {
        NavigationLink(
            destination: BookingView(), label: {
                Text("Compre o seu Ingresso")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: getReact().width / 2)
                    .background(Color("button"))
                    .cornerRadius(10)
            })
            .shadow(color: Color.white.opacity(0.15), radius: 5, x: 5, y: 5)
            .shadow(color: Color.white.opacity(0.15), radius: 5, x: -5, y: -5)
            
    }
}

extension View {
    func getReact()->CGRect {
        return UIScreen.main.bounds
    }
}
                       
var synopsi = "Batman (The Batman, no original) segue o segundo ano de Bruce Wayne (Robert Pattinson) como o herói de Gotham, causando medo nos corações dos criminosos, levando-o para as sombras de Gotham City. Com apenas alguns aliados de confiança - Alfred Pennyworth (Andy Serkis) e o tenente James Gordon (Jeffrey Wright) - entre a rede corrupta de funcionários e figuras importantes da cidade, o vigilante solitário se estabeleceu como a única personificação da vingança entre seus concidadãos. Mas em uma de suas investigações, Bruce acaba envolvendo o Comissário Gordon e ele mesmo em um jogo de gato e rato ao investigar uma série de maquinações sádicas, uma trilha de pistas enigmáticas, revelando que Charada estava por trás disso tudo. Porém, a investigação acaba o levando a descobrir uma onda de corrupção que envolve o nome de sua família, pondo em risco sua própria integridade e as memórias que tinha sobre seu pai, Thomas Wayne. Conforme as evidências começam a chegar mais perto de casa e a escala dos planos do perpetrador se torna clara, Batman deve forjar novos relacionamentos, desmascarar o culpado e fazer justiça ao abuso de poder e à corrupção que há muito tempo assola Gotham City."
                       
var genre = ["Ação", "Super-herói", "Drama", "Aventura"]
                       
var time = ["11:30", "14:30", "16:15", "20:45"]

struct BookingView: View {
    @State var bookedSeats: [Int] = [1,10,25,30,45,69,60]
    @State var selectedSeats: [Int] = []
    @State var date: Date = Date()
    @State var selectedTime = "11:30"
    
    @Environment(\.presentationMode) var presentaion
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            HStack {
                Button(action: {presentaion.wrappedValue.dismiss()}, label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.white)
                })
                Spacer()
            }
            .overlay(
                Text("Selecione a cadeira")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
            ).padding()
            GeometryReader {reader in
                let width = reader.frame(in: .global).width
                Path {path in
                    path.move(to: CGPoint(x: 0, y:50))
                        path.addCurve(to: CGPoint(x: width, y: 50), control1: CGPoint(x: width / 2, y: 0),
                                       control2: CGPoint(x: width / 2, y:0))
                }
                .stroke(Color.gray, lineWidth: 2)
            }
            .frame(height: 50)
            .padding(.top, 20)
            .padding(.horizontal, 35)
            
            let totalSeats = 60 + 4
            let leftSide = 0..<totalSeats/2
            let rightSide = totalSeats/2..<totalSeats
            
            HStack(spacing: 30) {
                let columns = Array(repeating: GridItem(.flexible(),spacing: 10), count: 4)
                LazyVGrid(columns: columns, spacing: 13, content: {
                    ForEach(leftSide, id: \.self) {index in
                        let seat = index >= 29 ? index - 1 : index
                        SeatView(index: index, seat: seat, selectedSeats: $selectedSeats, bookedSeats: $bookedSeats)
                    }
                })
                LazyVGrid(columns: columns, spacing: 13, content: {
                    ForEach(leftSide, id: \.self) {index in
                        let seat = index >= 35 ? index - 2 : index - 1
                        SeatView(index: index, seat: seat, selectedSeats: $selectedSeats, bookedSeats: $bookedSeats)
                    }
                })
            }
            .padding()
            .padding(.top, 30)
            
            HStack(spacing: 15) {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray)
                    .frame(width: 20, height: 20)
                    .overlay(Image(systemName: "xmark")
                                .font(.caption)
                                .foregroundColor(.gray)
                    )
                Text("Ocupado")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("button"))
                    .frame(width: 20, height: 20)
                
                Text("Livre")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("button"))
                    .background(Color("button"))
                    .frame(width: 20, height: 20)
                
                Text("Selecionado")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            HStack {
                Text("Data:")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                DatePicker("", selection: $date, displayedComponents: .date)
                    .labelsHidden()
            }
            .padding()
            .padding(.top)
            
//            ScrollView(.horizontal, showsIndicators: false, content: {
//                HStack(spacing: 15) {
//                    ForEach(time, id: \ .self) {timing in
//                        Text(timing)
//                            .fontWeight(.bold)
//                            .foregroundColor(.white)
//                            .padding(.vertical)
//                            .padding(.horizontal, 30)
//                            .background(Color("button"))
//                            .cornerRadius(10)
//                        onTapGesture {
//                            selectedTime = timing
//                        }
//                    }
//                }.padding(.horizontal)
//            })
            HStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 10, content: {
                    Text(" \(selectedSeats.count) Cadeiras")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                    Text("R$\(selectedSeats.count * 20) ")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)

                }).frame(width: 100)

                Button(action: {}, label: {
                    Text("Compre o seu Ingresso")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("button"))
                        .cornerRadius(15)
                })
            }.padding().padding(.top, 20)
        })
            .background(.black).ignoresSafeArea()
            .navigationBarHidden(true)
            
    }
}

struct SeatView: View {
    var index : Int
    var seat: Int
            
    @Binding var selectedSeats: [Int]
    @Binding var bookedSeats: [Int]
            
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(bookedSeats.contains(seat) ? Color.gray : Color("button"), lineWidth: 2)
                .frame(height: 30)
                .background(selectedSeats.contains(seat) ? Color("button") : Color.clear)
                .opacity(index == 0 || index == 28 || index == 36 || index == 63 ? 0 : 1)
            if bookedSeats.contains(seat) {
                Image(systemName: "xmark")
                    .foregroundColor(.gray)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if selectedSeats.contains(seat) {
                selectedSeats.removeAll(){(removeSeat) -> Bool in
                    return removeSeat == seat
                }
                return
            }
            selectedSeats.append(seat)
        }
        .disabled(bookedSeats.contains(seat) || index == 0 || index == 28 || index == 35 || index == 63)
    }
        
}


