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
        order by $autor
        return
            <fieldset>
                <legend
                    id="{$autor/@xml:id/string()}">{$autor/tei:persName[@type eq 'standard']/string()}</legend>
                <ul>
                    {   
                        for $cancion in $canciones
                        let $id := $cancion//tei:index/tei:term/@key
                        return
                            <li><input
                                    type="checkbox"
                                    id="{$id}"
                                    name="texto[]"
                                    value="{$id}"/><label
                                    for="{$id}">{$cancion//tei:title[1]/string()}</label></li>
                    }</ul>
            </fieldset>
    }
    <button
        class="submit"
        type="submit">Buscar</button>
</form>
