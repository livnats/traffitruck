<html dir="rtl">
	<body>
		<table border="0">
			<tr> 
				<td>
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
									<td>${load.creationDate?string("HH:mm dd-MM-yyyy")!''}</td>
								</tr>
								</#list>
							</table>
				
					<#else>
						אין מטענים להציג :(
					</#if>
				</td>
			</tr>
			<tr> 
				<td>
					<a href="/newload">הוספת מטען חדש</a>
				</td>
			</tr>
		</table>
	</body>
</html>