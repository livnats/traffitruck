<html dir="rtl">
	<body>
	<#if loads?has_content>
		<table border="1">
			<tr>
				<th>מוצא</th>
				<th>יעד</th>
				<th>משקל</th>
				<th>מחיר</th>
				<th>תאריך</th>
			</tr>
			<#list loads as load>
				<tr>
					<td>${load.source}</td>
					<td>${load.destination}</td>
					<td>${load.weight!'לא נמסר'}</td>
					<td>${load.suggestedQuote!'לא נמסר'}</td>
					<td>${load.creationDate!''}</td>
				</tr>
			</#list>
		</table>
	<#else>
		No loads to show
	</#if>
	</body>
</html>