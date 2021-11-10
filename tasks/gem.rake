require 'rubygems/package_task'

gemspec_file = File.expand_path('../codabel.gemspec', __dir__)
gemspec      = Kernel.eval(File.read(gemspec_file))
Gem::PackageTask.new(gemspec) do |t|
  t.name = gemspec.name
  t.version = gemspec.version
  t.package_dir = 'pkg'
  t.need_tar = false
  t.need_tar_gz = false
  t.need_tar_bz2 = false
  t.need_zip = false
  t.package_files = gemspec.files
  t.tar_command = 'tar'
  t.zip_command = 'zip'
end
