//
//  Product.swift
//  ZUKI
//
//  Created by Kegham Karsian on 9/12/18.
//  Copyright © 2018 idesign. All rights reserved.
//

import Foundation


public struct Ar: Decodable {
    public var genericName: String?
    public var productName: String?
    public var ingredients: String?

    
    private enum CodingKeys: String, CodingKey {
        case genericName = "generic_name_ar"
        case productName = "product_name_ar"
        case ingredients = "ingredients_text_ar"

    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genericName = try container.decodeIfPresent(String.self, forKey: .genericName)
        productName = try container.decodeIfPresent(String.self, forKey: .productName)
        ingredients = try container.decodeIfPresent(String.self, forKey: .ingredients)
    }
    
}

public struct En: Decodable {
    
    public var genericName: String?
    public var productName: String?
    public var ingredients: String?
    
    
    private enum CodingKeys: String, CodingKey {
        case genericName = "generic_name_en"
        case productName = "product_name_en"
        case ingredients = "ingredients_text_en"
        
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genericName = try container.decodeIfPresent(String.self, forKey: .genericName)
        productName = try container.decodeIfPresent(String.self, forKey: .productName)
        ingredients = try container.decodeIfPresent(String.self, forKey: .ingredients)
    }
}

public struct Fr: Decodable {
    
    public var genericName: String?
    public var productName: String?
    public var ingredients: String?
    
    
    private enum CodingKeys: String, CodingKey {
        case genericName = "generic_name_fr"
        case productName = "product_name_fr"
        case ingredients = "ingredients_text_fr"
        
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genericName = try container.decodeIfPresent(String.self, forKey: .genericName)
        productName = try container.decodeIfPresent(String.self, forKey: .productName)
        ingredients = try container.decodeIfPresent(String.self, forKey: .ingredients)
    }
}



public struct ProductResponse {
    public let statusVerbose: String
    public let code: String?
    public var status: ResponseStatus = .notFound
    public let product: OFFProduct?
}

public enum ResponseStatus {
    case notFound
    case found
}


/**
 A Open food facts product model class
*/
public class OFFProduct: Decodable {
    public var code: String!
    public var mainProductlanguage: String?
    public var createdAt: Double!
    public var lastModifiedBy: String?
    public var genericName: String?
    public var productName: String?
    public var countriesText: String?
    public var countriesTags: [String]?
    public var countriesTagsAR: [String]?
    public var brandsText: String?
    public var brandsTags: [String]?
    public var storesText: String?
    public var storesTags: [String]?
    //INGREDIENTS
    public var ingredientText: String?
    public var ingredientsTags: [String]?
    public var ingredientsTagsEN: [String]?
    public var ingredientsTagsAR: [String]?
    public var creator: String!
    public var quantity: String?
    public var firstPackagingCodeGeo: String?

    //TRACES LABELS PACKAGING
    //Traces
    public var tracesText: String?
    public var tracesTags: [String]?
    public var tracesTagsAR: [String]?
    public var labelsText: String?
    public var labelsTags: [String]?
    public var labelsTagsAR: [String]?
    public var packagingTags: [String]?
    //var packagingTagsAR: [String]?
    //GRADES
    public var nutritionDataPer: String?
    public var novaGoup: String?
    public var nutritionGrades: NutriScore?
    public var nutrietLevels: NutrientLevels?
    public var nutriments: Nutriments?
    public var servingSize: String?
    //ADDITIVES
    public var additivesText: String?
    public var additivesTags: [String]?
    public var additivesTagsEN: [String]?
    public var additivesTagsAR: [String]?
    //CATEGORIES
    public var categoriesText: String?
    public var categoriesTags: [String]?
    public var categoriesTagsEN: [String]?
    public var categoriesTagsAR: [String]?
    //IMAGES
    public var imageFrontSmall: URL?
    public var imageNutritionSmall: URL?
    public var imageIngredientsSmall: URL?
    public var imageFrontThumb: URL?
    public var imageNutritionThumb: URL?
    public var imageIngredientsThumb: URL?
    
    public var ar: Ar?
    public var en: En?
    public var fr: Fr?


