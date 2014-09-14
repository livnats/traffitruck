<html dir="rtl">
<head>
    <title>TraffiTruck</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/traffitruck.css">
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
			<h2>הוסף מטען</h2>
			<form method="post" action="newload">
			 
			    <table>
			    <tr>
			        <td><label for="type">סוג המטען:</label></td> 
			        <td>
				        <input list="types" name="type"/>
						<datalist id="types">
						  <option value="מכולה 20'">
						  <option value="מכולה 40'">
						  <option value="משטחים">
						  <option value="שקים (באלות)">
						  <option value="בעלי חיים">
						  <option value="תפזורת">
						  <option value="חומ''ס">
						</datalist>
					</td>
			    </tr>
			    <tr>
			        <td><label for="weight">משקל:</label></td>
			        <td><input name="weight" /></td>
			    </tr>
			    <tr>
			        <td><label for="volume">נפח:</label></td>
			        <td><input name="volume" /></td>
			    </tr>
			    <tr>
			        <td><label>מוצא:</label></td>
			        <td><input name="source" /></td> 
			    </tr>
			    <tr>
			        <td><label for="source">סוג טעינה:</label></td> 
			    </tr>
			    <tr>
			        <td><label for="destination">יעד:</label></td>
			        <td><input name="destination" /></td>
			    </tr>
			    <tr>
			        <td><label>סוג פריקה:</label></td> 
			    </tr>
			    <tr>
			        <td><label for="suggestedQuote">מחיר:</label></td>
			        <td><input name="suggestedQuote" /></td>
			    </tr>
			    <tr>
			        <td><label for="comments">הערות:</label></td> 
			        <td><input name="comments" /></td>
			    </tr>
			    <tr>
			        <td colspan="2">
			            <input type="submit" value="הוסף מטען"/>
			        </td>
			    </tr>
			</table>
			<!-- inlcude csrf token -->
		    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
		</div>
	</div>
</div>
</body>
</html>