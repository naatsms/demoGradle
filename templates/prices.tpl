\$productCatalog=$productCatalog

\$catalogVersion = catalogversion(catalog(id[default=\$productCatalog]),version[default='Staged'])[unique=true,default='\$productCatalog:Staged']
\$prices = Europe1prices[translator=de.hybris.platform.europe1.jalo.impex.Europe1PricesTranslator]

\$approved = approvalstatus(code)[default='approved']
\$taxGroup = Europe1PriceFactory_PTG(code)[default = jp-vat-full]

UPDATE Product;code[unique=true];\$approved;\$catalogVersion
<%
products.each {
  println ";${it}"
}
%>

INSERT_UPDATE PriceRow; productId[unique = true]; unit(code[unique = true, default = pieces]); currency(isocode)[unique = true]; price; minqtd; unitFactor; net[default=false]
<%
products.each { product ->
  def price = rnd.nextInt(priceRange) + minPrice
  currencies.each {cur,mpl ->
    println ";${product[0]};;${cur};${mpl.multiply(price)};1;1;"
  }
}
%>