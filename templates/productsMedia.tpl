\$productCatalog = ${projectName}ProductCatalog

\$catalogVersion = catalogversion(catalog(id[default = \$productCatalog]), version[default = 'Staged'])[unique = true, default = \$productCatalog:Staged]
\$thumbnail = thumbnail(code, \$catalogVersion)
\$picture = picture(code, \$catalogVersion)

\$media = @media[translator = de.hybris.platform.impex.jalo.media.MediaDataTranslator]

\$thumbnails = thumbnails(code, \$catalogVersion)
\$detail = detail(code, \$catalogVersion)
\$normal = normal(code, \$catalogVersion)
\$others = others(code, \$catalogVersion)
\$data_sheet = data_sheet(code, \$catalogVersion)
\$medias = medias(code, \$catalogVersion)
\$galleryImages = galleryImages(qualifier, \$catalogVersion)
\$siteResource = jar:ru.masterdata.${projectName}.initialdata.setup.InitialDataSystemSetup&/${projectName}initialdata/import/sampledata/productCatalogs/\$productCatalog


INSERT_UPDATE Media; mediaFormat(qualifier); code[unique = true];realfilename; @media[translator = de.hybris.platform.impex.jalo.media.MediaDataTranslator]; mime[default = 'image/jpeg']; \$catalogVersion; folder(qualifier)
<%
x1200.each {
  println ";1200Wx1200H;${it[1]};${it[1]};\$siteResource/images/products/1200x1200/${it[1]};;; images"
}
x515.each {
  println ";515Wx515H;${it[1]};${it[1]};\$siteResource/images/products/515x515/${it[1]};;; images"
}
x300.each {
  println ";300Wx300H;${it[1]};${it[1]};\$siteResource/images/products/300x300/${it[1]};;; images"
}
x96.each {
  println ";96Wx96H;${it[1]};${it[1]};\$siteResource/images/products/96x96/${it[1]};;; images"
}
x65.each {
  println ";65Wx65H;${it[1]};${it[1]};\$siteResource/images/products/65x65/${it[1]};;; images"
}
x30.each {
  println ";30Wx30H;${it[1]};${it[1]};\$siteResource/images/products/30x30/${it[1]};;; images"
}
%>

INSERT_UPDATE MediaContainer; qualifier[unique = true]; \$medias; \$catalogVersion
<%
products.eachWithIndex { product, index ->
  println ";mc_${product[0]};${x1200[index][1]},${x515[index][1]},${x300[index][1]},${x96[index][1]},${x65[index][1]},${x30[index][1]};"
}
%>

UPDATE Product; code[unique = true]; \$picture; \$thumbnail; \$detail; \$others; \$normal; \$thumbnails; \$galleryImages; \$catalogVersion
<%
products.eachWithIndex { product, index ->
  print ";${product[0]};"
  print "${x300[index][1]};"
  print "${x96[index][1]};"
  print "${x1200[index][1]};"
  print "${x515[index][1]},${x65[index][1]},${x30[index][1]};"
  print "${x300[index][1]};"
  print "${x96[index][1]};"
  println "mc_${product};"
}
%>