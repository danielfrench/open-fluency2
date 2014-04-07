package com.openfluency.course

import com.openfluency.flashcard.Deck
import com.openfluency.auth.User
import com.openfluency.language.Language
import grails.plugin.springsecurity.annotation.Secured

class CourseController {

	def springSecurityService
	def courseService

	// Researchers will not be able to enroll or create courses
	@Secured(['ROLE_INSTRUCTOR', 'ROLE_STUDENT', 'ROLE_ADMIN'])
	def list() {
		def user = User.load(springSecurityService.principal.id)
		[myCourses: Course.findAllByOwner(user), registrations: Registration.findAllByUser(user)]
	}

	// Only instructors are able to create courses
	@Secured(['ROLE_INSTRUCTOR'])
	def create() {
		[courseInstance: new Course(params)]
	}

	// Only instructors are able to create or edit courses
	@Secured(['ROLE_INSTRUCTOR'])
	def save() {

		def courseInstance = courseService.createCourse(params.title, params.description, params.language.id)

		// Check for errors
    	if (courseInstance.hasErrors()) {
    		render(view: "create", model: [courseInstance: courseInstance])
    		return
    	}

    	redirect action: "show", id: courseInstance.id
	}

	@Secured(['isAuthenticated()'])
	def show(Course courseInstance) {
		[courseInstance: courseInstance, isOwner: springSecurityService?.principal?.id == courseInstance.owner.id, userInstance: User.load(springSecurityService.principal.id)]
	}

	@Secured(['isAuthenticated()'])
	def search() {
		Long languageId = params['filter-lang'] as Long
		String keyword = params['search-text']
		[keyword: keyword, languageId: languageId, courseInstanceList: courseService.searchCourses(languageId, keyword), 
            languageInstanceList: Language.list(), userInstance: User.load(springSecurityService.principal.id)]
	}

	// Only students can enroll in courses
	@Secured(['ROLE_STUDENT'])
	def enroll(Course courseInstance) {
		Registration registrationInstance = courseService.createRegistration(courseInstance)

		// Check for errors
    	if (registrationInstance.hasErrors()) {
    		redirect action: "show", id: courseInstance.id
    		return
    	}

    	flash.message = "Well done! You're now registered in this course!"
    	render view: "show", model: [courseInstance: courseInstance, isOwner: springSecurityService.principal.id == courseInstance.owner.id, userInstance: User.load(springSecurityService.principal.id)]
	}
}
