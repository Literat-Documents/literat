require 'securerandom' # random Strings for git clone folder
require 'git' # git wrapper

class TemplateManager
  TemplateDirectory="#{Dir.home}/.literat/templates/"
  TemporyDirectory='/tmp/'
  TemplateConfigFile='template.yml'

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

  def exists? name
  	File.directory?("#{TemplateDirectory}/#{name}")
  end

  def add_from_git url
    temp_folder = "literat_temp_git_#{SecureRandom.hex}"
    full_temp_folder = "#{TemporyDirectory}/#{temp_folder}"
    # git clone template
    if Git.clone(url, temp_folder, :path => TemporyDirectory).nil?
      # TODO: error
      exit
    end

    template_name = YAML.load_file("#{full_temp_folder}/#{TemplateConfigFile}")['name']

    # git check for name conflict
    if (list.map { |e| e['name'] }.include? template_name)
      # TODO: error template with this name already exists
      puts "already have that template"
    else
      # copy to template directory and rename it
      # TODO: sanitize name of new folder
      FileUtils.copy_entry full_temp_folder, "#{TemplateDirectory}/#{template_name}"
      # TODO: delete temporary Folder
    end
  end
end