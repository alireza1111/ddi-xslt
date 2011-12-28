<xsl:stylesheet
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:g="ddi:group:3_1"
                xmlns:d="ddi:datacollection:3_1"
                xmlns:dce="ddi:dcelements:3_1"
                xmlns:c="ddi:conceptualcomponent:3_1"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:a="ddi:archive:3_1"
                xmlns:m1="ddi:physicaldataproduct/ncube/normal:3_1"
                xmlns:ddi="ddi:instance:3_1"
                xmlns:m2="ddi:physicaldataproduct/ncube/tabular:3_1"
                xmlns:o="ddi:organizations:3_1"
                xmlns:l="ddi:logicalproduct:3_1"
                xmlns:m3="ddi:physicaldataproduct/ncube/inline:3_1"
                xmlns:pd="ddi:physicaldataproduct:3_1"
                xmlns:cm="ddi:comparative:3_1"
                xmlns:s="ddi:studyunit:3_1"
                xmlns:r="ddi:reusable:3_1"
                xmlns:pi="ddi:physicalinstance:3_1"
                xmlns:ds="ddi:dataset:3_1"
                xmlns:pr="ddi:profile:3_1"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0"
                xsi:schemaLocation="ddi:instance:3_1 http://www.ddialliance.org/sites/default/files/schema/ddi3.1/instance.xsd">

    <!-- render text-elements of this language-->
    <xsl:param name="lang">da</xsl:param>
    <!-- if the requested language is not found for e.g. questionText, use fallback language-->
    <xsl:param name="fallback-lang">en</xsl:param>
    <!-- render all html-elements or just the content of body--> 
    <xsl:param name="render-as-document">true</xsl:param>
    <!-- include interactive js and jquery for navigation (external links to eXist)-->
    <xsl:param name="include-js">false</xsl:param> 
    <!-- if include-js is true this is the backend for ajax-requests -->
    <xsl:param name="exist-backend">http://bull.ssd.gu.se:8080/rest/ddi</xsl:param>
    <!-- print anchors for eg QuestionItems-->
    <xsl:param name="print-anchor">1</xsl:param>
    <!-- show the title (and subtitle) of the study-->
    <xsl:param name="show-study-title">1</xsl:param>
    <!-- show the questions as a separate flow from the variables-->
    <xsl:param name="show-questionnaires">1</xsl:param>
    <!-- show variable navigation-bar-->
    <xsl:param name="show-variable-navigration-bar">1</xsl:param>
    <!-- show study-information-->
    <xsl:param name="show-study-information">1</xsl:param>    
    <!-- path prefix to the css-files-->
    <xsl:param name="style-path">http://localhost/ddixslt/</xsl:param> 
    
    <xsl:param name="translations">i18n/messages_sv.properties.xml</xsl:param>
    <xsl:variable name="msg" select="document($translations)"/>	
    
    <xsl:output method="html" 
      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" 
      doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" 
      indent="yes"
      />
    
    <xsl:template match="/ddi:DDIInstance"> 
        <html>
            <head>
                <title>
                    <xsl:choose>
                        <xsl:when test="s:StudyUnit/r:Citation/r:Title/@xml:lang">
                            <xsl:value-of select="s:StudyUnit/r:Citation/r:Title[@xml:lang=$lang]"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="s:StudyUnit/r:Citation/r:Title"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </title>
                <xsl:choose>
                    <xsl:when test="$include-js">
                        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
                        <script type="text/javascript" src="js/config.js"></script>
                        <script type="text/javascript" src="js/exist-requests.js"></script>
                        <xsl:choose>
                            <xsl:when test="$show-variable-navigration-bar">
                                <script type="text/javascript" src="js/varaible-navaigation-bar.js"></script>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:when>
                </xsl:choose>
                
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
                <link type="text/css" rel="stylesheet" media="all" href="http://localhost/ddixslt/ddi.css"></link>
            </head>
            <body>
                <div id="study">
                    <xsl:if test="$show-study-title = 1">
                        <h1>
                            <xsl:choose>
                                <xsl:when test="s:StudyUnit/r:Citation/r:Title/@xml:lang">
                                    <xsl:value-of select="s:StudyUnit/r:Citation/r:Title[@xml:lang=$lang]"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="s:StudyUnit/r:Citation/r:Title"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </h1>
                        <p>
                                <strong>
                                <xsl:value-of select="s:StudyUnit/r:Citation/r:AlternateTitle[@xml:lang=$lang]"/>
                                </strong>
                        </p>
                    </xsl:if>

                    <xsl:if test="$show-study-information = 1">
                                <p class="refNr">
                                    Ref. nr: <strong><xsl:value-of select="s:StudyUnit/@id"/></strong>
                                </p>
                                <h3><xsl:value-of select="$msg/*/entry[@key='Abstract']"/></h3>
                                <xsl:choose>
                                    <xsl:when test="s:StudyUnit/s:Abstract/@xml:lang">
                                        <xsl:value-of select="s:StudyUnit/s:Abstract[@xml:lang=$lang]"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="s:StudyUnit/s:Abstract"/>
                                    </xsl:otherwise>
                                </xsl:choose>

                                <xsl:apply-templates select="s:StudyUnit/r:Citation"/>

                                <xsl:apply-templates select="s:StudyUnit/r:Coverage"/>

                                <xsl:apply-templates select="s:StudyUnit/c:ConceptualComponent/c:UniverseScheme"/>

                                <xsl:apply-templates select="s:StudyUnit/r:SeriesStatement"/>                           
                    </xsl:if>

                    <xsl:apply-templates select="s:StudyUnit/d:DataCollection"/>
                    <xsl:apply-templates select="s:StudyUnit/l:LogicalProduct"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="s:Coverage">
        <h3><xsl:value-of select="$msg/*/entry[@key='Time_Periods']"/></h3>
        <xsl:for-each select="r:TemporalCoverage">
            <p>
                <xsl:value-of select="r:ReferenceDate/r:StartDate"/> - <xsl:value-of select="r:ReferenceDate/r:EndDate"/>
            </p>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="c:UniverseScheme">
        <h3><xsl:value-of select="$msg/*/entry[@key='Universe']"/></h3>
        <xsl:for-each select="c:Universe">
            <p>
                <xsl:value-of select="c:HumanReadable[@xml:lang=$lang]"/>
            </p>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="l:LogicalProduct">
        <div class="variableSchemes">
             <xsl:apply-templates select="l:DataRelationship/l:LogicalRecord/l:VariablesInRecord/l:VariableSchemeReference"/>
        </div>
    </xsl:template>

    <xsl:template match="a:Archive">
        <div class="archive">

        </div>
    </xsl:template>

    <xsl:template match="d:DataCollection">  
        <div class="dataCollection">
            <xsl:if test="r:OtherMaterial">
                <h3><xsl:value-of select="$msg/*/entry[@key='Other_resources']"/></h3>
                <ul class="otherMaterial">
                    <xsl:apply-templates select="r:OtherMaterial"/>
                </ul>
            </xsl:if>
            <div class="questionSchemes">
                <xsl:apply-templates select="d:QuestionScheme"/>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="r:Citation">
        <xsl:if test="count(r:Creator) > 0">
	        <h3><xsl:value-of select="$msg/*/entry[@key='Primary_Investigators']"/></h3>
	        <ul class="creator">
	            <xsl:for-each select="r:Creator[@xml:lang=$lang]">
	                <li>
	                    <xsl:value-of select="."/>, <em>
	                        <xsl:value-of select="@affiliation"/>
	                    </em>
	                </li>
	            </xsl:for-each>
	        </ul>
        </xsl:if>
        <xsl:if test="count(r:Publisher[@xml:lang=$lang]) > 0">
	        <h3><xsl:value-of select="$msg/*/entry[@key='Publishers']"/></h3>
	        <ul class="publisher">
	            <xsl:for-each select="r:Publisher[@xml:lang=$lang]">
	                <li>
	                    <xsl:value-of select="."/>
	                </li>
	            </xsl:for-each>
	        </ul>
        </xsl:if>
    </xsl:template>

    <xsl:template match="r:SeriesStatement">
        <h3><xsl:value-of select="$msg/*/entry[@key='Series']"/></h3>
        <p>
        	<strong><xsl:value-of select="$msg/*/entry[@key='Name']"/>: </strong>
        	<xsl:value-of select="r:SeriesName[@xml:lang=$lang]"/>
        </p>
        <p>
        	<xsl:value-of select="r:SeriesDescription[@xml:lang=$lang]"/>
        </p>
    </xsl:template>

    <xsl:template match="d:QuestionScheme">
        <div>
            <xsl:attribute name="class">questionScheme</xsl:attribute>
            <xsl:attribute name="id">questionScheme-id-<xsl:value-of select="@id"/>
            </xsl:attribute>
            <a>
                <xsl:attribute name="name">questionScheme-<xsl:value-of select="@id"/>
                </xsl:attribute>
            </a>
            <xsl:if test="d:QuestionSchemeName">
	            <h3 class="questionSchemeName">               
		            <xsl:choose>
		                <xsl:when test="d:QuestionSchemeName[@xml:lang=$lang]">
		                    <xsl:value-of select="d:QuestionSchemeName[@xml:lang=$lang]"/>
		                </xsl:when>
		                <xsl:otherwise>
		                    <em>
		                        <xsl:value-of select="d:QuestionSchemeName[@xml:lang=$fallback-lang]"/>
		                    </em>
		                </xsl:otherwise>
		            </xsl:choose>               
	            </h3>
            </xsl:if>
            <xsl:if test="count(./*[name(.) ='d:QuestionItem' or name(.) ='d:MultipleQuestionItem']) > 0">
            <ul class="questions">
                <xsl:for-each select="./*[name(.) ='d:QuestionItem' or name(.) ='d:MultipleQuestionItem']">
                    <xsl:apply-templates select="."/>
                </xsl:for-each>
            </ul>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template match="r:OtherMaterial">
        <li>
            <!-- used for setting class for icon for the filetype-->
            <xsl:attribute name="class">
                <xsl:value-of select="substring-after(r:MIMEType,'/')"/>
            </xsl:attribute>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="r:ExternalURLReference"/>
                </xsl:attribute>
                <xsl:value-of select="r:Citation/r:Title[@xml:lang=$lang]"/>
            </a>
        </li>
    </xsl:template>

    <xsl:template match="d:QuestionItem">
        <li>
            <!-- use optional external question-id as id to the li-element -->
            <xsl:attribute name="class">question-<xsl:value-of select="r:UserID[@type='question_id']"/>
            </xsl:attribute>
            <xsl:if test="$print-anchor">
            <a>
                <xsl:attribute name="name">question-<xsl:value-of select="r:UserID[@type='question_id']"/>
                </xsl:attribute>
            </a>
           </xsl:if>
            <strong class="questionName">
                <xsl:value-of select="d:QuestionItemName[@xml:lang=$lang]"/>
            </strong>
            <xsl:choose>
                <xsl:when test="d:QuestionText[@xml:lang=$lang]/d:LiteralText/d:Text">
                    <xsl:value-of select="d:QuestionText[@xml:lang=$lang]/d:LiteralText/d:Text"/>
                </xsl:when>
                <xsl:otherwise>
                    <em>
                        <xsl:value-of select="d:QuestionText[@xml:lang=$fallback-lang]/d:LiteralText/d:Text"/>
                    </em>
                </xsl:otherwise>
            </xsl:choose>

            <xsl:apply-templates select="d:CodeDomain" />
            <xsl:apply-templates select="d:NumericDomain" />

            <!-- generate variable-links-->
            
            
            <xsl:variable name="qiID" select="@id" />
            <xsl:if test="count(//l:Variable[l:QuestionReference/r:ID = $qiID]) > 0">
            <ul class="variables">
                <li>
                    <strong class="variableName"><xsl:value-of select="//l:Variable[l:QuestionReference/r:ID = $qiID]/l:VariableName"/></strong>
                    <a>
                       <xsl:attribute name="href">#<xsl:value-of select="//l:Variable[l:QuestionReference/r:ID = $qiID]/@id"/></xsl:attribute>
                       <xsl:value-of select="//l:Variable[l:QuestionReference/r:ID = $qiID]/r:Label"/>
                    </a>
                </li>
            </ul>
            </xsl:if>
        </li>
    </xsl:template>

    <xsl:template match="d:CodeDomain">
        <ul>
            <li class="codeDomain">
                <xsl:apply-templates select="r:CodeSchemeReference" />
            </li>
        </ul>
    </xsl:template>

    <xsl:template match="d:NumericDomain">
        <ul><li class="numeric"><xsl:value-of select="@type" /></li></ul>
    </xsl:template>

    <xsl:template match="l:CodeScheme">
        <xsl:if test="count(l:Code) > 0">
        <table class="codeScheme">
            <tbody>
                <xsl:apply-templates select="l:Code" />
            </tbody>
        </table>
        </xsl:if>
    </xsl:template>

    <xsl:template match="l:VariableScheme">
        <div class="variableScheme">
            <ul class="variables">
            <xsl:apply-templates select="l:Variable" />
            </ul>
        </div>
    </xsl:template>

    <xsl:template match="l:Code">
        <tr>
            <td><xsl:value-of select="l:Value" /></td>
            <xsl:apply-templates select ="l:CategoryReference" />
        </tr>
    </xsl:template>

    <xsl:template match="l:Category">
       <xsl:choose>
           <xsl:when test="@missing">
               <td><em><xsl:value-of select="r:Label" /></em></td>
           </xsl:when>
           <xsl:otherwise>
               <td><xsl:value-of select="r:Label" /></td>
           </xsl:otherwise>
       </xsl:choose>
    </xsl:template>

    <xsl:template match="d:MultipleQuestionItem">
        <li>
            <!-- use optional external question-id as id to the li-element -->
            <xsl:attribute name="class">question-<xsl:value-of select="r:UserID[@type='question_id']"/></xsl:attribute>
            <strong class="questionName">
                <xsl:value-of select="d:MultipleQuestionItemName[@xml:lang=$lang]"/>
            </strong>
            <xsl:choose>
                <xsl:when test="d:QuestionText[@xml:lang=$lang]/d:LiteralText/d:Text">
                    <xsl:value-of select="d:QuestionText[@xml:lang=$lang]/d:LiteralText/d:Text"/>
                </xsl:when>
                <xsl:otherwise>
                    <em>
                        <xsl:value-of select="d:QuestionText[@xml:lang=$fallback-lang]/d:LiteralText/d:Text"/>
                    </em>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="count(d:SubQuestions) > 0">
            <ul class="questions">
                <xsl:apply-templates select="d:SubQuestions" />
            </ul>
            </xsl:if>
        </li>
    </xsl:template>

    <xsl:template match="d:SubQuestions">
        <xsl:if test="count(child::*) > 0">
            <xsl:for-each select="child::*">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <xsl:template match="l:Variable">
          <li class="variable">
              <a>
                <xsl:attribute name="name">varaible-<xsl:value-of select="@id"/>
                </xsl:attribute>
              </a>              
              <a><xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute></a>
              <strong class="variableName"><xsl:value-of select="l:VariableName"/></strong><xsl:value-of select="r:Label"/>

              <xsl:apply-templates select="l:Representation/l:CodeRepresentation" />
              <xsl:apply-templates select="l:Representation/l:NumericRepresentation" />
              <xsl:apply-templates select="l:Representation/l:TextRepresentation" />
          </li>
    </xsl:template>

    <xsl:template match="l:CodeRepresentation">
        <ul>
            <li class="codeDomain">
                <xsl:apply-templates select="r:CodeSchemeReference" />
            </li>
        </ul>
    </xsl:template>

    <xsl:template match="l:TextRepresentation">
        <ul>
            <li class="textRepresentation">
                Text (max length: <xsl:value-of select="@maxLength" />)
            </li>
        </ul>
    </xsl:template>

    <!-- Resolve references -->
    <xsl:template match="l:NumericRepresentation">
        <ul><li class="numeric"><xsl:value-of select="@type" /> (<xsl:value-of select="@decimalPositions" /> <xsl:value-of select="$msg/*/entry[@key='Decimals']"/>)</li></ul>

    </xsl:template>

    <xsl:template match="l:VariableSchemeReference">
        <xsl:variable name="vsID" select="r:ID" />
        <xsl:apply-templates select="//l:VariableScheme[@id = $vsID]" />
    </xsl:template>

    <xsl:template match="r:CodeSchemeReference">
        <xsl:variable name="csID" select="r:ID" />
        <xsl:apply-templates select="//l:CodeScheme[@id = $csID]" />
    </xsl:template>

    <xsl:template match="l:CategoryReference">
        <xsl:variable name="csID" select="r:ID" />
        <xsl:apply-templates select="//l:Category[@id = $csID]" />
    </xsl:template>
</xsl:stylesheet>