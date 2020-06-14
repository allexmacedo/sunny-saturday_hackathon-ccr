//
//  FacilitiesDAO.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import CoreLocation

protocol FacilitiesDataStore {
    
    func retriveFacilities(ofCategory category: FacilityCategory, completion: @escaping (Result<[CommercialFacility], Error>) -> Void)
    
    func retriveCategories(completion: @escaping (Result<[FacilityCategory], Error>) -> Void)
}

final class FacilitiesDAO: NetworkDAO<FacilityAPI>, FacilitiesDataStore {
    
    func retriveCategories(completion: @escaping (Result<[FacilityCategory], Error>) -> Void) {
        
        router.request(.allCategories) { (data, response, error) in
            self.readsFacilityCategorysRouterResponse(data: data, response: response, error: error, completion: completion)
        }
        
    }
    
    private func readsFacilityCategorysRouterResponse(data: Data?, response: URLResponse?, error: Error?,
                                                      completion: @escaping (Result<[FacilityCategory], Error>) -> Void) {
        
        if let error = error {
            completion(.failure(error))
            
        } else if let response = response as? HTTPURLResponse {
            
            let result = self.handleNetworkResponse(response)
            
            self.decodeFacilityCategorysResult(data: data, result: result, completion: completion)
            
        } else {
            completion(.failure(NetworkResponseError.failed))
        }
    }
    
    private func decodeFacilityCategorysResult(data: Data?, result: ResponseResult<NetworkResponseError>,
                                               completion: @escaping (Result<[FacilityCategory], Error>) -> Void) {
        
        switch result {
            
            case .sucess:
                
                guard let responseData = data else {
                    completion(.failure(NetworkResponseError.noData))
                    return
                }
                
                do {
                    
                    let decoder = JSONDecoder()
                    
                    let results = try decoder.decode([FacilityCategory].self, from: responseData)
                    
                    completion(.success(results))
                    
                } catch {
                    completion(.failure(NetworkResponseError.unableToDecode))
            }
            
            case .failure(let error):
                completion(.failure(error))
        }
    }

    func retriveFacilities(ofCategory category: FacilityCategory, completion: @escaping (Result<[CommercialFacility], Error>) -> Void) {
        
        completion(.success([CommercialFacility(id: UUID(),
                                                name: "Graal Paloma",
                                                category: [FacilityCategory(id: nil, name: "Postos de combustivel", description: nil)],
                                                description: "A Rede Graal é uma rede de auto-postos rodoviários do Brasil, sendo conhecida pelos seus amplos e modernos rodoshoppings. Está presente em algumas das principais rodovias nos estados de São Paulo, Minas Gerais, Rio de Janeiro, Santa Catarina e Rio Grande do Sul.",
                                                address: " Rodovia Engenheiro João Baptista Cabral Rennó,s/n - Zona Rural, Santa Cruz do Rio Pardo - SP, 18900-000",
                                                timeOfWork: "Aberto 24h",
                                                phone: "(14) 3332-1033",
                                                image: "graal",
                                                rating: 4.5,
                                                verified: true,
                                                coordinate: CLLocation(latitude: -22.8061941, longitude: -49.531047))]))
    }
}
