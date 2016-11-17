<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:preserve-space elements="*"/>
    <xsl:template match="tei:TEI">
        <div class="texto">
            <xsl:apply-templates select="//tei:body"/>
        </div>
        <div class="metadata">
            <ul>
                <xsl:apply-templates select="tei:teiHeader"/>
            </ul>
        </div>
    </xsl:template>
    <xsl:template match="tei:head">
        <p xml:space="preserve">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:sp">
        <xsl:apply-templates select="tei:lg"/>
    </xsl:template>
    <xsl:template match="tei:lg[@type eq 'poema']">
        <xsl:apply-templates select="tei:lg"/>
    </xsl:template>
    <xsl:template match="tei:l">
        <xsl:apply-templates/>
        <xsl:if test="following-sibling::tei:l">
            <br/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:lg">
        <p xml:space="preserve">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:rhyme">
        <span class="rima">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:rs[matches(@ref, '^#PMC:')]">
        <xsl:text> </xsl:text>
        <a target="_blank" href="{concat('http://vocabularios.caicyt.gov.ar/pmc/index.php?tema=', replace(@ref, '^#PMC:', '' ))}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    <xsl:template match="tei:term[matches(@cRef, '^#PMC:')]">
        <xsl:text> </xsl:text>
        <a target="_blank" href="{concat('http://vocabularios.caicyt.gov.ar/pmc/index.php?tema=', replace(@cRef, '^#PMC:', '' ))}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    <xsl:template match="tei:fileDesc">
        <li>Editor/a: <xsl:apply-templates select="tei:titleStmt/tei:editor"/>
        </li>
        <li>Repositorio: <xsl:apply-templates select="//tei:repository"/>
        </li>
        <li>Identificador: <xsl:apply-templates select="//tei:msIdentifier/tei:idno"/> (<xsl:apply-templates select="//tei:altIdentifier/tei:idno"/>)</li>
        <li>Localización manuscrito: </li>
    </xsl:template>
    <xsl:template match="tei:profileDesc">
        <li>Fecha composición: <xsl:value-of select="concat(//@notBefore, '-', //@notAfter)"/>
        </li>
    </xsl:template>
    <xsl:template match="tei:revisionDesc"/>
</xsl:stylesheet>