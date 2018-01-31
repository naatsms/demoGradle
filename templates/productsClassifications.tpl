#% impex.setLocale(Locale.ENGLISH);

\$productCatalog=${projectName}ProductCatalog
\$classificationCatalog=${projectName}ClassificationCatalog

\$catalogVersion=catalogversion(catalog(id[default=\$productCatalog]),version[default='Staged'])[unique=true,default=\$productCatalog:Staged]
\$clAttrModifiers=system='\$classificationCatalog',version='1.0',translator=de.hybris.platform.catalog.jalo.classification.impex.ClassificationAttributeTranslator

# Insert Product Classifications
<%
features.each {
  println "\$${it[0]}=@${it[0]}[\$clAttrModifiers];"
}
%>
INSERT_UPDATE Product;code[unique=true];<% features.each {print "\$${it[0]};"}%>\$catalogVersion;
<%
products.each { product ->
  print ";${product};"
  features.each { ft ->
    def range = samples[ft[1]]
    def pos = rnd.nextInt(range.size())
    print "${range[pos]};"
  }
  println ''
}
%>