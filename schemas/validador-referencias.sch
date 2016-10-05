<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
    <let name="vocabulario" value="doc('../auxiliar/vocabulario.xml')"/>
    <let name="termos" value="$vocabulario//tei:body//tei:term/concat(ancestor::tei:div/@corresp, ':', @n)"/>
    <pattern>
        <rule context="tei:term/@cRef">
            <assert test=". = $termos">El término no está declarado</assert>
        </rule>
    </pattern>
</schema>