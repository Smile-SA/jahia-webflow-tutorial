<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<form:form modelAttribute="contactInfos" method="post" >
    <fieldset>
        <legend>Mes informations de contact</legend>
        <div>
            <label for="email">Couriel : </label>
            <form:input path="email" type="text" id="email" name="email"/>
        </div>
        <div>
            <label for="mobilePhone">
                <fmt:message key="label.cellphone" />
            </label>
            <form:input path="mobilePhone" type="text" id="mobilePhone" name="mobilePhone"/>
        </div>
        <div>
            <label for="homePhone">
                <fmt:message key="label.phone" />
            </label>
            <form:input path="homePhone" type="text" id="homePhone" name="homePhone"/>
        </div>
        <div>
            <button id="next" type="submit" name="_eventId_next">Suivant</button>
            <button id="finish" type="submit" name="_eventId_finish">Finir</button>
        </div>
    </fieldset>
</form:form>