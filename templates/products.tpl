\$productCatalog = ${projectName}ProductCatalog

\$catalogVersion = catalogversion(catalog(id[default = \$productCatalog]), version[default = 'Staged'])[unique = true, default = \$productCatalog:Staged]
\$supercategories = supercategories(code, \$catalogVersion)
\$approved = approvalstatus(code)[default = 'check']

# Insert Products
INSERT_UPDATE Product; code[unique = true]; \$supercategories; manufacturerName; manufacturerAID; unit(code); \$catalogVersion; \$approved
<%
products.each { product ->
  def category = cat[rnd.nextInt(cat.size())]
  def manufacturer = man[rnd.nextInt(man.size())]
  def unit = units[rnd.nextInt(units.size())]
  println ";${product};${category};${manufacturer[0]};${manufacturer[1]};${unit[0]};"
}
%>