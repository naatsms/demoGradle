\$productCatalog = $productCatalog

\$catalogVersion = catalogversion(catalog(id[default = \$productCatalog]), version[default = 'Staged'])[unique = true, default = \$productCatalog:Staged]

# Insert Product References
INSERT_UPDATE ProductReference; source(code, \$catalogVersion)[unique = true]; target(code, \$catalogVersion)[unique = true]; referenceType(code); active[default = true]; preselected[default = false]
<%
1.upto(relationsCount) {
  def source = products[rnd.nextInt(products.size())]
  def target = products[rnd.nextInt(products.size())]
  def type = relations[rnd.nextInt(relations.size())]
  println ";${source[0]};${target[0]};${type};true;false"
}
%>