<%@ page import="com.openfluency.Constants" %>
 	<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <script src="http://code.jquery.com/jquery-1.10.2.js"></script>
    <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script>
     $(function() {
     var newDate = new Date();   
    $("#liveTime_id").datepicker();
    $("#liveTime_id").datepicker("setDate", newDate);
     $( "#endTime_id" ).datepicker({ defaultDate: new Date() });
     
  });
    function test2(){
    document.getElementById("liveTime_id").innerHTML = new Date();
    }
  </script>  
  
<div class="form-group">
	<label for="title">Title:</label>
	<input required name="title" type="text"  value="${quizInstance?.title}" class="form-control"/>
</div>

<div class="form-group">
	<label for="maxCardTime">
		Maximum seconds allowed per card (if 0, the quiz will not be timed):
	</label>
	<g:field required type="number" min="0" max="60" name="maxCardTime" value="${quizInstance?.maxCardTime ? quizInstance?.maxCardTime : 0 }" class="form-control"/>
</div>

<div class="form-group live-time-group">
	<label for="liveTime">Available starting:</label>
	    <p><input type="text" name="liveTime" id="liveTime_id"></p> 
</div>
<g:hiddenField name="courseInstanceId" value="${courseInstance.id}" />

<div class="form-group end-time-group">
	<label for="endTime">Available until:</label>
		<p><input type="text" name="endTime" id="endTime_id"> </p> 
</div>

<div class="form-group" id="questionList">

	<g:each var="question" status="i" in="${quizInstance?.questions}">

		<div class="question panel panel-default question-panel">
		
			<div class="panel-heading">
				<label>Question ${i + 1}</label>
				<div class="card-actions">
					<span class="btn btn-xs btn-danger" onclick="if (confirm('are you sure?')) { $(this).parent().parent().parent().remove(); writeCSV(); }"><span class="glyphicon glyphicon-remove"></span></span>
				</div>
			</div>
		
				<div class="form-group">
					<input name="question" class="form-control" type="text" onchange="writeCSV();" onkeyup="writeCSV();" value="${question.question}"/>
				</div>
		
				<label>Correct Answer</label>
		
				<div class="form-inline">
					<input name="correctAnswer" class="form-control" type="text" onchange="writeCSV();" onkeyup="writeCSV();" value="${question.correctOption.option}"/>
					<span class="btn btn-xs btn-info" onclick="getConfusers(this);"><span class="glyphicon glyphicon-cog"></span> Generate Confuser Answers</span>
				</div>
				
				<div class="form-inline">
					<label>Wrong Answers</label>
					<span class="btn btn-xs btn-info" onclick="addWrongAnswer(this); writeCSV();"><span class="glyphicon glyphicon-plus"></span></span>
				</div>
		
				<g:each var="wrongOption" in="${question.wrongOptions}">
					<div class="form-inline">
						<input name="wrongAnswer" class="form-control" type="text" onchange="writeCSV();" onkeyup="writeCSV();" value="${wrongOption.option}"/>
						<span class="btn btn-xs btn-danger" onclick="$(this).parent().remove(); writeCSV();"><span class="glyphicon glyphicon-remove"></span></span>
					</div>
				</g:each>
		</div>
	
	</g:each>
</div>

<div class="form-group">
	<span class="btn btn-info" onclick="addQuestion(); writeCSV();"><span class="glyphicon glyphicon-plus"></span> Add a Question</span>
