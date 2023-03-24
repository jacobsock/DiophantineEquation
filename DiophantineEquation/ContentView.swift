//
//  ContentView.swift
//  DiophantineEquation
//
//  Created by Jacob Sock on 3/24/23.
//

import SwiftUI

import SwiftUI

 struct Solution : Identifiable

{
    var id = UUID()
    
    var value : (Int,Int)
    
}

struct ContentView: View {
    @State var numberInput = ""
  //  @State var solutions : [(Int,Int)] = []
    @State var showAlert = false
    @State var solutions : [Solution] = []
    var body: some View {
        VStack {
            Text(" Diophantine Equation Calculator ").font(.title)
            Text("In mathematics, a Diophantine equation is a polynomial equation, usually with two or more unknowns, such that only the integer solutions are sought or studied. we want to find all integers x, y (x >= 0, y >= 0) solutions of a diophantine equation of the form: x2 - 4 * y2 = n").font(.body)
            Text("Directions:").font(.title)
            Text("Input a number below").font(.body)
            VStack{
                TextField("Input Number", text: $numberInput).padding(.all)
                    .fontWeight(.bold).font(.headline)
                    .background(Color.teal)
                    .cornerRadius(10)
            
                Button {
                    if(numberInput == ""){
                        showAlert = true
                    }else{
                        solutions = solequa(Int(numberInput)!)
                    }
                } label: {
                    Text("Calculate")
                }
                
                .padding(.all).background(.gray).cornerRadius(10).opacity(0.5)
                
                Button {

                    numberInput = ""
                    solutions = []

                } label: {
                    Text("Clear input")
                }.padding(.all).background(.gray).cornerRadius(10).opacity(0.5)
        
                
                
                Text("Total number of solutions: \(solutions.count)")
                
                ForEach (solutions){solution in
                    HStack{
                        Text("x: \(solution.value.0)")
                        Text("y: \(solution.value.1)")
                    }
                }
              
                
            }
            .padding()
            
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text("A number was not inputed"),
                message: Text("Please enter a number to use the calculator")
                       )
            
        }
    
    }
}

extension ContentView{
    
    ///This function expects an interger n and computes all solutions for the equation x^2-4*y^2.
    func solequa(_ n: Int) -> [Solution] {
        var solutions = [Solution]()
        
       // We only need to check divisors i up to the square root of n,since if i is greater than sqrt(n), then j = n / i must be less than sqrt(n),and we would have already checked that value of j earlier in the loop.
        for i in 1...Int(sqrt(Double(n))) {
          //we check if i is an integer divisor
            if n % i == 0 {
              //if i is an integer divisor we divide n by i and assign it to j
                let j = n / i
                //The condition (i + j) % 2 == 0 ensures that i and j have the same parity, that is, they are either both even or both odd.
                //This is important because the factorization (x - 2*y) * (x + 2*y) = n requires x - 2*y and x + 2*y to have the same parity in order for x and y to be integers.
                //If i and j have different parity, then x - 2*y and x + 2*y will have opposite parity, and therefore cannot both be integers.
                //Since note  i and j have the same parity, because (i + j) % 2 == 0, j - i is even.
                //For example:
                //x^2 - 4*y^2 = ((i + j) / 2)^2 - 4 * ((j - i) / 4)^2
                // = (i^2 + 2ij + j^2) / 4 - (j^2 - 2ij + i^2) / 4
                // = (i^2 + 2ij + j^2 - j^2 + 2ij - i^2) / 4
                // = 4ij / 4
                // = ij
                if (i + j) % 2 == 0 && (j - i) % 4 == 0 {
                  //if n=i*j and we know i and j are both divisors of n that means the multiple of them is also a divisor
                  //Note that not every pair (i, j) that satisfies n = i * j will necessarily give rise to a valid solution (x, y) to the Diophantine equation x^2 - 4*y^2 = n.
                  //The conditions (i + j) % 2 == 0 and (j - i) % 4 == 0 ensure that the resulting values of x and y are integers, and that they satisfy the equation.
                    let x = (i + j) / 2
                    let y = (j - i) / 4
                    solutions.append(Solution(value:(x,y)))
                }
            }
        }
        return solutions
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
