<?xml version="1.0" encoding="utf-8"?>
<!--
- Copyright (C) 2010-2016 GlobalTranz - All Rights Reserved. 
-
- Proprietary and confidential. Unauthorized copying of this file, via any
- medium is strictly prohibited without the explicit permission of GlobalTranz. 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="bolNumber"/>
  <xsl:param name="pickupDate"/>
  <xsl:param name="disputeReasons"/>
  <xsl:param name ="auditBaseCarrierName"/>
  <xsl:param name ="auditCarrierCode"/>
  <xsl:param name ="auditCarrierPriority"/>
  <xsl:param name ="auditCarrierId"/>
  <xsl:param name ="auditCarrierRatewareCode"/>
  <xsl:param name ="auditFuelDisputeReason"/>

  <xsl:template match='/'>
    <html>
      <body>
        <table border ='0' width ='100%' cellspacing='0' cellpadding='0'>
          <tr>
            <td>
              <table align = 'Left' width ='100%' border ='0' cellspacing='0' cellpadding='0'>
                <tr>
                  <td align='Left'>
                    Rate Department
                  </td>
                </tr>
              </table>
            </td>
          </tr>

          <tr>
            <td>
              &#160;
            </td>
          </tr>

          <tr>
            <td>
              <table align = 'Left' width ='100%' border ='0' cellspacing='0' cellpadding='0'>
                <!-- For Table Headers. -->
                <tr>
                  <td>
                    This alert is to inform you that sales order&#160;<xsl:value-of select="$bolNumber" />&#160;has been modified due to a discrepancy between carrier rate pricing and the service provider's program.<xsl:choose>
                      <xsl:when test ="string-length($auditFuelDisputeReason)!=0">
                        <xsl:value-of select ="$auditFuelDisputeReason"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>&#160;</xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>The&#160;<xsl:value-of select="$disputeReasons" />
                    in the original sales order does not match with the cost calculated by the tariff effective
                    &#160;<xsl:value-of select="$pickupDate" />.
                  </td>
                </tr>
                <tr>
                  <td>
                    <b>Tariff identified for the carrier</b>
                    <br></br>
                    &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Base Carrier Name&#160;:&#160;<xsl:value-of select="$auditBaseCarrierName" />
                    <br></br>
                    &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Carrier Code&#160;:&#160;<xsl:value-of select="$auditCarrierCode" />
                    <br></br>
                    &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Carrier Id&#160;:&#160;<xsl:value-of select="$auditCarrierId" />
                    <br></br>
                    &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Carrier Priority&#160;:&#160;<xsl:value-of select="$auditCarrierPriority" />
                    <br></br>
                    &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Rateware Code&#160;:&#160;<xsl:value-of select="$auditCarrierRatewareCode" />
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td>
              &#160;
            </td>
          </tr>

          <tr>
            <td>
              &#160;
            </td>
          </tr>
          <tr>
            <td>
              <table align = 'Left' width ='100%' border ='0' cellspacing='0' cellpadding='0'>
                <tr>
                  <td>
                    <b>Note: This is an auto generated email, please do not reply</b>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
