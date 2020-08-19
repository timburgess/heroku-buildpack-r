#!/usr/bin/env ruby

RELATIVE_PACKAGE_RE = /install\.packages(?:\s*)\((?:\s*)[\"'](?!\/)(?!http:|https:)(?<package>.+)[\"'](?<ending>(?:.*)repos(?:\s*)=(?:\s*)NULL)/

wrapper_file = ARGV[0]
init_file = ARGV[1]
app_dir = ARGV[2]
cran_mirror = ARGV[3]

wrapper_file_content = File.read(wrapper_file)

init_lines = []
File.readlines(init_file).each do |line|
  init_lines << line.gsub(RELATIVE_PACKAGE_RE, 'install.packages("/app/\k<package>"\k<ending>').rstrip
end

init_file_content = "\n\n" + init_lines.join("\n") + "\n\n"

# insert placeholders, APP_DIR, CRAN_MIRROR and INIT_FILE_CONTENT

wrapper_file_content.gsub!(/APP_DIR/, app_dir)
wrapper_file_content.gsub!(/CRAN_MIRROR/, cran_mirror)
wrapper_file_content.gsub!(/INIT_FILE_CONTENT/, init_file_content)

File.open(wrapper_file, 'w') do |f|
	f.write(wrapper_file_content)
end

exit 0
