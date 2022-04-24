//
//  File.swift
//  werdd
//
//  Created by Jake Grant on 3/14/22.
//

struct Word: Codable {
	let word: String
	var results: [WordResult]?
}

struct WordResult: Codable {
	let definition: String?
	let partOfSpeech: PartOfSpeech?
	
	let synonyms: [String]?
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

