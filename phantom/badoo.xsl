<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
<body>
<table border="1">
	<tr bgcolor="#CCCCCC">
		<td align="center"><strong>img</strong></td>
		<td align="center"><strong>name</strong></td>
		<td align="center"><strong>age</strong></td>
		<td align="center"><strong>score</strong></td>
		<!--<td align="center"><strong>url</strong></td>-->
		<td align="center"><strong>want</strong></td>
		<td align="center"><strong>info</strong></td>
	</tr>
	<xsl:for-each select="table/girl">
		<tr bgcolor="#F5F5F5">
			<td> <a> <xsl:attribute name="href">  <xsl:value-of select="@url"/></xsl:attribute> 
			<img> <xsl:attribute name="src">  <xsl:value-of select="@img"/> </xsl:attribute> </img> 
			</a>
			</td> 
			<td> <xsl:value-of select="@name"/></td>
			<td><xsl:value-of select="@age"/></td>
			<td><xsl:value-of select="@score"/></td>
			<!--<td><a> <xsl:attribute name="href">  <xsl:value-of select="@url"/></xsl:attribute> анкета</a></td>-->
			<td><xsl:value-of select="@want"/></td>
			<td><xsl:value-of select="."/></td>
		</tr>
	</xsl:for-each>
</table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>

<!--<td><xsl:value-of select="text()"/></td>-->