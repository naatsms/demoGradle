\$productCatalog=${projectName}ProductCatalog

\$catalogVersion=catalogversion(catalog(id[default=\$productCatalog]),version[default='Staged'])[unique=true,default=\$productCatalog:Staged]
\$thumbnail=thumbnail(code, \$catalogVersion)
\$picture=picture(code, \$catalogVersion)
\$siteResource=jar:ru.masterdata.${projectName}.initialdata.setup.InitialDataSystemSetup&/${projectName}initialdata/import/sampledata/productCatalogs/\$productCatalog


INSERT_UPDATE Media;code[unique=true];realfilename;@media[translator=de.hybris.platform.impex.jalo.media.MediaDataTranslator];mime[default='image/jpeg'];\$catalogVersion
<% low_pic.each {
println ";/images/categories/${it[1]};${it[1]};\$siteResource/images/categories/${it[1]};"
} %>
<% thumbs.each {
println ";/images/categories/${it[1]};${it[1]};\$siteResource/images/categories/${it[1]};"
} %>


UPDATE Category;code[unique=true];\$picture;allowedPrincipals(uid)[default='customergroup'];\$catalogVersion
<% low_pic.each {
println ";${it[0]};/images/categories/${it[1]}"
} %>

UPDATE Category;code[unique=true];\$thumbnail;allowedPrincipals(uid)[default='customergroup'];\$catalogVersion
<% thumbs.each {
println ";${it[0]};/images/categories/${it[1]}"
} %>