    public init(){}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        mainProductlanguage = try container.decodeIfPresent(String.self, forKey: .mainProductLanguage)
        createdAt = try container.decode(Double.self, forKey: .createdAt)
        lastModifiedBy = try container.decodeIfPresent(String.self, forKey: .lastModifiedBy)
        genericName = try container.decodeIfPresent(String.self, forKey: .genericName)
        productName = try container.decodeIfPresent(String.self, forKey: .productName)
        do {
            novaGoup = try container.decodeIfPresent(String.self, forKey: .novaGroup)
        }catch DecodingError.typeMismatch {
            novaGoup = String(try container.decode(Int.self, forKey: .novaGroup))
        }
        brandsText = try container.decodeIfPresent(String.self, forKey: .brandsText)
        brandsTags = try container.decodeIfPresent([String].self, forKey: .brandsTags)
        storesText = try container.decodeIfPresent(String.self, forKey: .storesText)
        storesTags = try container.decodeIfPresent([String].self, forKey: .storesTags)
        ingredientText = try container.decodeIfPresent(String.self, forKey: .ingredientText)
        ingredientsTags = try container.decodeIfPresent([String].self, forKey: .ingredientsTags)
        ingredientsTagsEN = try container.decodeIfPresent([String].self, forKey: .ingredientsTags)?.filter{$0.contains(Languages.en.rawValue)}
        ingredientsTagsEN = ingredientsTagsEN != nil && (ingredientsTagsEN?.isEmpty)! ? nil : ingredientsTagsEN
        ingredientsTagsAR = try container.decodeIfPresent([String].self, forKey: .ingredientsTags)?.filter{$0.contains(Languages.ar.rawValue)}
        ingredientsTagsAR = ingredientsTagsAR != nil && (ingredientsTagsAR?.isEmpty)! ? nil : ingredientsTagsAR
        creator = try container.decodeIfPresent(String.self, forKey: .creator)
        quantity = try container.decodeIfPresent(String.self, forKey: .quantity)
        servingSize = try container.decodeIfPresent(String.self, forKey: .servingSize)
        firstPackagingCodeGeo = try container.decodeIfPresent(String.self, forKey: .firstPackagingCodeGeo)
        nutritionGrades = try container.decodeIfPresent(NutriScore.self, forKey: .nutritionGrades)
        nutrietLevels = try container.decodeIfPresent(NutrientLevels.self, forKey: .nutrientLevels)
        nutriments = try container.decodeIfPresent(Nutriments.self, forKey: .nutriments)
        nutritionDataPer = try container.decodeIfPresent(String.self, forKey: .nutritionDataPer)
        tracesText = try container.decodeIfPresent(String.self, forKey: .tracesText)
        labelsText = try container.decodeIfPresent(String.self, forKey: .labelsText)
        additivesText = try container.decodeIfPresent(String.self, forKey: .additivesText)
        countriesText = try container.decodeIfPresent(String.self, forKey: .countriesText)
        countriesTagsAR = try container.decodeIfPresent([String].self, forKey: .countryTags)?.filter{$0.contains(Languages.ar.rawValue)}
        countriesTagsAR = countriesTagsAR != nil && (countriesTagsAR?.isEmpty)! ? nil : countriesTagsAR
        countriesTags = try container.decodeIfPresent([String].self, forKey: .countryTags)?.filter{$0.contains(Languages.en.rawValue)}
        countriesTags = countriesTags != nil && (countriesTags?.isEmpty)! ? nil : countriesTags
        
        tracesTags = try container.decodeIfPresent([String].self, forKey: .tracesTags)?.filter{$0.contains(Languages.en.rawValue)}
        tracesTags = tracesTags != nil && (tracesTags?.isEmpty)! ? nil : tracesTags
        tracesTagsAR = try container.decodeIfPresent([String].self, forKey: .tracesTags)?.filter{$0.contains(Languages.ar.rawValue)}
        tracesTagsAR = tracesTagsAR != nil && (tracesTagsAR?.isEmpty)! ? nil : tracesTagsAR
        labelsTags = try container.decodeIfPresent([String].self, forKey: .labelsTags)?.filter{$0.contains(Languages.en.rawValue)}
        labelsTags = labelsTags != nil && (labelsTags?.isEmpty)! ? nil : labelsTags
        labelsTagsAR = try container.decodeIfPresent([String].self, forKey: .labelsTags)?.filter{$0.contains(Languages.ar.rawValue)}
        labelsTagsAR = labelsTagsAR != nil && (labelsTagsAR?.isEmpty)! ? nil : labelsTagsAR
        //        packagingTagsAR = try container.decodeIfPresent([String].self, forKey: .packagingTags)?.filter{$0.contains(Languages.ar.rawValue)}
        //        packagingTagsAR = packagingTagsAR != nil && (packagingTagsAR?.isEmpty)! ? nil : packagingTagsAR
        packagingTags = try container.decodeIfPresent([String].self, forKey: .packagingTags)//?.filter{$0.contains(Languages.en.rawValue)}
        //packagingTags = packagingTags != nil && (packagingTags?.isEmpty)! ? nil : packagingTags
        additivesTags = try container.decodeIfPresent([String].self, forKey: .additivesTag)
        additivesTagsEN = try container.decodeIfPresent([String].self, forKey: .additivesTag)?.filter{$0.contains(Languages.en.rawValue)}
        additivesTagsEN = additivesTagsEN != nil && (additivesTagsEN?.isEmpty)! ? nil : additivesTagsEN
        additivesTagsAR = try container.decodeIfPresent([String].self, forKey: .additivesTag)?.filter{$0.contains(Languages.ar.rawValue)}
        additivesTagsAR = additivesTagsAR != nil && (additivesTagsAR?.isEmpty)! ? nil : additivesTagsAR
        categoriesTags = try container.decodeIfPresent([String].self, forKey: .categoriesTags)
        categoriesTagsEN = try container.decodeIfPresent([String].self, forKey: .categoriesTags)?.filter{$0.contains(Languages.en.rawValue)}
        categoriesTagsEN = categoriesTagsEN != nil && (categoriesTagsEN?.isEmpty)! ? nil : categoriesTagsEN
        categoriesTagsAR = try container.decodeIfPresent([String].self, forKey: .categoriesTags)?.filter{$0.contains(Languages.ar.rawValue)}
        categoriesTagsAR = categoriesTagsAR != nil && (categoriesTagsAR?.isEmpty)! ? nil : categoriesTagsAR
        categoriesText = try container.decodeIfPresent(String.self, forKey: .categoriesText)
        
