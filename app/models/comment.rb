class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  
  acts_as_xlsx
  
    def self.import(file)
    spreadsheet = open_spreadsheet(file)
    spreadsheet.sheets
    # header = spreadsheet.sheet('Article').row(1)
    # (2..spreadsheet.sheet('Article').last_row).each do |i|
      # row = Hash[[header, spreadsheet.sheet('Article').row(i)].transpose]
      # article = find_by_id(row["id"]) || new
      # article.attributes = row.to_hash.slice(*row.to_hash.keys)
      # article.save!
    # end
    
    header = spreadsheet.sheet('Comments').row(1)
      (2..spreadsheet.sheet('Comments').last_row).each do |i|
        row = Hash[[header, spreadsheet.sheet('Comments').row(i)].transpose]
        comments = find_by_id(row["id"]) || new
        comments.attributes = row.to_hash.slice(*row.to_hash.keys)
        comments.save!
    end
  end
  
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, packed: nil, file_warning: :ignore)
    when ".xls" then Roo::Excel.new(file.path, packed: nil, file_warning: :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
    else raise "Unknown file type: #{file.oriinal_filename}"
    end
  end
  
end
