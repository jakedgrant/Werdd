//
//  File.swift
//  werdd
//
//  Created by Jake Grant on 3/14/22.
//

struct Word {
	let name: String
	let partOfSpeech: String
	let definition: String
}

class Words {
	let words: [Word] = [
		Word(name: "onomatopaeia", partOfSpeech: "noun", definition: "the naming of a thing or action by a vocal imitation of the sound associated with it (such as buzz, hiss)"),
		Word(name: "penultimate", partOfSpeech: "adjective", definition: "last but one in a series of things; second last"),
		Word(name: "defenestrate", partOfSpeech: "verb", definition: "throw (someone) out of a window"),
		Word(name: "switch", partOfSpeech: "verb", definition: "change the position, direction, or focus of"),
		Word(name: "pontificate", partOfSpeech: "verb", definition: "express one's opinions in a way considered annoyingly pompous and dogmatic"),
		Word(name: "detergent", partOfSpeech: "noun", definition: "a water-soluble cleansing agent which combines with impurities and dirt to make them more soluble, and differs from soap in not forming a scum with the salts in hard water"),
		Word(name: "bacon", partOfSpeech: "noun", definition: "cured meat from the sides and belly of a pig, having distinct strips of fat and typically served in thin slices"),
		Word(name: "jambalaya", partOfSpeech: "noun", definition: "a Cajun dish of rice with shrimp, chicken, and vegetables"),
		Word(name: "diode", partOfSpeech: "noun", definition: "a semiconductor device with two terminals, typically allowing the flow of current in one direction only"),
		Word(name: "algorithm", partOfSpeech: "noun", definition: "a process or set of rules to be followed in calculations or other problem-solving operations, especially by a computer")
	]
}
