\$productCatalog=${productCatalog}
\$vendor=${vendor}

\$catalogVersion=catalogversion(catalog(id[default=\$productCatalog]),version[default='Staged'])[unique=true,default=\$productCatalog:Staged]


INSERT_UPDATE Vendor;code[unique=true]
;\$vendor

INSERT_UPDATE Warehouse;code[unique=true];vendor(code)[default=$vendor];default[default='false']
<% warehouses.each {
println ";${it};"
}
%>

<% warehouses.each { warehouse ->
println "INSERT_UPDATE StockLevel;available;warehouse(code)[default=${warehouse}unique=true];inStockStatus(code);maxPreOrder;maxStockLevelHistoryCount;overSelling;preOrder;productCode[unique=true];reserved
  products.each { product ->
    println ";${rnd.nextInt(100)};${warehouse};
}
%>


INSERT_UPDATE StockLevel;available;warehouse(code)[default='Nakano',unique=true];inStockStatus(code)[default='notSpecified'];overSelling;preOrder;productCode[unique=true];reserved
