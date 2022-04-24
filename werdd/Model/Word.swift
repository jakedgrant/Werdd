//
//  File.swift
//  werdd
//
//  Created by Jake Grant on 3/14/22.
//

struct Word: Codable {
	let word: String
	let partOfSpeech: PartOfSpeech
	let definition: String
	
	var synonym: String? = nil
	var antonym: String? = nil
	var example: String? = nil
	
	var result: [WordResult]? = nil
}

struct WordResult: Codable {
	let definition: String
	let partOfSpeech: PartOfSpeech
	
	let synonym: [String]?
	let antonyms: [String]?
	let examples: [String]?
}

enum PartOfSpeech: String, Codable {
	case noun, pronoun, verb, adjective, adverb, preposition, conjunction, interjection, article
}

public enum WordInfoType: String {
	case definition = "Definition"
	case synonym = "Synonym"
	case antonym = "Antonym"
	case example = "Example"
}

class Words {
	let words: [Word] = [
		Word(word: "onomatopaeia",
			 partOfSpeech: .noun,
			 definition: "the naming of a thing or action by a vocal imitation of the sound associated with it (such as buzz, hiss)"),
		
		Word(word: "penultimate",
			 partOfSpeech: .adjective,
			 definition: "last but one in a series of things; second last"),
		
		Word(word: "defenestrate",
			 partOfSpeech: .verb,
			 definition: "throw (someone) out of a window"),
		
		Word(word: "switch",
			 partOfSpeech: .verb,
			 definition: "change the position, direction, or focus of"),
		
		Word(word: "pontificate",
			 partOfSpeech: .verb,
			 definition: "express one's opinions in a way considered annoyingly pompous and dogmatic"),
		
		Word(word: "detergent",
			 partOfSpeech: .noun,
			 definition: "a water-soluble cleansing agent which combines with impurities and dirt to make them more soluble, and differs from soap in not forming a scum with the salts in hard water"),
		
		Word(word: "bacon",
			 partOfSpeech: .noun,
			 definition: "cured meat from the sides and belly of a pig, having distinct strips of fat and typically served in thin slices"),
		
		Word(word: "jambalaya",
			 partOfSpeech: .noun,
			 definition: "a Cajun dish of rice with shrimp, chicken, and vegetables"),
		
		Word(word: "diode",
			 partOfSpeech: .noun,
			 definition: "a semiconductor device with two terminals, typically allowing the flow of current in one direction only"),
		
		Word(word: "algorithm",
			 partOfSpeech: .noun,
			 definition: "a process or set of rules to be followed in calculations or other problem-solving operations, especially by a computer")
	]
}
