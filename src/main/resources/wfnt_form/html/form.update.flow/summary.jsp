<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="well span6" style="float:none;margin:0 auto">
    <div class="clearfix">
        <div class="pull-right">
            <progress max="4" value="4">(Step 4 of 4)</progress>
        </div>
    </div>

    <h2>V&eacute;rifier vos modifications</h2>

    <dl class="dl-horizontal">
        <dt>
            <fmt:message key="wfnt_form.email"/>
        </dt>
        <dd>
            ${fn:escapeXml(contactInfo.email)}
        </dd>
        <dt>
            <fmt:message key="wfnt_form.phone"/>
        </dt>
        <dd>
        	${fn:escapeXml(contactInfo.phone)}
        </dd>
        <dt>
            <fmt:message key="wfnt_form.mobile"/>
        </dt>
        <dd>
        	${fn:escapeXml(contactInfo.mobile)}
        </dd>
    </dl>

    <form:form modelAttribute="contactInfo" class="form-horizontal" method="post">
        <div class="form-actions">
            <button id="cancel" class="btn" type="submit" name="_eventId_cancel">
                Annuler
            </button>

            <div class="pull-right">
                <button id="previous" class="btn" type="submit" name="_eventId_previous">
                    Pr&eacute;c&eacute;dent
                </button>
                <button id="next" class="btn btn-primary" type="submit" name="_eventId_finish">
                    Valider
                </button>
            </div>
        </div>
    </form:form>
</div>