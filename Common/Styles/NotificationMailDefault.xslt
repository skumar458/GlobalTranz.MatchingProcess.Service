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
  
  <xsl:param name="Scenario"/>  
  <xsl:param name="Details"/>  

  <xsl:template match="/">
      <html>      
        <body>
          <table align="center" style="border: solid 3px  #007fba;">
            <tr align="center">
              <td>
                <b> Scenario :</b>
              </td>
              <td >
                <xsl:value-of select="$Scenario"/>
              </td>
            </tr>
            <tr align="center">
              <td>
                <b> Details  : </b>
              </td>
              <td >
                <xsl:value-of select="$Details"/>
              </td>
            </tr>
            <tr align="center">
              <td>
                <b> Note  : </b>
              </td>
              <td >
                <b> This is an automated mail, Please do not reply </b>
              </td>
            </tr>
          </table>
        </body>
      </html>
    </xsl:template>
</xsl:stylesheet>
