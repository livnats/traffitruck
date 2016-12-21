<html dir="rtl">
<head>
    <title>TraffiTruck</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/traffitruck.css">
	<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>

<script type="text/javascript">
	
$(document).ready(function() {

	function convertRoles(rolesStr) {
		roles = rolesStr.split(" ");
		res = "";
		for (var i = 0; i < roles.length; i++) {
			role = roles[i];
	   		if ( role == "${enums["com.traffitruck.domain.Role"].TRUCK_OWNER}" )
				res += "בעל משאית, ";
	   		if ( role == "${enums["com.traffitruck.domain.Role"].LOAD_OWNER}" )
				res += "בעל מטען, ";
	   		if ( role == "${enums["com.traffitruck.domain.Role"].ADMIN}" )
				res += "מנהל מערכת, ";
		}
		return res.slice(0, -2);
	}
	
	$( ".roleConversion" ).each(function() {
	  $(this).html(convertRoles($(this).html()));
	});
	
});
</script>

<script>

	function allow_load_details(username){
		$.post(
			"/allow_load_details",
			{
				username: username,
				${_csrf.parameterName}: "${_csrf.token}"
			} 
		);
		$("#"+username).html("");
	}
	
</script>
</head>
<body>
<div id="main">
	<div id="title">
		<img src="/images/truck-blue.jpg" width="15%"/>
		<img src="/images/logo.jpg" width="20%"/>
	</div>
	<div id="body">
		<div id="sidebar">
			<p>&nbsp;</p>
		</div>
		<div id="content">
			<h2>כל המשתמשים</h2>
			<table>
				<tr> 
					<td>
						<a href="/adminMenu">חזור לעמוד הראשי</a>
					</td>
				</tr>
				<tr> 
					<td>
						<#if users?has_content>
								<table border="1">
									<tr>
										<th>שם משתמש</th>
										<th>אימייל</th>
										<th>סוג</th>
									</tr>
									<#list users as user>
									<#assign i=user?index>
									<tr id="${user.id!''}">
										<td>${user.username!''}</td>
										<td>${user.email!''}</td>
										<td class="roleConversion">${user.roles?join(" ")!''}</td>
										<#if !(user.allowLoadDetails?? && user.allowLoadDetails)>
											<td id="${user.username}"><a href='#' onclick="return allow_load_details('${user.username}')">אשר לראות מטענים בלי משאיות רשומות</a></td>
										</#if>
									</tr>
									</#list>
								</table>
					
						<#else>
							אין משתמשים 
						</#if>
					</td>
				</tr>
				<tr>
				<td>&nbsp;</td>
				</tr>
			</table>
		</div>
	</div>
</div>
</body>
</html>