xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
(:declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xhtml";
declare option output:indent "yes";
declare option output:encoding "UTF-8";:)
declare variable $textos := collection('/db/VTLGP/gimena/xml')//tei:TEI;
declare variable $autores := doc('/db/VTLGP/gimena/xml/auxiliar/referencias.xml')//tei:person[concat('#', @xml:id) = $textos/descendant::tei:titleStmt/tei:author/@ref];
declare variable $query := request:get-parameter("texto", ());
let $seleccion := tokenize($query, ',+')
let $ediciones := $textos[descendant::tei:msItem//tei:term/@key = $seleccion]
for $edicion in $ediciones
return
    (<div
        class="header">
        <h2>{$edicion//tei:title[1]/string()}</h2>
        <h3>{$edicion//tei:author/string()}</h3></div>,
    <div
        class="body">
        {transform:transform($edicion, 'xmldb:exist:///db/VTLGP/gimena/lectura.xsl',())}
    </div>)
