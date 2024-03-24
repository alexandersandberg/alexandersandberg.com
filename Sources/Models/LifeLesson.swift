//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 24.03.24.
//

import Foundation

struct LifeLesson: Codable, Identifiable {
	enum Category: Int, Codable {
		case purposeAndMeaning = 1
		case curiosityAndLearning = 2
		case integrityAndMentality = 3
		case missionAndPursuit = 4
		case creativityAndCreation = 5
		case motivationAndDiscipline = 6
		case businessAndMarketing = 7
		case managementAndLeadership = 8
		case successAndInfluence = 9
		case wealthAndMoney = 10
		case healthAndHappiness = 11
		case loveAndRelationships = 12
		case statusAndDesire = 13
		case experiencesAndPossessions = 14
		case riskAndUncertainty = 15
		case stressAndAnxiety = 16
		case sufferingAndAcceptance = 17
		case reflectionAndAwareness = 18
		case mindfulnessAndPeace = 19
		case hopeAndWonder = 20

		var title: String {
			switch self {
			case .purposeAndMeaning:
				"Purpose and Meaning"
			case .curiosityAndLearning:
				"Curiosity and Learning"
			case .integrityAndMentality:
				"Integrity and Mentality"
			case .missionAndPursuit:
				"Mission and Pursuit"
			case .creativityAndCreation:
				"Creativity and Creation"
			case .motivationAndDiscipline:
				"Motivation and Discipline"
			case .businessAndMarketing:
				"Business and Marketing"
			case .managementAndLeadership:
				"Management and Leadership"
			case .successAndInfluence:
				"Success and Influence"
			case .wealthAndMoney:
				"Wealth and Money"
			case .healthAndHappiness:
				"Health and Happiness"
			case .loveAndRelationships:
				"Love and Relationships"
			case .statusAndDesire:
				"Status and Desire"
			case .experiencesAndPossessions:
				"Experiences and Possessions"
			case .riskAndUncertainty:
				"Risk and Uncertainty"
			case .stressAndAnxiety:
				"Stress and Anxiety"
			case .sufferingAndAcceptance:
				"Suffering and Acceptance"
			case .reflectionAndAwareness:
				"Reflection and Awareness"
			case .mindfulnessAndPeace:
				"Mindfulness and Peace"
			case .hopeAndWonder:
				"Hope and Wonder"
			}
		}

		var relativePath: String {
			let slug = title
				.replacingOccurrences(of: " ", with: "-")
				.lowercased()
			return "/life-lessons/\(slug)"
		}
	}

	var id: Int
	var category: Category
	var markdown: String
	var source: String?
}

extension LifeLesson: Comparable {
	static func < (lhs: LifeLesson, rhs: LifeLesson) -> Bool {
		lhs.id < rhs.id
	}
}

extension LifeLesson.Category: Comparable {
	static func < (lhs: LifeLesson.Category, rhs: LifeLesson.Category) -> Bool {
		lhs.rawValue < rhs.rawValue
	}
}
