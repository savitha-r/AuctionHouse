##
# Backup Generated: my_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t my_backup [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://meskyanichi.github.io/backup
#
Model.new(:report, 'Generate Report') do
  ##
  # Archive [Archive]
  #
  # Adding a file or directory (including sub-directories):
  #   archive.add "/path/to/a/file.rb"
  #   archive.add "/path/to/a/directory/"
  #
  # Excluding a file or directory (including sub-directories):
  #   archive.exclude "/path/to/an/excluded_file.rb"
  #   archive.exclude "/path/to/an/excluded_directory
  #
  # By default, relative paths will be relative to the directory
  # where `backup perform` is executed, and they will be expanded
  # to the root of the filesystem when added to the archive.
  #
  # If a `root` path is set, relative paths will be relative to the
  # given `root` path and will not be expanded when added to the archive.
  #
  #   archive.root '/path/to/archive/root'
  #
  @items = Item.order(:name)
  File.open(Rails.root.to_s + '/tmp/report.csv', 'w') {|f| f.write(Item.to_csv(@items)) }
  archive :my_archive do |archive|
    # Run the `tar` command using `sudo`
    # archive.use_sudo
    archive.add Rails.root.to_s + '/tmp/report.csv'
  end

  store_with SFTP do |server|
    server.username = 'guest2359'
    server.password = 'guestuser'
    server.ip       = 'sftp.2359media.net'
    server.port     = 22
    server.path     = '~/backups/'
    server.keep     = 5

  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

end 
