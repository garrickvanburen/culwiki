class Page < ActiveRecord::Base

  has_many  :revisions

  def clean_title
    self.title.gsub('_', ' ')
  end
  
  def visible_revision
    Revision.find_by_page_id_and_is_live(self.id, 1)
  end

  def has_revisions?
    Revision.find_by_page_id(self.id)
  end

  def has_linkages?
    p = Page.count_by_sql("SELECT DISTINCT COUNT(pages.id) FROM pages JOIN revisions ON pages.id = revisions.page_id WHERE revisions.contents REGEXP '#{self.title}'")
    true if p > 0
  end

  def linkages
    Page.find_by_sql("SELECT DISTINCT pages.* FROM pages JOIN revisions ON pages.id = revisions.page_id WHERE revisions.contents REGEXP '#{self.title}'")
  end

end
