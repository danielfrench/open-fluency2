package com.openfluency.flashcard

import com.openfluency.auth.User

class Deck {

	String title
	String description
	User owner

	Date dateCreated
	Date lastUpdated

    static constraints = {
    }
}
