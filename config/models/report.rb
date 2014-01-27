# encoding: utf-8

##
# Backup Generated: report
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t report [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://meskyanichi.github.io/backup
#
Model.new(:report, 'Generate report') do

  archive :my_archive do |archive|
    # Run the `tar` command using `sudo`
    # archive.use_sudo
    archive.root '/Users/xx/Documents/Savitha/Savitha-Lab/AuctionHouse'
    archive.add 'tmp/report/report.csv'
  end

  store_with SFTP do |server|
    server.username = 'guestuser'
    server.password = 'guest2359'
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
