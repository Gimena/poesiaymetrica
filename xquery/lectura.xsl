<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <xsl:output method="xml" encoding="utf-8" indent="no" omit-xml-declaration="yes"/>
    <xsl:param name="tipos-estrofes" as="xs:string"/>
    <xsl:variable name="apos">'</xsl:variable>
    <xsl:variable name="boundary">', '</xsl:variable>
    <xsl:variable name="tipos" select="tokenize($tipos-estrofes, '\s+')" as="xs:string+"/>
    <xsl:template match="tei:TEI">
        <div class="texto">
            <xsl:apply-templates select="//tei:body"/>
        </div>
        <div class="metadata">
            <ul>
                <xsl:apply-templates select="tei:teiHeader"/>
            </ul>
            <xsl:apply-templates select="//tei:sp/tei:lg" mode="graph"/>
        </div>
    </xsl:template>
    <xsl:template match="tei:head">
        <p>
            <xsl:apply-templates select="node()"/>
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
    <xsl:template match="tei:rs">
        <xsl:choose>
            <xsl:when test="current()[matches(@ref, '^#PMC:')]">
                <a target="_blank" href="{concat('http://vocabularios.caicyt.gov.ar/pmc/index.php?tema=', replace(@ref, '^#PMC:', '' ))}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="following-sibling::node()[1][name() = ('rs', 'term')]">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:term">
        <xsl:choose>
            <xsl:when test="current()[matches(@cRef, '^#PMC:')]">
                <a target="_blank" href="{concat('http://vocabularios.caicyt.gov.ar/pmc/index.php?tema=', replace(@cRef, '^#PMC:', '' ))}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="following-sibling::node()[1][name() = ('rs', 'term')]">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:fileDesc">
        <li>Editor/a: <xsl:apply-templates select="tei:titleStmt/tei:editor"/>
        </li>
        <li>Repositorio: <xsl:apply-templates select="//tei:repository"/>
        </li>
        <li>Identificador: <xsl:apply-templates select="//tei:msIdentifier/tei:idno"/>
                (<xsl:apply-templates select="//tei:altIdentifier/tei:idno"/>)</li>
        <li>Localización manuscrito: </li>
    </xsl:template>
    <xsl:template match="tei:profileDesc">
        <li>Fecha composición: <xsl:value-of select="concat(//@notBefore, '-', //@notAfter)"/>
        </li>
    </xsl:template>
    <xsl:template match="tei:revisionDesc"/>
    <xsl:template match="tei:lg" mode="graph">
        <xsl:variable name="estrofes" select="distinct-values(tei:lg/@type)"/>
        <ul>
            <xsl:for-each select="$estrofes">
                <li>
                    <xsl:value-of select="count(index-of($tipos, current()))"/>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
</xsl:stylesheet>