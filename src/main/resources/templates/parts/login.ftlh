<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <div class="row mb-3">
            <label class="col-sm-2 col-form-label" for="username"> User Name :</label>
            <div class="col-sm-4">
                <input  class="form-control" type="text" id = "username" name="username"/>
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-2 col-form-label" for="password"> Password: </label>
            <div class="col-sm-4">
                <input  class="form-control" type="password" id="password" name="password"/>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <input class="btn btn-primary mb-3 me-5" type="submit" <#if !isRegisterForm> value="Sign In"<#else> value = "Sign Up"</#if> />

        <#if !isRegisterForm>
            <a href="/registration">
                <input class="btn btn-primary mb-3" type="button" value="Add new user"/>
            </a>
        </#if>
    </form>
</#macro>
<#macro logout>
    <form action="/logout" method="post">
        <input  class="btn btn-dark" type="submit" value="Sign Out"/>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
    </form>
</#macro>