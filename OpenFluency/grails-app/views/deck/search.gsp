<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>
    <div class="container deck-search">
        <ul class="breadcrumb">
            <li><a href="${createLink(uri:'/') }">Home</a></li>
            <li>Decks</li>
            <li><g:link action="search" controller="deck" >Search for Decks</g:link></li>
        </ul>
        <h1>Deck Search</h1>

        <div class="row">

            <g:form action="search" controller="Course">
                <div class="col-lg-4">
                    <select id="filter-lang" class="form-control" name="filter-lang">
                        <g:each in="${languageInstanceList}">
                            <g:if test="${it.id == languageId}">
                                <option value="${it.id}" selected>${it.name}</option>
                            </g:if>
                            <g:else>
                                <option value="${it.id}">${it.name}</option>
                            </g:else>
                        </g:each>
                    </select>
                </div>
                <!-- end col-lg-4 -->

                <div class="col-lg-4">
                    <div class="input-group">
                        <g:textField class="form-control" name="search-text" placeholder="Type a keyword" id="search-text" value="${keyword}"/>
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="submit">
                                <span class="glyphicon glyphicon-search"></span>
                            </button>
                        </span>
                    </div>
                </div>
            </g:form>
        </div>
        <!-- end row -->

        <table class="table">
            <thead>
                <tr>
                    <th>Deck title</th>
                    <th>Language</th>
                    <th>Description</th>
                    <th>Created by</th>
                    <th>Last Updated</th>
                    <th></th>
                </tr>
            </thead>
            <g:each in="${deckInstanceList}">
                <tr>
                    <td>
                        <g:link action="show" controller="deck" id="${it.id}">${it.title}</g:link>
                    </td>
                    <td>${it.language}</td>
                    <td>${it.description}</td>
                    <td>${it.owner.username}</td>
                    <td>${it.lastUpdated}</td>
                    <td>
                          <g:link action="add" controller="decks" id="${it.id}" class="btn btn-info">Add to My Decks</g:link>
                    </td>
                </tr>
            </g:each>
        </table>
    </div>
    <!-- end container -->
    </div>
</body>
</html>