        //IMAGES
        imageFrontSmall = try container.decodeIfPresent(URL.self, forKey: .imageFrontSmall)
        imageFrontThumb = try container.decodeIfPresent(URL.self, forKey: .imageFrontThumb)
        imageNutritionSmall = try container.decodeIfPresent(URL.self, forKey: .imageNutritionSmall)
        imageNutritionThumb = try container.decodeIfPresent(URL.self, forKey: .imageNutritionThumb)
        imageIngredientsSmall = try container.decodeIfPresent(URL.self, forKey: .imageIngredientsSmall)
        imageIngredientsThumb = try container.decodeIfPresent(URL.self, forKey: .imageIngredientsThumb)
        
        if LanguageManager.productLanguage == .ar {
            ar = try Ar(from: decoder)
        } else if LanguageManager.productLanguage == .en {
            en = try En(from: decoder)
        } else if LanguageManager.productLanguage == .fr {
            fr = try Fr(from: decoder)
        }
        
    }
    
}

extension OFFProduct {
    
    private enum CodingKeys: String, CodingKey {
        case code = "code"
        case mainProductLanguage = "lang"
        case createdAt = "created_t"
        case lastModifiedBy = "last_modified_by"
        case genericName = "generic_name"
        case productName = "product_name"
        case countriesText = "countries"
        case countryTags = "countries_tags"
        case brandsText = "brands"
        case brandsTags = "brands_tags"
        case storesText = "stores"
        case storesTags = "stores_tags"
        case ingredientsTextEN = "ingredients_text_en"
        case ingredientsTextAR = "ingredients_text_ar"
        case ingredientText = "ingredient_text"
        case ingredientsTags = "ingredients_hierarchy"
        case creator = "creator"
        case quantity = "quantity"
        case servingSize = "serving_size"
        case firstPackagingCodeGeo = "first_packaging_code_geo"
        case tracesText = "traces"
        case labelsText = "labels"
        case tracesTags = "traces_tags"
        case labelsTags = "labels_tags"
        case packagingTags = "packaging_tags"
        case novaGroup = "nova_group"
        case nutritionGrades = "nutrition_grades"
        case nutrientLevels = "nutrient_levels"
        case nutriments = "nutriments"
        case nutritionDataPer = "nutrition_data_per"
        case additivesTag = "additives_tags"
        case categoriesText = "categories"
        case categoriesTags = "categories_hierarchy"
        case additivesText = "additives"
        //IMAGES
        case imageFrontSmall = "image_front_small_url"
        case imageFrontThumb = "image_front_thumb_url"
        case imageNutritionSmall = "image_nutrition_small_url"
        case imageNutritionThumb = "image_nutrition_thumb_url"
        case imageIngredientsSmall = "image_ingredients_small_url"
        case imageIngredientsThumb = "image_ingredients_thumb_url"
        
    }
    
    /*public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(genericName, forKey: .genericName)
        try container.encode(productName, forKey: .productName)
        try container.encode(brandsText, forKey: .brandsText)
        try container.encode(countriesText, forKey: .countriesText)
        try container.encode(storesText, forKey: .storesText)
        try container.encode(ingredientText, forKey: .ingredientText)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(servingSize, forKey: .servingSize)
        try container.encode(tracesText, forKey: .tracesText)
        try container.encode(additivesText, forKey: .additivesText)
        try container.encode(labelsText, forKey: .labelsText)
        try container.encode(categoriesText, forKey: .categoriesText)
        try container.encode(nutriments, forKey: .nutriments)
        try container.encode(nutritionDataPer, forKey: .nutritionDataPer)
        try container.encode(nutrietLevels, forKey: .nutrientLevels)
        try container.encode(nutritionGrades, forKey: .nutritionGrades)
    
    }*/
    
}


extension ProductResponse: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case statusVerbose = "status_verbose"
        case code = "code"
        case status = "status"
        case product = "product"
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let statusReply = try container.decode(Int.self, forKey: .status)
        if statusReply == 0 {
            status = .notFound
        } else if statusReply == 1 {
            status = .found
        }
        code = try container.decodeIfPresent(String.self, forKey: .code)
        statusVerbose = try container.decode(String.self, forKey: .statusVerbose)
        product = try container.decodeIfPresent(OFFProduct.self, forKey: .product)
    }
}




