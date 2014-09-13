<html dir="rtl">
<head>
    <title>TraffiTruck</title>
	<meta charset="UTF-8">
</head>
<body>
<h2>הוסף מטען</h2>
<form method="post" action="newload">
 
    <table>
    <tr>
        <td><label for="source">מוצא</label></td>
        <td><input name="source" /></td> 
    </tr>
    <tr>
        <td><label for="destination">יעד</label></td>
        <td><input name="destination" /></td>
    </tr>
    <tr>
        <td><label for="weight">משקל</label></td>
        <td><input name="weight" /></td>
    </tr>
    <tr>
        <td><label for="suggestedQuote">מחיר</label></td>
        <td><input name="suggestedQuote" /></td>
    </tr>
    <tr>
        <td colspan="2">
            <input type="submit" value="הוסף מטען"/>
        </td>
    </tr>
</table>  
     
</form>
</body>
</html>