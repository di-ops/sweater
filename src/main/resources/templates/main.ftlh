<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>
<@c.page>
<h3></h3>
<@l.logout/>
    <form method="post">
        <input type="text" name="text" placeholder="Input text of your message">
        <input type="text" name="tag" placeholder="Create tags for search">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type= "submit" value="Add message">
    </form>
    <div>
        <h3>Список сообщений</h3>
    </div>
    <form method="get" action="/main">
        <input type="text" name="filter" value="${filter!}" placeholder="Find by tag"/>
        <button type="submit">Find</button>
    </form>
    <#list messages as message>
    <div>
        <strong>${message.id}</strong>
        <strong>${message.authorName}</strong>
        <span>${message.text}</span>
        <i>${message.tag}</i>
    </div>
    <#else>
        No messages
    </#list>
</@c.page>