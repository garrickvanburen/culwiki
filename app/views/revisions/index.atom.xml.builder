xml.instruct!
xml.feed "xml:lang" => "en-us", "xmlns" => "http://www.w3.org/2005/Atom" do
	xml.title("type" => "text"){xml.text! "Wiki.Cullect.com / Revisions"}
  	xml.link("rel" 	 => "self",  "type" => "application/xhtml+xml", 	"href" => "#{root_url}revisions")
  	xml.link("rel" 	 => "alternate", "type" => "application/atom+xml", 	"href" => "#{root_url}revisions.atom")
	
	@revisions.reverse.collect{|a| a.created_by}.flatten.uniq.each do |author|
		xml.author {
			xml.name Person.find(author).name
		}
	end
	
	xml.updated @revisions.first.created_on 

	xml.generator("url" => root_url, "version" => "0.5"){xml.text! "Wiki.Cullect.com"}

    for revision in @revisions
      	xml.entry do
      		xml.title("type" => "text"){xml.text! "#{revision.page.title.gsub('_', ' ')}"}
			xml.id "#{revision.page.title}-#{revision.id}"
			xml.author{
				xml.name  Person.find_by_cullect_id(revision.created_by).name 
			}
			xml.content("type" => "xhtml"){xml.cdata! revision.parsed_contents}	
		 	xml.published(revision.created_on.strftime("%Y-%m-%dT%H:%M:%S"))
        	
      	end
    end

end