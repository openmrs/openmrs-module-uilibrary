<% ui.includeCss("uilibrary", "jquery-ui.css") %>
<% ui.includeCss("uilibrary", "uilibrary.css") %>
<% ui.includeCss("uilibrary", "tipTip.css") %>
<% ui.includeCss("uilibrary", "toastmessage/css/jquery.toastmessage.css") %>
<% ui.includeJavascript("uilibrary", "jquery.js") %>
<% ui.includeJavascript("uilibrary", "jquery-ui.js") %>
<% ui.includeJavascript("uilibrary", "jquery.tipTip.minified.js") %>
<% ui.includeJavascript("uilibrary", "jquery.toastmessage.js") %>
<% ui.includeJavascript("uilibrary", "pagebus/simple/pagebus.js") %>
<% ui.includeJavascript("uilibrary", "uiframework.js") %>
<% ui.includeJavascript("uilibrary", "ui.js") %>

${ ui.includeFragment("uilibrary", "maybeRequireLogin") }

<script>
    var jq = jQuery;
    var CONTEXT_PATH = '${ contextPath }';
</script>