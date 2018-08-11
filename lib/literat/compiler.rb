require 'securerandom' # random Strings for compilation folder
require 'erb' # ERB Templating engine
require 'kramdown' # Markdown Parser

class Compiler
  CompilationDirectory='/tmp/'
  CompilationDirectoryPrefix='docWriter_'

  def initialize(project)
    # TODO: ensure project exists and is a project
    @project = project
  end

  def md_to_tex(group)
    return '' if group.nil?
    Kramdown::Document.new(group).to_latex.strip
  end


  def compile
    # prepare folder for compilation
    compilation_folder = "#{CompilationDirectory}/#{CompilationDirectoryPrefix}#{SecureRandom.hex}"
    FileUtils::mkdir_p compilation_folder

    # copy files for compilation
    template = @project.template
    files = []
    files += @project.files.map { |f| {:path => @project.path, :name => f} }
    files += template.static_files.map { |f| {:path => template.path, :name => f} }

    files.each do |file|
      FileUtils.copy_entry "#{file[:path]}/#{file[:name]}", "#{compilation_folder}/#{file[:name]}"
    end

    # fill binding
    b = binding
    @project.files.select{|f| f.end_with? '.yml'}.each do |file|
      b.local_variable_set(file[0..-5].to_sym, YAML.load_file("#{compilation_folder}/#{file}"))
    end

    # compile erb
    template_files = template.template_files
    template_files.each do |file|
      output = file[0..-5]
      begin
        buffer = open("#{compilation_folder}/#{output}", 'w')
        buffer.write ERB.new(File.read("#{template.path}/#{file}")).result(b)
      rescue IOError => e
        puts "THERE WAS AN ERROR: #{e}".red
      ensure
        buffer.close unless buffer.nil?
      end
    end


    # compile tex
    Dir.chdir(compilation_folder)do
      3.times do
        system "xelatex -interaction=nonstopmode #{template_files.first[0..-5]}"
      end
    end

    template_files.first

    puts `cd #{compilation_folder} && pwd && ls -lah`

    # copy pdf to output dir
    FileUtils.copy_entry "#{compilation_folder}/#{template_files.first[0..-9]}.pdf", "#{@project.path}/document.pdf"

    # cleanup
    FileUtils.remove_dir(compilation_folder, force=true)
    
  end
end