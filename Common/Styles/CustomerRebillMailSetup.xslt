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
  <xsl:output method="html" indent="yes"/>

  <!--below parameter values will get from the Application-->
  <xsl:param name="customerName"/>
  <xsl:param name="userName"/>
  <xsl:param name="requoteReasons"/>
  <xsl:param name="originalItems"/>
  <xsl:param name="adjustedItems"/>
  <xsl:param name="isSubOrder"/>

  <!--below parameter values will get from the Application-->
  <xsl:variable name='sumOfTotalCost'>0</xsl:variable>
  <xsl:variable name='sumOfTotalRevenue'>0</xsl:variable>

  <xsl:template match='/'>
    <html>
      <body>
        <table border ='0' width ='100%' cellspacing='0' cellpadding='0'>
          <tr>
            <td>
              <table align = 'Left' width ='100%' border ='0' cellspacing='0' cellpadding='0'>
                <tr>
                  <td>
                    Dear  &#160;<xsl:value-of select="$customerName" />,
                  </td>
                </tr>
                <tr>
                  <td>
                    &#160;
                  </td>
                </tr>
                <!-- For Table Headers. -->
                <tr>
                  <td>
                    This email is to alert you that sales order
                    &#160;<xsl:value-of select="SalesOrderITerm/SalesOrder/BolNumber" />                   
                    <xsl:choose>
                      <xsl:when test ="string-length($requoteReasons)!=0">
                        <xsl:text>&#160;has been adjusted due to an additional charge for a&#160;</xsl:text>
                        <xsl:value-of select="$requoteReasons" />
                        <xsl:text>&#160;by the carrier.&#160;</xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>&#160;has been adjusted.&#160;</xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test="($isSubOrder = 0)">The revised total cost is $</xsl:when>
                      <xsl:otherwise>
                        <xsl:text>The additional total cost is $</xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:value-of select="SalesOrderITerm/SalesOrder/Revenue" /> .
                  </td >
                </tr>
                <tr>
                  <td>
                    &#160;
                  </td>
                </tr>
                <tr>
                  <td>
                    <b>
                      <xsl:choose>
                        <xsl:when test="($isSubOrder = 0)">
                          <xsl:text>Original Order</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:text>Already Invoiced Item Details</xsl:text>
                        </xsl:otherwise>
                      </xsl:choose>
                    </b>
                    <br></br>
                    <div>
                      <xsl:value-of select="$originalItems" />
                    </div>
                    <br></br>
                  </td>
                </tr>
                <tr>
                  <td>
                    &#160;
                  </td>
                </tr>
                <tr>
                  <tr>
                    <td>
                      &#160;
                    </td>
                  </tr>
                  <td>
                    <b>
                      <xsl:choose>
                        <xsl:when test="($isSubOrder = 0)">
                          <xsl:text>Adjusted Order</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:text>Additional Item Details</xsl:text>
                        </xsl:otherwise>
                      </xsl:choose>
                    </b>
                    <br></br>
                    <div>
                      <xsl:value-of select="$adjustedItems" />
                    </div>
                    <br></br>
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
              If you feel that this has been billed in error, please contact your sales rep immediately so that we can investigate and/or initiate the dispute process for this shipment.
              <br></br>Thank you for choosing GlobalTranz Enterprises, Inc.
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
                  <td align='Left'>
                    Regards,
                    <br></br>
                    <xsl:value-of select="$userName" />
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
