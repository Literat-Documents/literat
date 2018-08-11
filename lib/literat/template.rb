require 'yaml'
require 'fileutils'

class Template
  TemplateDirectory="#{Dir.home}/.literat/templates/"
  TemplateConfigFile='template.yml'

  def initialize(type)
    # TODO: ensure type exists
    @type = type
  end

  def config
    YAML.load_file("#{self.path}/#{TemplateConfigFile}")
  end

  def project_files
    # TODO: ensure files exists
    self.config['project_files']
  end

  def static_files
    # TODO: ensure files exists
    Array(self.config['compilation']['static_files'])
  end

  def template_files
    # TODO: ensure files exists
    Array(self.config['compilation']['template_files'])
  end

  def path
    "#{TemplateDirectory}/#{self.type}"
  end

  def type
    if @type.nil?
      # TODO: better error handling
      puts "type not set"
      exit   
    else
      @type
    end
  end
end