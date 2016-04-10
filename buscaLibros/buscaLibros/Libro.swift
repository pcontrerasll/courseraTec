//
//  Libro.swift
//  buscaLibros
//
//  Created by Pilar on 26/03/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import Foundation

class Libro: Equatable {
    
    var isbn: String = ""
    var titulo: String = ""
    var autor: String = ""
    var autores = Set<NSObject>()
    var portada: String = ""
    var completo: Bool = false;
    
}

func ==(lhs: Libro, rhs: Libro) -> Bool {
    return lhs.isbn == rhs.isbn
}
