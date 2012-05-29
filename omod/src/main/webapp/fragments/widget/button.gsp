<%
// supports icon, iconProvider, label, extra
// supports onClick (javascript snippet)
// supports href (link url)
// supports classes (applied to button)

def id = config.id ?: ui.randomId("button")
def classes = [ "button " ];
if (config.classes) {
	classes.addAll(config.classes)
}
%>
<style>
.button > .icon {
	float: left;
}
.button > .labels {
	float: left;
	font-size: 1.4em;
	padding-left: 0.5em;
	padding-right: 0.5em;
}
.button > .labels > .extra {
	font-size: 0.8em;
}
</style>

<button id="${ id }" class="${ classes.join(' ') }">
	<% if (config.icon) { %>
		<img class="icon" src="${ ui.resourceLink(config.iconProvider, "images/" + config.icon) }" />
	<% } %>
	<span class="labels">
		<% if (config.label) { %>
			<span class="label">${ config.label }</span>
		<% } %>
		<% if (config.extra) { %>
			<br/>
			<span class="extra">${ config.extra }</span>
		<% } %>
	</span>
	<% if (config.href) { %></a><% } %>
</button>

<% if (config.href || config.onClick) { %>
	<script>
		jq(function() {
			jq('#${ id }').click(function() {
	<% if (config.onClick) { %>
				${ config.onClick }
	<% } %>
	<% if (config.href) { %>
				location.href = '${ ui.escapeJs(config.href) }'
	<% } %>
			});
		});
	</script>
<% } %>