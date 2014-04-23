<%@ page import="com.openfluency.Constants" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main"/>
</head>
<body>
	<div class="container deck-show">
		<ul class="breadcrumb">
			<li>
				<a href="${createLink(uri:'/') }">Home</a>
			</li>
			<li>Decks</li>
			<li>
				<g:link action="search" controller="deck" >Search for Decks</g:link>
			</li>
			<li>
				<a href="#">${deckInstance?.title}</a>
			</li>
		</ul>
		<div class="deck-header text-center center-block">
			<h1 class="deck-title">${deckInstance?.title}</h1>
			<p class="deck-description">${deckInstance?.description}</p>
			<g:if test="${flashcardCount}">
				<g:link class="btn btn-success" action="practice" id="${deckInstance.id}" controller="deck" params="[rankingType: Constants.MEANING]">Practice Meanings</g:link>
				<g:link class="btn btn-success" action="practice" id="${deckInstance.id}" controller="deck" params="[rankingType: Constants.PRONUNCIATION]">Practice Pronunciations</g:link>
			</g:if>
			<g:if test="${isOwner}">
				<g:link class="btn btn-info add-flashcards" action="search" controller="unit" params="${['filter-alph': deckInstance.language.id, 'deck-id': deckInstance.id]}">Add Flashcards</g:link>
			</g:if>
		</div>
		<!-- end deck-header -->

		<div class="row">
			<g:each in="${flashcardInstanceList}">
				<div class="col-lg-3">
					<g:render template="/flashcard/flashcard" model="[flashcardInstance: it]"/>
				</div>
				<!-- end col-lg-3 -->
			</g:each>
		</div>
		<!-- end row -->

		<!-- this is the panel that indicates progress through the deck, perhaps this should move to a template for decks too -->
		<div class="pagination center-block text-center">
			<g:paginate controller="deck" action="show" id="${deckInstance.id}" total="${flashcardCount ?: 0}" />
		</div>

	</div>
	<!-- end container -->
</body>
</html>