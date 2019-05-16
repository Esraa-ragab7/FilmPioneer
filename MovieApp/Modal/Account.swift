//
//	Account.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Account : NSObject, NSCoding{

	var gravatar : String!
	var id : Int!
	var includeAdult : Bool!
	var iso31661 : String!
	var iso6391 : String!
	var name : String!
	var username : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let avatarData = dictionary["avatar"] as? [String:Any]{
            if let avatar = avatarData["gravatar"] as? [String:Any]{
                gravatar = "https://secure.gravatar.com/avatar/\(avatar["hash"] as? String ?? "").jpg?s=64"
            }
            
		}
		id = dictionary["id"] as? Int
		includeAdult = dictionary["include_adult"] as? Bool
		iso31661 = dictionary["iso_3166_1"] as? String
		iso6391 = dictionary["iso_639_1"] as? String
		name = dictionary["name"] as? String
		username = dictionary["username"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if gravatar != nil{
			dictionary["gravatar"] = gravatar
		}
		if id != nil{
			dictionary["id"] = id
		}
		if includeAdult != nil{
			dictionary["include_adult"] = includeAdult
		}
		if iso31661 != nil{
			dictionary["iso_3166_1"] = iso31661
		}
		if iso6391 != nil{
			dictionary["iso_639_1"] = iso6391
		}
		if name != nil{
			dictionary["name"] = name
		}
		if username != nil{
			dictionary["username"] = username
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         gravatar = aDecoder.decodeObject(forKey: "gravatar") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         includeAdult = aDecoder.decodeObject(forKey: "include_adult") as? Bool
         iso31661 = aDecoder.decodeObject(forKey: "iso_3166_1") as? String
         iso6391 = aDecoder.decodeObject(forKey: "iso_639_1") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         username = aDecoder.decodeObject(forKey: "username") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if gravatar != nil{
			aCoder.encode(gravatar, forKey: "gravatar")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if includeAdult != nil{
			aCoder.encode(includeAdult, forKey: "include_adult")
		}
		if iso31661 != nil{
			aCoder.encode(iso31661, forKey: "iso_3166_1")
		}
		if iso6391 != nil{
			aCoder.encode(iso6391, forKey: "iso_639_1")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if username != nil{
			aCoder.encode(username, forKey: "username")
		}

	}

}
