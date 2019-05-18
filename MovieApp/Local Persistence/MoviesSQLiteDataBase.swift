//
//  MoviesSQLiteDataBase.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/16/19.
//

import UIKit
import SQLite3

class MoviesSQLiteDataBase: NSObject {
    var db: OpaquePointer?
    @objc static let MovieDatabase = MoviesSQLiteDataBase()
    let SQLITE_TRANSIENT = unsafeBitCast(OpaquePointer(bitPattern: -1), to: sqlite3_destructor_type.self)
    
    func createMoviesDataBase(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("MoviesSQLiteDataBase.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return
        }
        
        let tableQuery = "CREATE TABLE IF NOT EXISTS movies (id INTEGER PRIMARY KEY,backdropPath TEXT,title TEXT,voteAverage DOUBLE,voteCount INTEGER,posterPath TEXT,releaseDate TEXT,overview TEXT,originalTitle TEXT,originalLanguage TEXT)"
        if sqlite3_exec(db, tableQuery , nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
            return
        }else{
            print("done")
        }
        
    }
    
    
    // MARK: - INSERT FUNCs
    ////////// INSERT ////////////
    func addMovieToMovies(movie: Results){
        let insertQuery = "INSERT INTO movies (backdropPath,title,voteAverage,id,voteCount,posterPath,releaseDate,overview,originalTitle,originalLanguage) VALUES (?,?,?,?,?,?,?,?,?,?)"
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(db, insertQuery, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        } else {
            sqlite3_bind_text(stmt, 1,movie.backdropPath , -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(stmt, 2,movie.title , -1, SQLITE_TRANSIENT)
            sqlite3_bind_double(stmt, 3, movie.voteAverage)
            sqlite3_bind_int(stmt, 4, Int32(Int(movie.id)))
            sqlite3_bind_int(stmt, 5,Int32(Int(movie.voteCount)))
            sqlite3_bind_text(stmt, 6,movie.posterPath , -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(stmt, 7,movie.releaseDate , -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(stmt, 8,movie.overview , -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(stmt, 9,movie.originalTitle , -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(stmt, 10,movie.originalLanguage , -1, SQLITE_TRANSIENT)
            
            if sqlite3_step(stmt) == SQLITE_DONE {
                print(" movie insertion Done")
            } else {
                print("Could not insert row.")
            }
            sqlite3_finalize(stmt)
        }
        
    }
    
    // MARK:- SELECT FUNCs
    //////// SELECT ////////////////
    func selectAllMovies() -> [Results]{
        var allMovies = [Results]()
        let selectQuery = "SELECT backdropPath,title,voteAverage,voteCount,posterPath,releaseDate,overview,originalTitle,originalLanguage FROM movies"
        var stmt: OpaquePointer?
        if sqlite3_prepare(db, selectQuery, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return allMovies
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let backdropPath = String(cString: sqlite3_column_text(stmt, 0))
            let title = String(cString: sqlite3_column_text(stmt, 1))
            let voteAverage = sqlite3_column_double(stmt, 2)
            let voteCount = sqlite3_column_int(stmt, 3)
            let posterPath = String(cString: sqlite3_column_text(stmt, 4))
            let releaseDate = String(cString: sqlite3_column_text(stmt, 5))
            let overview = String(cString: sqlite3_column_text(stmt, 6))
            let originalTitle = String(cString: sqlite3_column_text(stmt, 7))
            let originalLanguage = String(cString: sqlite3_column_text(stmt, 8))
            //adding values to list
            allMovies.append(Results(fromDictionary: [
                "title": title,
                "backdrop": backdropPath,
                "vote_average": voteAverage,
                "vote_count_": voteCount,
                "poster": posterPath,
                "release_date": releaseDate,
                "overview": overview,
                "original_title": originalTitle,
                "original_language": originalLanguage
                ]))
        }
        allMovies = allMovies.sorted(by: { $0.voteAverage > $1.voteAverage })

        return allMovies
    }
    
    // MARK:- DELETE ITEM
    func deleteMovie(id :Int){
        let updateQuery = "DELETE FROM movies WHERE id = \(Int(id)) "
        var stmt: OpaquePointer?
        if sqlite3_prepare(db, updateQuery, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing movie: \(errmsg)")
            return
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("Delete movie")
        }
    }
    
    // MARK:- DELETE FUNCs
    ////////// DELETE ////////////
    func deleteAllMovies(){
        let updateQuery = "DELETE FROM movies"
        var stmt: OpaquePointer?
        if sqlite3_prepare(db, updateQuery, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing Delete: \(errmsg)")
            return
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("Delete CartData")
        }
    }
    
    func deleteAllTables(){
        deleteAllMovies()
    }
}
