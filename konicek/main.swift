//
//  main.swift
//  konicek
//
//  Created by Janko on 02/12/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//


import Foundation
////////////////////////////////////////////////////////////////////////////////
//MARK: - Poznámky

//implementace bonusového úkolu do ALG3

//brute-force (s lehkou optimalizací na nejlepší pohyb jezdce)

// INPUT: velikost sachovnice pro velikost n => [n][n]()
// OUTPUT: vypis sachovnice jako pole navstivenych pozic

//TODO: - Přepsat na čitelnější || verzi psáno ve 3 ráno


////////////////////////////////////////////////////////////////////////////////
//MARK: - Globální proměnné

var vysledek = [[Int]]()
//var testCounter = 0

// nejlepsi pohyb
let moznyPohyb = [[2,1], [1,2], [-1,2], [-2,1], [-2,-1], [-1,-2], [1,-2], [2,-1]]


////////////////////////////////////////////////////////////////////////////////
//MARK: - POMOCNÉ FUNKCE

// Test zda jezdec může vstoupit na políčko
func pohybTest(souradnice: (x: Int, y: Int), velikost n: Int, sachovnice: inout [[Int]]) -> Bool {
    let x = souradnice.x
    let y = souradnice.y
    if(x >= 0 && y >= 0 && x < n && y < n && sachovnice[x][y] == 0){
        return true
    }
    else{
        return false
    }
}

//backtracking řešení
func reseni(sachovnice: inout [[Int]], pozice: (x: Int, y: Int), velikost n: Int, tahy: Int) -> Bool {
    if (tahy == n*n-1) {
        return true
    }
    if tahy == 0{
        sachovnice[0][0] = 1
    }
    for p in moznyPohyb{
        //testCounter += 1
        let x: Int = p[0] + pozice.x
        let y: Int = p[1] + pozice.y
        if pohybTest(souradnice: (x , y), velikost: sachovnice.count, sachovnice: &sachovnice){
            
            sachovnice[x][y] = 1
            if reseni(sachovnice: &sachovnice, pozice: (x,y), velikost: n, tahy: tahy + 1){
                vysledek.append([x,y])
                return true
            }
            else{
                sachovnice[x][y] = 0
            }
        }
    }
    return false
}

//Kontrola zda byly navštíveny všechny pole šachovnice
func kontrolaSpravnosti(velikost n: Int) {
    //check bude obsahovat všechny políčka šachovnice (tyco se mají projít)
    var check1 = [Array(0..<n),Array(0..<n)]
    var check = [[Int]]()
    for i in check1[0]{
        for j in check1[1]{
            check.append([i,j])
        }
    }
    //musí vracet Pouze [[0,0]] -> což je místo z kama se začíná
    check = check.filter { !vysledek.contains($0) }
    if check == [[0,0]]{
        print("[0,0]")
    }
}


////////////////////////////////////////////////////////////////////////////////
//MARK: - Hlavní funkce

//ať to je lehce přehlednější
func main() {
    print("Zadejte velikost sachovnice (n): ")
    
    let n: Int = Int(readLine(strippingNewline: true)!)!
    
    var sachovnice = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    
    if reseni(sachovnice: &sachovnice, pozice: (0,0),velikost: n, tahy: 0){
        //bez vraceni [0,0]
        vysledek.reverse()
        print(vysledek)
    }
    else{
        print("Nelze projít \(n)x\(n) šachovnici")
    }
    
    kontrolaSpravnosti(velikost: n)
}

main()
