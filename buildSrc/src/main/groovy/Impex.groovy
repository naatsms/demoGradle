import groovy.text.SimpleTemplateEngine
import org.gradle.api.DefaultTask
import org.gradle.api.tasks.TaskAction
/**
 * @author Goncharenko Mikhail, created on 29.01.2018.
 */
class Impex extends DefaultTask {
    File template
    public Map values
    File impex

    @TaskAction
    void generateImpex() {
        logger.lifecycle "generate sample data from ${template}"
        def template = new SimpleTemplateEngine().createTemplate(template)
        ant.touch(file: impex, mkdirs: true)
        impex.text = template.make(values)
    }
}