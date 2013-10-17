<?xml version='1.0' encoding='utf-8'?>
<!-- ========================= -->
<!-- match: ddi:AuthEnty       -->
<!-- value: <fo:block>         -->
<!-- ========================= -->

<!-- functions: -->
<!-- util:trim() [local] -->

<xsl:template match="ddi:AuthEnty"
              xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
              xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <fo:block>
    
    <xsl:value-of select="util:trim(.)" />

    <!-- affiliation -->
    <xsl:if test="@affiliation">,
      <xsl:value-of select="@affiliation" />
    </xsl:if>

  </fo:block>
</xsl:template>