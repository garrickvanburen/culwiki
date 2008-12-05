xml.instruct! :xml, :version=>"1.0" 

xml.rss(:version => "2.0", 
		'xmlns:content' => "http://purl.org/rss/1.0/modules/content/", 
		'xmlns:wfw' 	=> "http://wellformedweb.org/CommentAPI/", 
		'xmlns:dc' 		=> "http://purl.org/dc/elements/1.1/",
		'xmlns:itunes' 	=> "http://www.itunes.com/dtds/podcast-1.0.dtd",
		'xmlns:media' 	=> "http://search.yahoo.com/mrss/"
		) {

  xml.channel{
    xml.title("Wiki.Cullect.com / #{@page.title.gsub('_', ' ')}" )
    xml.link("#{page_base_url(:page_title => @page.title)}") 
    xml.language("en-us")
	xml.lastBuildDate(Time.now.rfc2822)
	xml.generator("Wiki.Cullect.com")

    @revisions.each do |revision|
    
		xml.item do			
      		xml.title revision.created_on
			xml.dc(:creator){xml.text! Person.find(revision.created_by).name}
      		xml.description h(revision.parsed_contents)
	  		xml.content(:encoded){xml.cdata! revision.parsed_contents}
      		xml.pubDate revision.created_on.rfc2822
	  		xml.guid "#{revision.page.title}-#{revision.id}"
		end
		
    end
  }

}