<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
    <let name="vocabulario" value="doc('../auxiliar/vocabulario.xml')"/>
    <let name="referencias" value="doc('../auxiliar/referencias.xml')"/>
    <let name="termos" value="$vocabulario//tei:body//tei:term/concat(ancestor::tei:div/@corresp, ':', @n)"/>
    <let name="persoas" value="$referencias//tei:person/concat('#', @xml:id)"/>
    <pattern>
        <rule context="tei:term/@cRef">
            <assert test=". = $termos">El término no está declarado. Comprueba que no haya un error tipográfico o que el término esté indexado</assert>
        </rule>
        <rule context="tei:persName/@ref">
            <assert test=". = $persoas">Este agente no está declarado. Comprueba que no haya un error tipográfico o que esta persona esté indexada</assert>
        </rule>
        <rule context="tei:rs/@ref">
            <assert test=". = $termos or . = $persoas">Esta referencia no está declarada. Comprueba que no haya un error tipográfico o que la referencia esté indexada</assert>
        </rule>
        
        <!-- Regras adicionais -->
        
        <rule context="tei:origDate">
            <assert test="number(@notBefore) lt number(@notAfter)">La correlación de fechas es errónea</assert>
        </rule>
        
    </pattern>
</schema>