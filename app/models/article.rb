class Article < ActiveRecord::Base
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  acts_as_xlsx
  
  has_attached_file :photo, :styles => { :thumb => "100x300", :original => "600x300"},
  :url => "/upload_images/:id/:style/:basename.:extension",
  :path => ":rails_root/public/upload_images/:id/:style/:basename.:extension"
  
  validates :title, presence: true, length: {minimum: 5}
  validates :content, presence: true, length: {minimum: 10}
  validates :status, presence: true
  
  # validates_attachment_presence :photo
  # validates_attachment_size :photo, :in => 0..200.kilobytes
  # validates_attachment_content_type :photo, :content_type => ['image/pjpeg', 'image/jpg', 'image/jpeg', 'image/png']
  
  scope :status_active, -> {where(status: 'active')}
  
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    spreadsheet.sheets
    header = spreadsheet.sheet('Article').row(1)
    (2..spreadsheet.sheet('Article').last_row).each do |i|
      row = Hash[[header, spreadsheet.sheet('Article').row(i)].transpose]
      article = find_by_id(row["id"]) || new
      article.attributes = row.to_hash.slice(*row.to_hash.keys)
      article.save!
    end
    
    # header = spreadsheet.sheet('Comments').row(1)
      # (2..spreadsheet.sheet('Comments').last_row).each do |i|
        # row = Hash[[header, spreadsheet.sheet('Comments').row(i)].transpose]
        # comments = find_by_id(row["id"]) || new
        # comments.attributes = row.to_hash.slice(*row.to_hash.keys)
        # comments.save!
    # end
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
