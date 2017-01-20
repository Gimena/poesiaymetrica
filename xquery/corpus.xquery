xquery version "3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xhtml";
declare option output:indent "yes";
declare option output:encoding "UTF-8";
declare variable $autores := doc('/db/VTLGP/gimena/xml/auxiliar/referencias.xml')//tei:person[concat('#', @xml:id) = collection('/db/VTLGP/gimena/xml')//tei:TEI/descendant::tei:titleStmt/tei:author/@ref];
<form
    method="GET"
    action="edicion.php">
    {
        for $autor in $autores
        let $canciones := collection('/db/VTLGP/gimena/xml')//tei:TEI[descendant::tei:titleStmt/tei:author[@ref = $autor/concat('#', @xml:id)]]
        order by translate($autor/tei:persName[1], 'ÁÉÍÓÚ', 'AEIOU')
        return
            <fieldset style="margin-bottom:2%;">
                <legend
                    id="{$autor/@xml:id/string()}">{$autor/tei:persName[@type eq 'standard']/string()}</legend>
                <ul style="list-style:none;">
                    {   
                        for $cancion in $canciones
                        let $id := $cancion//tei:msItem/tei:idno
                        order by translate($cancion//tei:title[1], 'ÁÉÍÓÚ', 'AEIOU')
                        return
                            <li><input
                                    style="margin-right:1%;"
                                    type="checkbox"
                                    id="{$id}"
                                    name="texto[]"
                                    value="{$id}"/><label style="margin-left:1%;"
                                    for="{$id}">{$cancion//tei:title[1]/string()}</label></li>
                    }</ul>
            </fieldset>
    }
    <button
        class="submit"
        type="submit">Buscar</button>
</form>
