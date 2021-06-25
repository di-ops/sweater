<#import "parts/common.ftlh" as c>
<@c.page>
    <form method="get" action="/main">
        <div class="input-group mb-3">
            <input class="form control me-3 ps-1" type="text" name="filter" value="${filter!}" placeholder="Find by tag"/>
            <input class="btn btn-secondary btn-sm me-3 rounded" type="submit" value="Find by tag"/>
            <a class="btn btn-dark rounded" data-bs-toggle="collapse" href="#collapse" role="button" aria-expanded="false" aria-controls="collapseExample">
                Add new message
            </a>
        </div>
    </form>
    <form class = "collapse" id="collapse" method="post" enctype="multipart/form-data">
        <div class ="form-group mt-3">
            <div class ="form-group mt-3">
                <input class="form-control" type="text" name="text" placeholder="Input text of your message">
            </div>
            <div class ="form-group mt-3">
                <input class="form-control" type="text" name="tag" placeholder="Create tags for search">
            </div>
            <div class ="form-group mt-3">
                <div class="custom-file">
                    <input class="form-control" type="file" name="file">
                </div>
            </div>
            <input class="form-control"  type="hidden" name="_csrf" value="${_csrf.token}">
            <input class="btn btn-dark mt-3 mb-3" type= "submit" value="Send">
        </div>
    </form>
    <div>
    </div>
    <div class="row row-cols-md-2 g-1">
        <#--<div class="col">-->
            <#list messages as message>
                <div class="card m-3" style="width: 22rem;">
                    <#if message.filename??>
                        <img src="img/${message.filename}" class="card-img-top">
                    </#if>
                    <div class="m-2">
                        <span>${message.text}</span>
                    </div>
                    <i class="text-center">${message.tag}</i>
                    <div class="card-footer text-center position bottom">
                        <strong>${message.authorName}</strong>
                    </div>
                </div>
            <#else>
                No messages
            </#list>
        <#--</div>-->
    </div>
</@c.page>