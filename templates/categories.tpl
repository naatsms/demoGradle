\$productCatalog=${projectName}ProductCatalog

\$catalogVersion=catalogversion(catalog(id[default=\$productCatalog]),version[default='Staged'])[unique=true,default=\$productCatalog:Staged]
\$supercategories=source(code, \$catalogVersion)[unique=true]
\$categories=target(code, \$catalogVersion)[unique=true]

INSERT_UPDATE Category;code[unique=true];allowedPrincipals(uid)[default='customergroup'];\$catalogVersion
<% lines.each {println ";${it}"} %>

INSERT_UPDATE CategoryCategoryRelation;\$categories;\$supercategories
<% relations.each {println ";${it[0]};${it[1]}"} %>