<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<my:template action="index">
    <my:title title="Liste des tâches"></my:title>

    <div class="card invoices-card">
        <div class="card-content">
            <div class="card-options">
            </div>
            <span class="card-title">Projet : ${jalon.project.name} / Jalon : ${jalon.label}</span>
            <c:if test="${tasks == null || tasks.isEmpty()}">
                <div class="center">Aucune tâche</div>
            </c:if>
            <c:if test="${!tasks.isEmpty()}">
                <table class="responsive-table bordered highlight">
                    <thead>
                    <tr>
                        <td data-field="state">Etat</td>
                        <td data-field="label">Sujet</td>
                        <td data-field="name">Description</td>
                        <td data-field="manager">Manager</td>
                        <td data-field="dateStart">Date de début <span><i class="material-icons tooltipped"
                                                                          data-position="left"
                                                                          data-delay="50" style="color: grey"
                                                                          data-tooltip="Dans le cas où la tâche n'est pas démarrée, la date de début reste une date théorique.">info_outline</i>
                    </span></td>
                        <td data-field="manager">Charge</td>
                        <td data-field="preivousTask">Tâche précédente</td>
                        <td data-field="actions">Actions</td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${tasks}" var="task">
                        <tr>
                            <c:if test="${task.etat == 'UNSTART'}">
                                <td><i class="large material-icons tooltipped" data-position="left" data-delay="50"
                                       data-tooltip="Tâche non démarrée (0%)" style="color: #ee6e73; font-size: 2em;">settings_power</i>
                                </td>
                            </c:if>
                            <c:if test="${task.etat == 'STARTED'}">
                                <td><i class="large material-icons tooltipped" data-position="left" data-delay="50"
                                       data-tooltip="Tâche démarrée (50%)" style="color: #26a69a; font-size: 2em;">play_arrow</i>
                                </td>
                            </c:if>
                            <c:if test="${task.etat == 'FINISHED'}">
                                <td><i class="large material-icons tooltipped" data-position="left" data-delay="50"
                                       data-tooltip="Tâche Terminée (100%)"
                                       style="color: #26a69a; font-size: 2em;">done</i>
                                </td>
                            </c:if>
                            <td>${task.label}</td>
                            <td>${task.description}</td>
                            <td>${task.manager.trigramme}</td>
                            <td><fmt:formatDate value="${task.dateStart}" type="date"/></td>
                            <td>${task.charge} jours</td>
                            <c:if test="${task.previousTask != null}">
                                <td>${task.previousTask.label}</td>
                            </c:if>
                            <c:if test="${task.previousTask == null}">
                                <td>Aucune</td>
                            </c:if>
                            <td>
                                <c:if test="${task.etat == 'UNSTART'}">
                                    <a href="${pageContext.request.contextPath}/task/${task.id}/start/jalon/${jalon.id}"
                                       class="btn-floating btn-small waves-effect waves-light tooltipped"
                                       data-position="left" data-delay="50" data-tooltip="Démarrer la tâche">
                                        <i class="material-icons">play_arrow</i>
                                    </a>
                                </c:if>

                                <c:if test="${task.etat == 'STARTED'}">
                                    <a href="${pageContext.request.contextPath}/task/${task.id}/stop/jalon/${jalon.id}"
                                       class="btn-floating btn-small waves-effect waves-light tooltipped"
                                       data-position="left" data-delay="50" style="background-color: #ee6e73;"
                                       data-tooltip="Arrêter la tâche">
                                        <i class="material-icons">settings_power</i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/task/${task.id}/finish/jalon/${jalon.id}/"
                                       class="btn-floating btn-small waves-effect waves-light tooltipped"
                                       data-position="left" data-delay="50"
                                       data-tooltip="Terminer la tâche">
                                        <i class="material-icons">done</i>
                                    </a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>

    <input id='showErrorMessage' type="hidden" value=${showErrorMessage}/>
</my:template>