<?xml version='1.0' encoding='UTF-8'?>
<!-- ============================================== -->
<!-- <xsl:if> table of contents                     -->
<!-- value: <fo:page-sequence>                      -->
<!-- ============================================== -->

<!-- read: -->
<!-- $font-family, $strings, $show-overview, $show-scope-and-coverage,   -->
<!-- $show-producers-and-sponsors, $show-sampling, $show-data-collection -->
<!-- $show-data-processing-and-appraisal, $show-accessibility,           -->
<!-- $show-rights-and-disclaimer, $show-files-description,               -->
<!-- $show-variables-list, $show-variable-groups, $subset-groups         -->

<!-- functions: -->
<!-- normalize-space(), string-length(), contains(), concat() [xpath 1.0] -->

<xsl:if test="$show-toc = 'True'"
        xpath-default-namespace="http://www.icpsr.umich.edu/DDI"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <fo:page-sequence master-reference="{$page-layout}"
                    font-family="{$font-family}"
                    font-size="{$font-size}">

    <fo:flow flow-name="body">

      <!-- ====================================== -->
      <!-- TOC heading                            -->
      <!-- ====================================== -->

      <fo:block id="toc" font-size="18pt" font-weight="bold" space-before="0.5in"
                         text-align="center" space-after="0.1in">
        <xsl:value-of select="$i18n-Table_of_Contents" />
      </fo:block>


      <!-- ====================================== -->
      <!-- actual TOC lines                       -->
      <!-- ====================================== -->

      <fo:block margin-left="0.5in" margin-right="0.5in">

        <!-- Overview -->
        <xsl:if test="$show-overview = 'True'">
          <fo:block font-size="{$font-size}" text-align-last="justify">
            <fo:basic-link internal-destination="overview" text-decoration="underline" color="blue">
              <xsl:value-of select="$i18n-Overview" />
              <fo:leader leader-pattern="dots" />
              <fo:page-number-citation ref-id="overview" />
            </fo:basic-link>
          </fo:block>
        </xsl:if>

        <!-- Scope_and_Coverage -->
        <xsl:if test="$show-scope-and-coverage = 'True'">
          <fo:block font-size="{$font-size}" text-align-last="justify">
            <fo:basic-link internal-destination="scope-and-coverage" text-decoration="underline" color="blue">
              <xsl:value-of select="$i18n-Scope_and_Coverage" />
              <fo:leader leader-pattern="dots" />
              <fo:page-number-citation ref-id="scope-and-coverage" />
            </fo:basic-link>
          </fo:block>
        </xsl:if>

        <!-- Producers_and_Sponsors -->
        <xsl:if test="$show-producers-and-sponsors = 'True'">
          <fo:block font-size="{$font-size}" text-align-last="justify">
            <fo:basic-link internal-destination="producers-and-sponsors" text-decoration="underline" color="blue">
              <xsl:value-of select="$i18n-Producers_and_Sponsors" />
              <fo:leader leader-pattern="dots" />
              <fo:page-number-citation ref-id="producers-and-sponsors" />
            </fo:basic-link>
          </fo:block>
        </xsl:if>

        <!-- Sampling -->
        <xsl:if test="$show-sampling = 'True'">
          <fo:block font-size="{$font-size}" text-align-last="justify">
            <fo:basic-link internal-destination="sampling" text-decoration="underline" color="blue">
              <xsl:value-of select="$i18n-Sampling" />
              <fo:leader leader-pattern="dots" />
              <fo:page-number-citation ref-id="sampling" />
            </fo:basic-link>
          </fo:block>
        </xsl:if>

        <!-- Data_Collection -->
        <xsl:if test="$show-data-collection = 'True'">
          <fo:block font-size="{$font-size}" text-align-last="justify">
            <fo:basic-link internal-destination="data-collection" text-decoration="underline" color="blue">
              <xsl:value-of select="$i18n-Data_Collection" />
              <fo:leader leader-pattern="dots" />
              <fo:page-number-citation ref-id="data-collection" />
            </fo:basic-link>
          </fo:block>
        </xsl:if>

        <!-- Data_Processing_and_Appraisal -->
        <xsl:if test="$show-data-processing-and-appraisal = 'True'">
          <fo:block font-size="{$font-size}" text-align-last="justify">
            <fo:basic-link internal-destination="data-processing-and-appraisal" text-decoration="underline" color="blue">
              <xsl:value-of select="$i18n-Data_Processing_and_Appraisal" />
              <fo:leader leader-pattern="dots" />
              <fo:page-number-citation ref-id="data-processing-and-appraisal" />
            </fo:basic-link>
          </fo:block>
        </xsl:if>

        <!-- Accessibility -->
        <xsl:if test="$show-accessibility= 'True'">
          <fo:block font-size="{$font-size}" text-align-last="justify">
            <fo:basic-link internal-destination="accessibility" text-decoration="underline" color="blue">
              <xsl:value-of select="$i18n-Accessibility" />
              <fo:leader leader-pattern="dots" />
              <fo:page-number-citation ref-id="accessibility" />
            </fo:basic-link>
          </fo:block>
        </xsl:if>

        <!-- Rights_and_Disclaimer -->
        <xsl:if test="$show-rights-and-disclaimer = 'True'">
          <fo:block font-size="{$font-size}" text-align-last="justify">
            <fo:basic-link internal-destination="rights-and-disclaimer" text-decoration="underline" color="blue">
              <xsl:value-of select="$i18n-Rights_and_Disclaimer" />
              <fo:leader leader-pattern="dots" />
              <fo:page-number-citation ref-id="rights-and-disclaimer" />
            </fo:basic-link>
          </fo:block>
        </xsl:if>

        <!-- Files_Description, fileName -->
        <xsl:if test="$show-files-description = 'True'">
          <fo:block font-size="{$font-size}" text-align-last="justify">

            <fo:basic-link internal-destination="files-description" text-decoration="underline" color="blue">
              <xsl:value-of select="$i18n-Files_Description" />
              <fo:leader leader-pattern="dots" />
              <fo:page-number-citation ref-id="files-description" />
            </fo:basic-link>

            <xsl:for-each select="/codeBook/fileDscr">
              <fo:block margin-left="0.7in" font-size="{$font-size}" text-align-last="justify">
                <fo:basic-link internal-destination="file-{fileTxt/fileName/@ID}"
                               text-decoration="underline" color="blue">
                  <xsl:apply-templates select="fileTxt/fileName" />
                  <fo:leader leader-pattern="dots" />
                  <fo:page-number-citation ref-id="file-{fileTxt/fileName/@ID}" />
                </fo:basic-link>
              </fo:block>
            </xsl:for-each>

          </fo:block>
        </xsl:if>

        <!-- Variables_List, fileName -->
        <xsl:if test="$show-variables-list = 'True'">
          <fo:block font-size="{$font-size}" text-align-last="justify">
            <fo:basic-link internal-destination="variables-list" text-decoration="underline" color="blue">
              <xsl:value-of select="$i18n-Variables_List" />
              
              <fo:leader leader-pattern="dots"/>
              <fo:page-number-citation ref-id="variables-list" />
            </fo:basic-link>
            <xsl:for-each select="/codeBook/fileDscr">
              <fo:block margin-left="0.7in" font-size="{$font-size}" text-align-last="justify">
                <fo:basic-link internal-destination="varlist-{fileTxt/fileName/@ID}"
                               text-decoration="underline" color="blue">
                  <xsl:apply-templates select="fileTxt/fileName" />
                  <fo:leader leader-pattern="dots" />
                  <fo:page-number-citation ref-id="varlist-{fileTxt/fileName/@ID}" />
                </fo:basic-link>
              </fo:block>
            </xsl:for-each>
          </fo:block>
        </xsl:if>

        <!-- Variable_Groups -->
        <xsl:if test="$show-variable-groups = 'True'">
          <fo:block font-size="{$font-size}" text-align-last="justify">
            <fo:basic-link internal-destination="variables-groups" text-decoration="underline" color="blue">
              <xsl:value-of select="$i18n-Variables_Groups" />
              <fo:leader leader-pattern="dots" />
              <fo:page-number-citation ref-id="variables-groups" />
            </fo:basic-link>

            <xsl:for-each select="/codeBook/dataDscr/varGrp">
              <!-- Show group if its part of subset OR no subset is defined -->
              <xsl:if test="contains($subset-groups, concat(',' ,@ID, ',')) or string-length($subset-groups) = 0">
                <fo:block margin-left="0.7in" font-size="{$font-size}" text-align-last="justify">
                  <fo:basic-link internal-destination="vargrp-{@ID}" text-decoration="underline" color="blue">
                    <xsl:value-of select="normalize-space(labl)" />
                    <fo:leader leader-pattern="dots" />
                    <fo:page-number-citation ref-id="vargrp-{@ID}" />
                  </fo:basic-link>
                </fo:block>
              </xsl:if>
            </xsl:for-each>
          </fo:block>
        </xsl:if>

        <!-- Variables_Description, fileDscr/fileName -->
        <xsl:if test="$show-variables-description = 'True'">
          <fo:block font-size="{$font-size}" text-align-last="justify">

            <fo:basic-link internal-destination="variables-description" text-decoration="underline" color="blue">
              <xsl:value-of select="$i18n-Variables_Description" />
              <fo:leader leader-pattern="dots" />
              <fo:page-number-citation ref-id="variables-description" />
            </fo:basic-link>

            <xsl:for-each select="/codeBook/fileDscr">
              <fo:block margin-left="0.7in" font-size="{$font-size}" text-align-last="justify">
                <fo:basic-link internal-destination="vardesc-{fileTxt/fileName/@ID}"
                               text-decoration="underline" color="blue">
                  <xsl:apply-templates select="fileTxt/fileName" />
                  <fo:leader leader-pattern="dots" />
                  <fo:page-number-citation ref-id="vardesc-{fileTxt/fileName/@ID}" />
                </fo:basic-link>
              </fo:block>
            </xsl:for-each>

          </fo:block>
        </xsl:if>

      </fo:block>
    </fo:flow>
  </fo:page-sequence>
</xsl:if>
