class TemplateManager
  TemplateDirectory="#{Dir.home}/.literat/templates/"

  def list
	Dir.entries(TemplateDirectory)[2..-1].map do |folder|  
	  template = Template.new folder
	  template.config
	end
  end

  def check_init
  	File.directory?(TemplateDirectory)
  end

  def gem_directory
  	File.expand_path(File.dirname(File.dirname(__FILE__))+"/..")
  end

  def init_template_directory
  	FileUtils::mkdir_p TemplateDirectory
    FileUtils.copy_entry "#{self.gem_directory}/assets/templates/", TemplateDirectory
  end

  def ensure_is_initialized
  	if !self.check_init
  		self.init_template_directory
  	end
  end
end