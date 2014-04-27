<%@ page import="com.openfluency.course.Registration" %>
<%@ page import="com.openfluency.Constants" %>
<%@ page import="com.openfluency.course.Quiz" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

    <div class="container course-enrolled">
        <ul class="breadcrumb">
            <li>
                <a href="${createLink(uri:'/') }">Home</a>
            </li>
            <li>
                <g:link action="search" controller="course" >Courses</g:link>
            </li>
            <li>
                <g:link action="show" controller="course" id="${courseInstance.id}">${courseInstance.getCourseNumber()}: ${courseInstance.title}</g:link>
            </li>
            <li>
                <a href="#">Enrolled Students</a>
            </li>
        </ul>
        <h1 id="main">Enrolled Students</h1>
        <br/>
        <br/>
        <table class="table courses-table">
            <thead>
                <tr>
                    <th>User Name</th>
                    <th>Native Language</th>
                    <th>Enrollment Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <g:each in="${enrolledStudents}">
                <tr class="course-result">
                    <td>${it.user.username}</td>
                    <td>${it.user.nativeLanguage}</td>
                    <td>${Constants.REGISTRATION_STATUS[it.status]}</td>
                    <td>
                        <g:if test="${it.status == Constants.PENDING_APPROVAL}">
                            <g:link controller="registration" action="approve" id="${it.id}" class="btn btn-success">Approve</g:link>
                            <g:link controller="registration" action="reject" id="${it.id}" class="btn btn-danger">Reject</g:link>
                        </g:if>
                    </td>
                </tr>
            </g:each>
        </table>

    </div>
    <!-- end container -->

</body>
</html>