<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main"/>
	<title>OpenFluency</title>
</head>
<body>
	<div class="container flashcard-create">
		<ul class="breadcrumb">
            <li><a href="${createLink(uri:'/') }">Home</a></li>
            <li>Decks</li>
            <li><a href="${createLink(uri:'/unit/search?filter-alph=1') }">Flashcard Search</a></li>
            <li><a href="#">Create Flashcard </a></li>
        </ul>
		<div class="row">
			<div class="col-lg-5">
				<g:hasErrors bean="${flashcardInstance}">
					<ul class="errors" role="alert">
						<g:eachError bean="${flashcardInstance}" var="error">
							<li>
								<g:message error="${error}"/>
							</li>
						</g:eachError>
					</ul>
				</g:hasErrors>

				<h1>Create flashcard for ${unitInstance?.print}</h1>

				<g:form action="save" controller="flashcard" name="createFlashcardForm">

					<input type="hidden" name="unit" value="${unitInstance.id}"/>

					<div class="form-group">
						<label class="control-label">What meaning do you want to use?</label>
						<select name="unitMapping" class="form-control">
							<g:each in="${unitInstance.unitMappings}">
								<option value="${it.id}">
									${it.unit1.id == unitInstance.id ? it.unit2.print : it.unit1.print}
								</option>
							</g:each>
						</select>
					</div>

					<div class="form-group">
						<label class="control-label">What pronunciation do you want to use?</label>
						<g:select class="form-control" name="pronunciation" from="${unitInstance.pronunciations}" optionKey="id" optionValue="literal" id="fc_pronunciation"/>
					</div>

					<div class="form-group">
						<label class="control-label">What deck should this card go into?</label>
						<g:select class="form-control" name="deck" from="${userDecks}" optionKey="id" optionValue="title"/>
					</div>

					<div class="form-group">
						<label class="control-label">What image should be associated with this card (optional)?</label>
						<g:textField class="form-control" id="imageLink" name="imageLink" value="${flashcardInstance?.image}"/>
					</div>
					<g:if test="${flashcardInstance?.audio}">
						<div class="form-group">
							<label class="control-label">
								What audio clip provides pronunciation for this card (optional)?
							</label>
							<g:textField class="form-control" name="audio" value="${flashcardInstance?.audio}"/>
						</div>
					</g:if>
					<div class="form-group audio">
						<label class="control-label">
							Record a pronunciation (optional)
						</label>
						<audio id="audioClip" controls autoplay></audio>
						</br>
						<input id="start_rec_button" name="start_button" type="button" value="Start Recording" class="btn btn-info"/>
						<input id="stop_rec_button" name="stop_button" type="button" value="Stop Recording" class="btn btn-info"/>
						<input id="save_rec_button" name="save_button" type="button" value="Save Recording" class="btn btn-warning"/>
						<input id="audio_id" name="audio_id" type="hidden" value=""/>
						</br>
						<span><i>*may need to click 'Allow' in audio permissions pop up</i></span>
						</br>
					</div>
					<button id="goCreate" class="center btn btn-success">Create it!</button>
					<span id="audioSaveMessage"><i>*did you save your audio?</i></span>
				</g:form>
			</div>
			<div class="col-lg-7">
				<h1>Flickr Search</h1>
				<label for="query">Query:</label>
				<input id="query" name="query" type="text" size="60" placeholder="Type here to find your photo" />
				<button id="flickr_search" class="btn btn-info">Search</button>
				<div id="results"></div>
				<button id="flickr_back" class="btn btn-info">Back</button>
				<label id="flickr_page_number"></label>
				<button id="flickr_next" class="btn btn-info">Next</button>
			</div>
		</div>
	</div>

	<!-- all page specific click event handlers relating to image searh and audio are in the create_flashcard.js file -->
	<g:javascript src="create_flashcard.js"/>
	<!-- all the javascript references needed for audio recording -->
	<g:javascript src="recorderWorker.js"/>
	<g:javascript src="recorder.js"/>
	<g:javascript src="create_audio.js"/>
	<!-- this line is left hear as it relies on taking a formData created in create_audio.js and passes to create_flashcard.js -->
	<g:javascript>
		$("#audioSaveMessage").hide();
		$("#save_rec_button").hide();
		$("#save_rec_button").click(function(){
			saveAudioRecording(formData);
			$("#audioSaveMessage").hide();
			$("#goCreate").removeClass('btn-warning').addClass('btn-success');
		});
	</g:javascript>
	
</body>
</html> 
