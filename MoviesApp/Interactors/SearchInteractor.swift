//
//  SearchInteractor.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 15/08/25.
//

import Combine


protocol SearchInteractorProtocol {
    func search(_ query: String) -> AnyPublisher<[Results], ServiceError>
   }

struct SearchInteractor: SearchInteractorProtocol {
    
    private let searchService : SearchServiceProtocol
    
    
    init (searchService : SearchServiceProtocol) {
        self.searchService = searchService
       
    }
    func search(_ query: String) -> AnyPublisher<[Results], ServiceError> {
           searchService
            .execute(query)
               .map { dtoArray in
                   dtoArray.map { Results(dto: $0) }
               }
               .mapServicesError()
               .eraseToAnyPublisher()
       }
    
}


extension SearchInteractor {
    static func build(_ typeData: TypeData) -> SearchInteractor {
        switch typeData {
        case .real:
            SearchInteractor(searchService: SearchService())
        case .mock:
            SearchInteractor(searchService: SearchServiceMock())
        }
    }
}


