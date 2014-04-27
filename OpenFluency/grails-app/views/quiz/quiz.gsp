<%@ page import="com.openfluency.Constants" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main"></head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<g:form action="nextQuestion" controller="quiz" id="${answerInstance.id}">
					<h1>${answerInstance.question.flashcard.primaryUnit.print}</h1>
					<p>
						Which one of these ${Constants.CARD_ELEMENTS[answerInstance.question.quiz.testElement]}s does this symbol correspond to?
					</p>
					<g:each in="${answerInstance.question.selections}">
						<div class="radio">
							<label>
								<input type="radio" name="option" id="option" value="${it.id}" checked>
								<g:if test="${answerInstance.question.quiz.testElement == Constants.MEANING}">${it.secondaryUnit.print}</g:if>
								<g:elseif test="${answerInstance.question.quiz.testElement == Constants.PRONUNCIATION}">${it.pronunciation}</g:elseif>
							</label>
						</div>
					</g:each>
					<button type="submit" class="btn btn-info">Next Question</button>
				</g:form>
			</div>
		</div>
	</div>
</body>