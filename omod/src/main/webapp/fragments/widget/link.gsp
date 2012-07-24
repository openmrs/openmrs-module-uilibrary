<%
config.require("label", "onClick | href")
// onClick = javascript snippet ; href = link url
// supports classes (applied to a element)
%>

<a id="${ config.id }" href="${ config.href ?: "javascript:void()" }" <% if (config.classes) { %> class="${ config.classes.join(" ") }" <% } %> >
	${ config.label }
</a>

<% if (config.onClick) { %>
	<script>
		jq(function() {
			jq('#${ config.id }').click(function(event) {
				event.preventDefault();
				${ config.onClick }
				return false;
			});
		});
	</script>
<% } %>


