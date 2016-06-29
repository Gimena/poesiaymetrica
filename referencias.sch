<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
    <pattern>
        <rule context="@ref">
            <assert test=". = //tei:teiHeader//@xml:id/concat('#', .) or . = //tei:keywords/tei:term/concat('#PMC:', @n)">La referencia no está declarada</assert>
        </rule>
        <rule context="@cRef">
            <assert test=". = //tei:keywords/tei:term/concat('#PMC:', @n)">El término no está declarado</assert>
        </rule>
    </pattern>
</schema>