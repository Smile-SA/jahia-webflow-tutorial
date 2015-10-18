<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="values" value="${currentNode.propertiesAsString}"/>

<div class="well span6" style="float:none;margin:0 auto">
    <div class="clearfix">
        <div class="pull-right">
            <progress max="4" value="2">(Step 2 of 4)</progress>
        </div>
    </div>

    <form:form modelAttribute="contactInfo" class="form-horizontal" method="post">
        <fieldset>
            <legend>Modifier votre num&eacute;ro de t&eacute;l&eacute;phone</legend>
            <%@ include file="validation.jspf" %>
            <div class="control-group">
                <label class="control-label" for="phone"><fmt:message key="wfnt_form.phone"/> :</label>

                <div class="controls">
                    <form:input path="phone" type="tel" id="phone" name="phone" value="${values.phone}"/>
                </div>
            </div>
            <div class="form-actions">
                <button id="cancel" class="btn" type="submit" name="_eventId_cancel">
                    Annuler
                </button>

                <div class="pull-right">
                    <button id="previous" class="btn" type="submit" name="_eventId_previous">
                        Pr&eacute;c&eacute;dent
                    </button>
                    <button id="next" class="btn btn-primary" type="submit" name="_eventId_next">
                        Suivant
                    </button>
                </div>
            </div>
        </fieldset>
    </form:form>
</div>