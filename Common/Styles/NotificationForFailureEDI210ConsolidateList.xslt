<?xml version="1.0" encoding="utf-8"?>
<!--
- Copyright (C) 2010-2016 GlobalTranz - All Rights Reserved. 
-
- Proprietary and confidential. Unauthorized copying of this file, via any
- medium is strictly prohibited without the explicit permission of GlobalTranz. 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:dt="urn:schemas-microsoft-com:datatypes"
	exclude-result-prefixes="msxsl">
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <title></title>
        <style type="text/css">
          .tableStyle
          {
          width: 100%;
          }
          body
          {
          font-size: 11.0pt;
          font-family:"Calibri","sans-serif";
          }
          .span
          {
          height: 15px;
          font-size: 11.0pt;
          padding-left: 5px;
          padding-right: 5px;
          padding-top: 2px;
          padding-bottom: 2px;
          }
        </style>
      </head>
      <body>
        <table class="tableStyle">
          <tr>
            <td>
              <table class="tableStyle">
                <tr>
                  <td>
                    EDI 210 Processing Errors:-
                  </td>
                </tr>
                <tr>
                  <td>
                    <br />
                  </td>
                </tr>
                <tr>
                  <td>
                    <table style="width:1100px" border="0" cellpadding="0" cellspacing="0">
                      <tr valign="top" align="left">
                        <td class="span">
                          <strong>PRO#</strong>
                        </td>
                        <td class="span">
                          <strong>EDI File Name</strong>
                        </td>
                        <td class="span">
                          <strong>Carrier Name</strong>
                        </td>
                        <td class="span">
                          <strong>Carrier Code</strong>
                        </td>
                        <td class="span">
                          <strong>Header Cost</strong>
                        </td>
                        <td class="span">
                          <strong>Item Total Cost</strong>
                        </td>
                        <td class="span">
                          <strong>EDI Date</strong>
                        </td>
                      </tr>
                      <xsl:for-each select="FailureEDI210Data/FailureEDI210ProcessingDetails">
                        <tr valign="top" align ="left" style="color: Red;">
                          <td class="span" style="width:110px">
                            <xsl:value-of select="ProNumber" />
                          </td>
                          <td class="span">
                            <xsl:value-of select="EDIFileName" />
                          </td>
                          <td class="span">
                            <xsl:value-of select="CarrierName" />
                          </td>
                          <td class="span" style="width:90px">
                            <xsl:value-of select="CarrierCode" />
                          </td>
                          <td class="span" align ="right" style="width:90px">
                            <xsl:value-of select='format-number(HeaderTotalCost, "$###,###0.00")' />
                          </td>
                          <td class="span" align ="right" style="width:110px">
                            <xsl:value-of select='format-number(ItemTotalCost, "$###,###0.00")' />
                          </td>
                          <td class="span" style="width:70px">
                            <xsl:call-template name="FormatDayMonYear">
                              <xsl:with-param name="DateTime" select="EDIDate"/>
                            </xsl:call-template>
                          </td>
                        </tr>
                      </xsl:for-each>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td>
                    <br />
                  </td>
                </tr>
                <tr>
                  <td>
                    <b>Note:- </b>This is an auto generated email, Please do not reply to this email.
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>
  <xsl:template name="FormatDayMonYear">
    <xsl:param name="DateTime" />
    <xsl:variable name="mo">
      <xsl:value-of select="substring($DateTime,6,2)" />
    </xsl:variable>
    <xsl:variable name="day">
      <xsl:value-of select="substring($DateTime,9,2)" />
    </xsl:variable>
    <xsl:variable name="year">
      <xsl:value-of select="substring($DateTime,1,4)" />
    </xsl:variable>
    <xsl:if test ="($mo !='')">
      <xsl:value-of select="$mo"/>
      <b>/</b>
      <xsl:value-of select="$day"/>
      <b>/</b>
      <xsl:value-of select="$year"/>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
