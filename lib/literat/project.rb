class Project < Hash
  ProjectFileName='.config.yml'
  ProjectPath='./'
  TemplateType='article'

  def create(type)
    if self.project_exists?
      puts "ERROR".white.on_red + "Project already exists"
      # TODO help user to fix this problem
      exit      
    else
      self[:template] = type
      self[:created] = Time.now 
      self.bootstrap_folder
      self.write_config
    end
  end

  def project_exists?
    File.exists? self.project_file
  end

  def write_config
    File.write( self.project_file, 
      YAML.dump(self)
    )
  end

  def project_file
    "#{ProjectPath}/#{ProjectFileName}"
  end

  def bootstrap_folder
    template = self.template
    self[:project_files] = template.project_files
    self[:project_files].each do |file|
      FileUtils.copy_entry "#{template.path}/#{file}", "#{ProjectPath}/#{file}"
    end
  end

  def open
    YAML.load_file(project_file).each do |k,v|
      self[k] = v 
    end
  end

  def files
    self[:project_files]
  end

  def path
    ProjectPath
  end

  def template
    Template.new(self[:template])
  end
end