</div>

 <div class="form-group">
	 <div id="showCSV" class="btn btn-info" onclick="showCSV()">Show Raw Quiz CSV</div>
	 <textArea class="form-control" name="questions" style="display:none" readonly></textArea>
 </div>
 
 <script type="text/javascript">

		function getConfusers(that) {
			
			var question = $(that).parent().parent();
			var input = question.find("input[name=correctAnswer]").val();

			var languageCode = "${courseInstance?.language?.code}" || "JAP";
			var url = "/OpenFluency/Confuser/generate?languageCode=" + languageCode + "&number=-1&word=" + input;

			$.ajax({
				url: url
			})
			.done(function(jarray) {

				console.log(jarray);
				
				var wrongAnswers = question.find("input[name=wrongAnswer]");
				var length = wrongAnswers.length;
				
				wrongAnswers.each(function(index, item) {
					if (index <= jarray.length) {
						$(item).val(jarray[index]);
					}
				});

				writeCSV();
			});
	 	}
 
 		function addWrongAnswer(that) {
 			var question = $(that).parent().parent();

 			var wrongAnswerHtml = "<div class=\"form-inline\">";
 			wrongAnswerHtml += "<input name=\"wrongAnswer\" class=\"form-control\" type=\"text\" onchange=\"writeCSV();\" onkeyup=\"writeCSV();\" value=\"\"/>";
 			wrongAnswerHtml += "<span class=\"btn btn-xs btn-danger\" onclick=\"$(this).parent().remove(); writeCSV();\"><span class=\"glyphicon glyphicon-remove\"></span></span>";
 			wrongAnswerHtml += "</div>";

 			question.append(wrongAnswerHtml);
 	 	}

 		function showCSV() {
	 		if ($("textArea").is(':visible')) {
		 		$("textArea").hide();
		 		$("#showCSV").html("Show Raw Quiz CSV");
		 	}
	 		else {
	 			$("textArea").show();
	 			$("#showCSV").html("Hide Raw Quiz CSV");
		 	}
	 	}
 
 		function addQuestion() {

			var questionHtml = "<div class=\"question panel panel-default question-panel\">";
			questionHtml += "<div class=\"panel-heading\">";
			questionHtml += "<label>Question</label>";
			questionHtml += "<div class=\"card-actions\">";
			questionHtml += "<span class=\"btn btn-xs btn-danger\" onclick=\"if (confirm('are you sure?')) { $(this).parent().parent().parent().remove(); writeCSV(); }\"><span class=\"glyphicon glyphicon-remove\"></span></span>";
			questionHtml += "</div>";
			questionHtml += "</div>";
			questionHtml += "<div class=\"form-group\">";
			questionHtml += "<input name=\"question\" class=\"form-control\" type=\"text\" onchange=\"writeCSV();\" onkeyup=\"writeCSV();\" value=\"\"/>";
			questionHtml += "</div>";
			questionHtml += "<label>Correct Answer</label>";
			questionHtml += "<div class=\"form-inline\">";
			questionHtml += "<input name=\"correctAnswer\" class=\"form-control\" type=\"text\" onchange=\"writeCSV();\" onkeyup=\"writeCSV();\" value=\"\"/>";
			questionHtml += "<span class=\"btn btn-xs btn-info\" onclick=\"getConfusers(this);\"><span class=\"glyphicon glyphicon-cog\"></span> Generate Confuser Answers</span>";
			questionHtml += "</div>";
			questionHtml += "<div class=\"form-inline\">";
			questionHtml += "<label>Wrong Answers</label>";
			questionHtml += "<span class=\"btn btn-xs btn-info\" onclick=\"addWrongAnswer(this); writeCSV();\"><span class=\"glyphicon glyphicon-plus\"></span></span>";
			questionHtml += "</div>";
			questionHtml += "<div class=\"form-inline\">";
			questionHtml += "<input name=\"wrongAnswer\" class=\"form-control\" type=\"text\" onchange=\"writeCSV();\" onkeyup=\"writeCSV();\" value=\"\"/>";
			questionHtml += "<span class=\"btn btn-xs btn-danger\" onclick=\"$(this).parent().remove(); writeCSV();\"><span class=\"glyphicon glyphicon-remove\"></span></span>";
			questionHtml += "</div>";
			questionHtml += "<div class=\"form-inline\">";
			questionHtml += "<input name=\"wrongAnswer\" class=\"form-control\" type=\"text\" onchange=\"writeCSV();\" onkeyup=\"writeCSV();\" value=\"\"/>";
			questionHtml += "<span class=\"btn btn-xs btn-danger\" onclick=\"$(this).parent().remove(); writeCSV();\"><span class=\"glyphicon glyphicon-remove\"></span></span>";
			questionHtml += "</div>";
			questionHtml += "<div class=\"form-inline\">";
			questionHtml += "<input name=\"wrongAnswer\" class=\"form-control\" type=\"text\" onchange=\"writeCSV();\" onkeyup=\"writeCSV();\" value=\"\"/>";
			questionHtml += "<span class=\"btn btn-xs btn-danger\" onclick=\"$(this).parent().remove(); writeCSV();\"><span class=\"glyphicon glyphicon-remove\"></span></span>";
			questionHtml += "</div>";
			questionHtml += "</div>";

 			var questionList = $("#questionList");

 			var html = questionList.append(questionHtml);
 	 	}	
 
        function writeCSV() {
            var s = "";
			$(".question").each(function(index,item) {

				s += "MANUAL,"
				 
				var inputs = $(this).find("input");
				var length = inputs.length;
				inputs.each(function(index, item) { 

					// Use quotes in case the string contains commas
					// Convert quote in string to double quote
					s += '"';
					s += $(this).val().replace(/"/g, '""');
					s += '"';
					
					if (index != (length - 1)) {
						s += ",";	
					} 
				});
				s += "\n"; 
			});

			$("textArea").val(s);
        }

		writeCSV();
</script>
 
 