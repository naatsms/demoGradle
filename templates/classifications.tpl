\$productCatalog = ${projectName}ProductCatalog
\$classificationCatalog = ${projectName}ClassificationCatalog

\$catalogVersion = catalogversion(catalog(id[default = \$productCatalog]), version[default = 'Staged'])[unique = true, default = \$productCatalog:Staged]
\$classCatalogVersion = catalogversion(catalog(id[default = '\$classificationCatalog']), version[default = '1.0'])[unique = true, default = '\$classificationCatalog:1.0']
\$classSystemVersion = systemVersion(catalog(id[default = '\$classificationCatalog']), version[default = '1.0'])[unique = true]
\$class = classificationClass(ClassificationClass.code, \$classCatalogVersion)[unique = true]
\$supercategories = source(code, \$classCatalogVersion)[unique = true]
\$categories = target(code, \$catalogVersion)[unique = true]
\$attribute = classificationAttribute(code, \$classSystemVersion)[unique = true]
\$unit = unit(code, \$classSystemVersion)

# Insert Classifications
INSERT_UPDATE ClassificationClass; \$classCatalogVersion; code[unique = true]; allowedPrincipals(uid)[default = 'customergroup']
<% classAttributes.each {
println "; ; ${it.key}"
} %>

# Insert Classification Attributes
INSERT_UPDATE ClassificationAttribute; \$classSystemVersion; code[unique = true]
<%
classAttributes.each {
  it.value.each { value ->
    println "; ;${value[0]}"
  }
}
%>

# Links ClassificationClasses to Categories
INSERT_UPDATE CategoryCategoryRelation; \$categories; \$supercategories
<% classCategories.each {
println ";${it.key};${it.value}"
} %>

INSERT_UPDATE ClassAttributeAssignment; \$class; \$attribute; position; \$unit; attributeType(code[default = string]); multiValued[default = false]; range[default = false]; localized[default = false]
<%
int a = 0
classAttributes.each {
  it.value.each { value ->
    def unit = units[rnd.nextInt(units.size())]
    println ";${it.key};${value[0]};${a++};${unit[0]};${value[1]};;"
  }
}
%>
