\$classificationCatalog=${projectName}classificationCatalog

\$systemVersion=systemVersion(catalog(id[default='\$classificationCatalog']),version[default='1.0'])

INSERT_UPDATE ClassificationAttributeUnit;code[unique=true];symbol;unitType;\$systemVersion[unique=true]
<%
units.each { unit ->
println ";${unit[0]};${unit[1]};${unit[2]};"
}
%>