<?xml version="1.0" encoding="utf-8"?>
<!--
- Copyright (C) 2010-2016 GlobalTranz - All Rights Reserved. 
-
- Proprietary and confidential. Unauthorized copying of this file, via any
- medium is strictly prohibited without the explicit permission of GlobalTranz. 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>
  
  <xsl:param name="Carrier"/>
  <xsl:param name="FileName"/>
  <xsl:param name="Records"/>
  <xsl:param name="DateTime"/>
  <xsl:param name="Details"/>
  
  <xsl:template match="/">
      <html>      
        <body>
        EDI Processing Success
          <table style="border: solid 3px  #007fba;">
            <tr>
              <td style="width:100px">
                <b> Carrier</b>
              <td>
                  <b>:</b>
              </td>
              </td>
              <td >
                <xsl:value-of select="$Carrier"/>
              </td>
            </tr>
            <tr >
              <td style="width:100px">
                <b> FileName</b>
              <td>
                  <b>:</b>
              </td>
              </td>
              <td style="width:100px">
                <xsl:value-of select="$FileName"/>
              </td>
            </tr>            
	          <tr >
              <td style="width:100px">
                  <b> Records </b>
              <td>
                  <b>:</b>
              </td>
              </td>
              <td >
                <xsl:value-of disable-output-escaping="yes" select="$Records"/>
              </td>
            </tr>
            <tr>
              <td style="width:100px">
                <b> DateTime</b>
              <td>
                  <b>:</b>
              </td>
              </td>
              <td >
                <xsl:value-of select="$DateTime"/>
              </td>
            </tr>
            <tr valign="top">
              <td style="width:100px " >
                <b> Details</b>
              <td>
                  <b>:</b>
              </td>
              </td>
              <td >
                <xsl:value-of select="$Details"/>
              </td>
            </tr>
          </table>
        <b>Note:-</b> This is an auto generated email, Please do not reply to this email.
        </body>
      </html>
    </xsl:template>
</xsl:stylesheet>
