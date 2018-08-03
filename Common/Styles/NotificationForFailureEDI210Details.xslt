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
  <xsl:param name="LineItemTotal"/>

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
                    <h4>
                      EDI 210 Processing Errors:-
                    </h4>
                  </td>
                </tr>
                <tr>
                  <td>
                    <strong>
                      <i>EDI 210 Details:</i>
                    </strong>
                  </td>
                </tr>
                <tr>
                  <td>
                    <table border="1" cellpadding="1" cellspacing="1">
                      <tr valign="top" align="center">
                        <td class="span">
                          <strong>Id</strong>
                        </td>
                        <td class="span">
                          <strong>Shipment ID</strong>
                        </td>
                        <td class="span">
                          <strong>Pro Number</strong>
                        </td>
                        <td class="span">
                          <strong>EDI Date</strong>
                        </td>
                        <td class="span">
                          <strong>NetAmountDue</strong>
                        </td>
                        <td class="span">
                          <strong>Delivery Date</strong>
                        </td>
                        <td class="span">
                          <strong>Carrier Code</strong>
                        </td>
                        <td class="span">
                          <strong>Carrier Name</strong>
                        </td>
                        <td class="span">
                          <strong>Carrier ID</strong>
                        </td>
                        <td class="span">
                          <strong>PickUp Date</strong>
                        </td>
                        <td class="span">
                          <strong>PurchaseOrder Number</strong>
                        </td>
                        <td class="span">
                          <strong>TermsNet DueDate</strong>
                        </td>
                        <td class="span">
                          <strong>Billing Code</strong>
                        </td>
                        <td class="span">
                          <strong>EDI File Name</strong>
                        </td>
                      </tr>
                      <xsl:for-each select="EDI210Details/EDI210DetailsData">
                        <tr valign="top" align ="center">
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(ID)!=0">
                                <xsl:value-of select ="ID"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(ShipmentIdentificationNumber)!=0">
                                <xsl:value-of select ="ShipmentIdentificationNumber"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(ProNumber)!=0">
                                <xsl:value-of select ="ProNumber"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(EDIDate)!=0">
                                <xsl:value-of select ="EDIDate"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span" style="background-color: Yellow">
                            <strong>
                              <xsl:choose>
                                <xsl:when test ="string-length(NetAmountDue)!=0">
                                  <xsl:value-of select='format-number(NetAmountDue, "$###,###0.00")' />
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:text>&#160;</xsl:text>
                                </xsl:otherwise>
                              </xsl:choose>
                            </strong>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(DeliveryDate)!=0">
                                <xsl:value-of select ="DeliveryDate"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(CarrierCode)!=0">
                                <xsl:value-of select ="CarrierCode"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span" align="right">
                            <xsl:choose>
                              <xsl:when test ="string-length(CarrierName)!=0">
                                <xsl:value-of select ="CarrierName"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(CarrierID)!=0">
                                <xsl:value-of select ="CarrierID"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(PickUpDate)!=0">
                                <xsl:value-of select ="PickUpDate"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(PurchaseOrderNumber)!=0">
                                <xsl:value-of select ="PurchaseOrderNumber"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(TermsNetDueDate)!=0">
                                <xsl:value-of select ="TermsNetDueDate"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(BillingCode)!=0">
                                <xsl:value-of select ="BillingCode"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(EDIFileName)!=0">
                                <xsl:value-of select ="EDIFileName"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
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
                    <strong>
                      <i>EDI 210 Lading Info Details:</i>
                    </strong>
                  </td>
                </tr>
                <tr>
                  <td>
                    <table border="1" cellpadding="1" cellspacing="1">
                      <tr valign="top" align="center">
                        <td class="span">
                          <strong>EDIFileId</strong>
                        </td>
                        <td class="span">
                          <strong>LadingLineItemNumber</strong>
                        </td>
                        <td class="span">
                          <strong>LadingDescription</strong>
                        </td>
                        <td class="span">
                          <strong>Weight</strong>
                        </td>
                        <td class="span">
                          <strong>LadingQuantity</strong>
                        </td>
                        <td class="span">
                          <strong>PackagingFromCode</strong>
                        </td>
                        <td class="span">
                          <strong>PackageDefinition</strong>
                        </td>
                        <td class="span">
                          <strong>FreightRate</strong>
                        </td>
                        <td class="span">
                          <strong>Charge</strong>
                        </td>
                        <td class="span">
                          <strong>SpecialChargeDescription</strong>
                        </td>
                        <td class="span">
                          <strong>Height</strong>
                        </td>
                        <td class="span">
                          <strong>Width</strong>
                        </td>
                        <td class="span">
                          <strong>Length</strong>
                        </td>
                        <td class="span">
                          <strong>TransactionSetNumber</strong>
                        </td>
                        <td class="span">
                          <strong>NMFCNo</strong>
                        </td>
                        <td class="span">
                          <strong>CommodityCode</strong>
                        </td>
                        <td class="span">
                          <strong>FreightClassCode</strong>
                        </td>
                        <td class="span">
                          <strong>SpecialChargeorAllowanceCode</strong>
                        </td>
                      </tr>
                      <xsl:for-each select="EDI210Details/EDI210LadingInfo">
                        <tr valign="top" align ="center">
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(EDIFileId)!=0">
                                <xsl:value-of select ="EDIFileId"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(LadingLineItemNumber)!=0">
                                <xsl:value-of select ="LadingLineItemNumber"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span" align="left">
                            <xsl:choose>
                              <xsl:when test ="string-length(LadingDescription)!=0">
                                <xsl:value-of select ="LadingDescription"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(Weight)!=0">
                                <xsl:value-of select ="Weight"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(LadingQuantity)!=0">
                                <xsl:value-of select ="LadingQuantity"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(PackagingFromCode)!=0">
                                <xsl:value-of select ="PackagingFromCode"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(PackageDefinition)!=0">
                                <xsl:value-of select ="PackageDefinition"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(FreightRate)!=0">
                                <xsl:value-of select ="FreightRate"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span" align ="right">
                            <xsl:choose>
                              <xsl:when test ="string-length(Charge)!=0">
                                <xsl:value-of select='format-number(Charge, "$###,###0.00")' />
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(SpecialChargeDescription)!=0">
                                <xsl:value-of select ="SpecialChargeDescription"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(Height)!=0">
                                <xsl:value-of select ="Height"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(Width)!=0">
                                <xsl:value-of select ="Width"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(Length)!=0">
                                <xsl:value-of select ="Length"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(TransactionSetNumber)!=0">
                                <xsl:value-of select ="TransactionSetNumber"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(NMFCNo)!=0">
                                <xsl:value-of select ="NMFCNo"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(CommodityCode)!=0">
                                <xsl:value-of select ="CommodityCode"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(FreightClassCode)!=0">
                                <xsl:value-of select ="FreightClassCode"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="span">
                            <xsl:choose>
                              <xsl:when test ="string-length(SpecialChargeorAllowanceCode)!=0">
                                <xsl:value-of select ="SpecialChargeorAllowanceCode"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>&#160;</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                        </tr>
                      </xsl:for-each>
                      <tfoot>
                        <tr valign="top" align="left">
                          <td colspan="7" class="span">
                            <xsl:text>&#160;</xsl:text>
                          </td>
                          <td class="span">
                            <strong>Total</strong>
                          </td>
                          <td class="span" align="right" style="background-color: Yellow">
                            <strong>
                              <xsl:choose>
                                <xsl:when test ="string-length($LineItemTotal)!=0">
                                  <xsl:value-of select='format-number($LineItemTotal, "$###,###0.00")' />
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:text>&#160;</xsl:text>
                                </xsl:otherwise>
                              </xsl:choose>
                            </strong>
                          </td>
                          <td colspan="9" class="span">
                            <xsl:text>&#160;</xsl:text>
                          </td>
                        </tr>
                      </tfoot>
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
