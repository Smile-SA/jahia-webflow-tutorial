<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:if test="${not empty currentNode.user.properties['j:mobileNumber'].string }">
    <c:set var="filledMobile" value="${fn:escapeXml(currentNode.user.properties['j:mobileNumber'].string)}"/>
</c:if>

<div class="well span6" style="float:none;margin:0 auto">
    <div class="clearfix">
        <div class="pull-right">
            <progress max="4" value="3">(Step 3 of 4)</progress>
        </div>
    </div>

    <form:form modelAttribute="contactInfo" class="form-horizontal" method="post">
        <fieldset>
            <legend>Modifier votre num&eacute;ro de t&eacute;l&eacute;phone mobile</legend>
            <%@ include file="validation.jspf" %>
            <div class="control-group">
                <label class="control-label" for="mobile"><fmt:message key="wfnt_form.mobile"/> :</label>

                <div class="controls">
                    <form:input path="mobile" type="tel" id="mobile" name="mobile" value="${filledMobile}"/>
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