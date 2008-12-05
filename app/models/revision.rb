class Revision < ActiveRecord::Base

  belongs_to  :page
  belongs_to  :person, :foreign_key => 'created_by',  :class_name => 'Person'

  def parsed_contents
    contents = self.contents.gsub(/\s(.*.(jpg|gif|png))\s/, '<img src="\1"/>')
    contents = contents.gsub(/\*(.*)\*/, '<strong>\1</strong>')
    contents = contents.gsub(/@(.*)@/, '<code>\1</code>')
    contents = contents.gsub(/\s\"(.*)\"\s/, '<blockquote>"\1"</blockquote>')    
    contents = contents.gsub(/\s\_(.*)\_\s/, '<em>\1</em>')    
    contents = contents.gsub(/\s(\w*_\w*)\s/) {|match| "<a href='#{match.downcase.strip}'>#{match.gsub('_', ' ').strip}</a>"}
    
    h = Haml::Engine.new(contents)
    h.to_html
  end

end
