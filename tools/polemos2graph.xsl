<?xml version="1.0" encoding="UTF-8"?>
<!--

LGPL  http://www.gnu.org/licenses/lgpl.html
© 2013 Frederic.Glorieux@fictif.org et LABEX OBVIL

Extraction du texte d'un corpus TEI pour recherche plein texte ou traitements linguistiques
(ex : suppressions des notes, résolution de l'apparat)
Doit pouvoir fonctionner en import.


-->
<xsl:transform version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="tei"
  >
  <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="text" indent="yes"/>
  <xsl:param name="file" select="/*/@xml:id"/>
  <xsl:variable name="apos">'</xsl:variable>
  <xsl:variable name="quot">"</xsl:variable>
  <xsl:variable name="poetica" select="document('../gongora_obra-poetica.xml')"/>
  <xsl:variable name="lf">
    <xsl:text>&#10;</xsl:text>
  </xsl:variable>
  <xsl:variable name="tab">
    <xsl:text>&#9;</xsl:text>
  </xsl:variable>
  <!-- Racine du document, donner la main au mode graph -->
  <xsl:template match="/">
    <xsl:apply-templates mode="graph"/>
  </xsl:template>
  <!-- Par défaut, traverser tous les éléments en transmettant ce qu'on récupére au passage -->
  <xsl:template match="*" mode="graph">
    <xsl:param name="date"/>
    <xsl:param name="id"/>
    <xsl:param name="Source"/>
    <xsl:variable name="date2">
      <xsl:choose>
        <xsl:when test="tei:index[@indexName='date']">
          <xsl:value-of select="tei:index[@indexName='date']/@n"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$date"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="id2">
      <xsl:choose>
        <xsl:when test="@xml:id">
          <xsl:value-of select="@xml:id"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$id"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="Source2">
      <xsl:choose>
        <xsl:when test="tei:index[@indexName='resp']">
          <xsl:value-of select="tei:index[@indexName='resp']/@n"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$Source"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:apply-templates mode="graph" select="*">
      <xsl:with-param name="date" select="$date2"/>
      <xsl:with-param name="id" select="$id2"/>
      <xsl:with-param name="Source" select="$Source2"/>
    </xsl:apply-templates> 
  </xsl:template>
  <!-- Par défaut, ne pas sortir de texte -->
  <xsl:template match="text()" mode="graph"/>
  <!-- /TEI 
  Les colonnes
  file,section,date,Source,Target,type
  -->
  <xsl:template match="/*" mode="graph">
    <table>
      <xsl:text>file</xsl:text>
      <xsl:value-of select="$tab"/>
      <xsl:text>section</xsl:text>
      <xsl:value-of select="$tab"/>
      <xsl:text>date</xsl:text>
      <xsl:value-of select="$tab"/>
      <xsl:text>Source</xsl:text>
      <xsl:value-of select="$tab"/>
      <xsl:text>Target</xsl:text>
      <xsl:value-of select="$tab"/>
      <xsl:text>type</xsl:text>
      <xsl:value-of select="$tab"/>
      <xsl:text>misc1</xsl:text>
      <xsl:value-of select="$tab"/>
      <xsl:text>misc2</xsl:text>
      <xsl:value-of select="$tab"/>
      <xsl:text>misc3</xsl:text>
      <xsl:value-of select="$lf"/>
      <xsl:apply-templates mode="graph" select="*"/>
      <xsl:value-of select="$lf"/>
    </table>
  </xsl:template>

  <xsl:template match="tei:name[@type='polemista'] | tei:persName " mode="graph">
    <!-- Récupérer ce qui vient de plus haut -->
    <xsl:param name="date"/>
    <xsl:param name="id"/>
    <xsl:param name="Source"/>
    <!-- file,section,date,Source,Target,type -->
    <xsl:if test="$Source != ''">
      <xsl:value-of select="$file"/>
      <xsl:value-of select="$tab"/>
      <xsl:value-of select="$id"/>
      <xsl:value-of select="$tab"/>
      <xsl:value-of select="$date"/>
      <xsl:value-of select="$tab"/>
      <xsl:value-of select="$Source"/>
      <xsl:value-of select="$tab"/>
      <xsl:choose>
        <xsl:when test="@key">
          <xsl:value-of select="@key"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="normalize-space(.)"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="$tab"/>
      <xsl:choose>
        <xsl:when test="@type">
          <xsl:value-of select="@type"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="local-name()"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="$lf"/>
    </xsl:if>
  </xsl:template>
  <!-- Lien à un poème -->
  <xsl:template match="tei:ref[contains( @target, 'obra-poetica')]" mode="graph">
    <!-- Récupérer ce qui vient de plus haut -->
    <xsl:param name="date"/>
    <xsl:param name="id"/>
    <xsl:param name="Source"/>
    <!-- file,section,date,Source,Target,type -->
    <xsl:variable name="poem" select="
      substring-before(
        concat(
          substring-after(@target, 'gongora_obra-poetica/'),
          '#'
        ),
        '#'
      )"/>
    <xsl:if test="$Source != ''">
      <xsl:value-of select="$file"/>
      <xsl:value-of select="$tab"/>
      <xsl:value-of select="$id"/>
      <xsl:value-of select="$tab"/>
      <xsl:value-of select="$date"/>
      <xsl:value-of select="$tab"/>
      <xsl:value-of select="$Source"/>
      <xsl:value-of select="$tab"/>
      <xsl:choose>
        <xsl:when test="contains(., '.')">
          <xsl:value-of select="normalize-space(substring-before(., '.'))"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="normalize-space(.)"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="$tab"/>
      <xsl:value-of select="local-name()"/>
      <xsl:value-of select="$tab"/>
      <xsl:value-of select="$poem"/>
      <xsl:value-of select="$tab"/>
      <xsl:variable name="ref" select="$poetica//tei:ref[@target=concat('#', $poem)]"/>
      <xsl:value-of select="$ref"/>
      <xsl:value-of select="$tab"/>
      <xsl:value-of select="$ref/../../tei:cell[2]"/>
      <xsl:value-of select="$lf"/>
    </xsl:if>
  </xsl:template>
  
</xsl:transform>