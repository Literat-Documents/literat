Gem::Specification.new do |s|
  s.name        = 'Literat'
  s.version     = '0.1.2'
  s.date        = '2018-10-03'
  s.summary     = "Document Generation Framework"
  s.description = "Literat is a Framework and Tool for generating beautiful Documents."
  s.authors     = ["NWHirschfeld (Niclas Hirschfeld)"]
  s.files       = `git ls-files`.split("\n")
  s.executables << 'literat'
  s.license     = 'GPL-3.0'
  s.add_runtime_dependency "cri"
  s.add_runtime_dependency "kramdown"
  s.add_runtime_dependency "git"
  s.add_runtime_dependency "colorize"
end

