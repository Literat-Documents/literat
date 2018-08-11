require 'cri'
require 'literat/project'
require 'literat/template'
require 'literat/compiler'
require 'literat/template_manager'
require 'colorize'

Literat = Cri::Command.define do
  name        'literat'
  usage       'literat [command] [options]'
  summary     'Document Generation Framework'
  description 'Literat is a Framework and Tool for generating beautiful Documents.'

  flag   :h, :help,  'show help for this command' do |value, cmd|
    puts cmd.help
    exit 0
  end

  run do |opts, args, cmd|
    puts cmd.help
    exit 0
  end
end

Literat.define_command('init') do
  name        'init'
  usage       "init [options]"
  summary     'initialize new project'

  option :t,  :template, 'Template', argument: :required
  run do |opts, args, cmd|
  	if opts[:template].nil?
    	puts cmd.help
    	exit 0
    end
    pr = Project.new
    pr.create(opts[:template])
  end
end

Literat.define_command('build') do
  name        'build'
  usage       "build [options]"
  summary     'build the project'

  run do |opts, args, cmd|
  	project = Project.new
	project.open

	compiler = Compiler.new project
	compiler.compile
  end
end

Literat.define_command('list') do
  name        'list'
  usage       "list [options]"
  summary     'list templates'

  run do |opts, args, cmd|
  	template_manager = TemplateManager.new
	template_manager.list.each do |template|
		puts 'TEMPLATES'.light_red.bold
		puts
		puts "\t#{template['name'].green}\t#{template['description']}"
		puts
		puts
	end
  end
end