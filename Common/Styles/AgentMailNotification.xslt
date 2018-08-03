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

  <!--<summary>
  Describe the class.
</summary>
<createDetail>
</createDetail>
<changeHistory>
  <id>US5617</id> <by>Reshma</by> <date>21-Nov-2013</date> <description>TQL - "Alert Rep Notification" Email Addition</description>\
	<id>US8632</id> <by>Antony</by> <date>15-May-2014</date> <description>Invoice Resolution - Automatic Email to agents when adjustments are made</description>
  <id>US14779</id> <by>Suman Babu</by> <date>20-Jan-2015</date> <description>Invoice Resolution - Update Alert Rep Notification template</description>
</changeHistory>-->
  <xsl:output method="html" indent="yes" />

  <!--below parameter values will get from the Application-->
  <xsl:param name="customerName" />
  <xsl:param name="userName" />
  <xsl:param name="requoteReasons" />
  <xsl:param name="originalItems" />
  <xsl:param name="adjustedItems" />
  <xsl:param name="isSubOrder" />
  <xsl:param name="isBSOrder" />
  <xsl:param name="isTQL" />
  <xsl:param name="poNumber" />

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
                  <td align='Left'>
                    <xsl:value-of select="SalesOrderITerm/SalesOrder/SalesRepName" />,
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
          <!--###START: US5617-->
          <xsl:choose>
            <xsl:when test="$isTQL = '1'">
              <tr>
                <td>
                  BOL#: <xsl:value-of select="SalesOrderITerm/SalesOrder/BolNumber" />; PRO#: <xsl:value-of select="SalesOrderITerm/SalesOrder/ProNo" />; Carrier Name: <xsl:value-of select="SalesOrderITerm/SalesOrder/CarrierName" />
                </td>
              </tr>
            </xsl:when>           
          </xsl:choose>
          <!--###END: US5617-->
          
          <tr>
            <td>
              <table align = 'Left' width ='100%' border ='0' cellspacing='0' cellpadding='0'>
                <!-- For Table Headers. -->
                <tr>
                  <td>
                    This email is to alert you that

                    <xsl:choose>
                      <xsl:when test="($isTQL = '1') and (string-length($poNumber) != 0)">
                        <xsl:text>&#160;TQL PO&#160;</xsl:text>
                        <xsl:value-of select='$poNumber' />
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>&#160;sales order&#160;</xsl:text>
                        <xsl:value-of select="SalesOrderITerm/SalesOrder/BolNumber" />
                      </xsl:otherwise>
                    </xsl:choose>

                    &#160;for
                    &#160;<xsl:value-of select="$customerName" />
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
                      <xsl:when test="($isSubOrder = 0) and ($isTQL = '0')">The revised total cost is $</xsl:when>
                      <xsl:when test="$isTQL = '0'">
                        <xsl:text>The additional total cost is $</xsl:text>
                      </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test="$isTQL ='0'">
                        <xsl:value-of select="SalesOrderITerm/SalesOrder/Cost" />
                        . The new invoice has now been adjusted to $
                      </xsl:when>
                    </xsl:choose>

                    <xsl:choose>
                      <xsl:when test="($isBSOrder = 1) and ($isTQL = '0')">
                        <xsl:value-of select="SalesOrderITerm/SalesOrder/PlcCost" />.
                      </xsl:when>
                      <xsl:when test="$isTQL = '0'">
                        <xsl:value-of select="SalesOrderITerm/SalesOrder/Revenue" />.
                      </xsl:when>
                    </xsl:choose>
                  </td>
                </tr>
								<!--### START: US8632-->
								<tr>
									<td>
										Please see attached documents if applicable.
									</td>
								</tr>
								<!--### END: US8632-->
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
					<!--### START: US8632-->
          <!--### START: US14779-->
          <tr>
            <td>
              If you find these charges to be invalid and would like to contest, please use the Dispute Board in CommandCenter.
              <br></br>
              For any specific questions or concerns regarding the charges, please email the appropriate Pod:
              <div>
              <a href="mailto:IRpod1@globaltranz.com" target="_blank">IRpod1@globaltranz.com</a> (Carrier names A-M)
             <br></br> or <br></br>
              <a href="mailto:IRpod2@globaltranz.com" target="_blank">IRpod2@globaltranz.com</a> (Carrier names N-Z).
            </div>
              For information regarding disputation of these charges, please visit
              <a href="https://www.globaltranz.com/helpdesk/agent-dispute-process" target="_blank">https://www.globaltranz.com/helpdesk/agent-dispute-process</a>
            </td>
          </tr>
					<!--### END: US14779-->
          <!--### END: US8632-->
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
                    <xsl:choose>
                      <xsl:when test="$isTQL ='0'">
                        <xsl:text>Regards,</xsl:text>
                      </xsl:when>
                    </xsl:choose>
                    <br></br>
                    <xsl:choose>
                      <xsl:when test="$isTQL = '0'">
                        <xsl:value-of select="$userName" />
                      </xsl:when>
                    </xsl:choose>
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
