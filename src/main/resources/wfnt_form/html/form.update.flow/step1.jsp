<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:if test="${not empty currentUser.properties['j:email'] }">
    <c:set var="filledEmail" value="${fn:escapeXml(currentUser.properties['j:email'])}"/>
</c:if>

<div class="well span6" style="float:none;margin:0 auto">
    <div class="clearfix">
        <div class="pull-right">
            <progress max="4" value="1">(Step 1 of 4)</progress>
        </div>
    </div>
    <form:form modelAttribute="contactInfo" class="form-horizontal" method="post">
        <fieldset>
            <legend>Modifier votre adresse email</legend>
            <%@ include file="validation.jspf" %>
            <div class="control-group">
                <label class="control-label" for="email">
                    <span class="hide-text">Modifier votre </span><fmt:message key="wfnt_form.email"/> :</label>

                <div class="controls">
                    <form:input path="email" type="email" id="email" name="email" value="${filledEmail}"/>
                </div>
            </div>
            <div class="form-actions">
                <button id="cancel" class="btn" type="submit" name="_eventId_cancel">
                    Annuler
                </button>

                <div class="pull-right">
                    <button id="next" class="btn btn-primary" type="submit" name="_eventId_next">
                        Suivant
                    </button>
                </div>
            </div>
        </fieldset>
    </form:form>
</div>