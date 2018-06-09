require 'yaml'
require 'fileutils'

module FileWorker
  extend self

  BACKUP_FILE_NAME = 'library_backup.yaml'.freeze
  
  def write_backup(raw_yaml)
    create_data_dir_if_not_exist
    File.open("data/#{BACKUP_FILE_NAME}", 'w+') do |f|
      f.write(raw_yaml)
    end
  end
  
  def read_backup
    YAML.load_file("data/#{BACKUP_FILE_NAME}")
  end

  private

  def create_data_dir_if_not_exist
    FileUtils.mkdir_p('data')
  end
end