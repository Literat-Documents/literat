class TemplateManager
  TemplateDirectory="#{Dir.home}/.literat/templates/"

  def list
	Dir.entries(TemplateDirectory)[2..-1].map do |folder|  
	  template = Template.new folder
	  template.config
	end
  end
end