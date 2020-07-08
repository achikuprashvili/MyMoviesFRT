//
//  DataManager.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataEntityNames: String {
    case FavouriteMovieMO
}

protocol DataManagerProtocol {
    func saveMovieAs(favourite: Movie)
    func deleteMovieFromFavourite(with id: Int)
    func getAllFavouriteMovies() -> [Movie]
    func isFavouriteMovie(movieId: Int) -> Bool
}

class DataManager: DataManagerProtocol {
    let persistentContainer: NSPersistentContainer
    
    init() {
        let container = NSPersistentContainer(name: "MyMoviesFRT")
        
        container.loadPersistentStores { storeDesription, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        persistentContainer = container
    }
    
    private func getFavoriteMovie(with id: Int) -> FavouriteMovieMO? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityNames.FavouriteMovieMO.rawValue)
        let fetchContext = persistentContainer.viewContext
        let predicate = NSPredicate(format: "id == %i", id)
        fetchRequest.predicate = predicate
        do {
            let movies = try fetchContext.fetch(fetchRequest) as! [FavouriteMovieMO]
            return movies.first
        } catch {
            return nil
        }
    }
}

extension DataManager {
    
    func isFavouriteMovie(movieId: Int) -> Bool {
        return getFavoriteMovie(with: movieId) != nil 
    }
    
    func saveMovieAs(favourite: Movie) {
        let context = persistentContainer.newBackgroundContext()
        context.performAndWait {
            let movieMo = getFavoriteMovie(with: favourite.id) ?? NSEntityDescription.insertNewObject(forEntityName: CoreDataEntityNames.FavouriteMovieMO.rawValue, into: context) as! FavouriteMovieMO
            movieMo.updateDate(from: favourite)
            context.saveContext()
        }
        
    }
    
    func deleteMovieFromFavourite(with id: Int) {
        let context = persistentContainer.viewContext
        context.performAndWait {
            guard let object = getFavoriteMovie(with: id) else {
                return
            }
            context.delete(object)
            context.saveContext()
        }
    }
    
    func getAllFavouriteMovies() -> [Movie] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityNames.FavouriteMovieMO.rawValue)
        let fetchContext = persistentContainer.viewContext
        do {
            let movies = try fetchContext.fetch(fetchRequest) as! [FavouriteMovieMO]
            let result = movies.map { (movie) -> Movie in
                return Movie(movie: movie)
            }
            return result
        } catch {
            return []
        }
    }
}

extension NSManagedObjectContext {
    
    func saveContext() {
        do {
            try save()
        } catch {
            print("Failure to save context: \(error)")
        }
    }
}
