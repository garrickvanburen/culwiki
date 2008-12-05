class PagesController < ApplicationController
  
  before_filter :logged_in?, :only => [:edit]
  
  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.find(:all)
    get_format('index')
  end

  def search
    query = params[:pages][:title]
    @pages = Page.find(:all, :conditions => ["revisions.contents REGEXP '#{query}' OR pages.title REGEXP '#{query}' "], :include => 'revisions')
    get_format('search')
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find_or_create_by_title(params[:page_title])
    if @page.has_revisions?
      get_format('show')
    else
      redirect_to page_edit_url(:page_title => @page.title)
    end
  end


  def history
    @page = Page.find_or_create_by_title(params[:page_title])
    @revisions = @page.revisions.reverse || Revision.new 
    get_format('history')
  end



  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end


  # GET /pages/1/edit
  def edit
    @page = Page.find_or_create_by_title(params[:page_title])
    @revision = @page.revisions.last || Revision.new
    Person.find_by_cullect_id(cookies[:person_id]) || Person.make_from_cullect_id(cookies[:person_id])
  end


  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to(@page) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(pages_url) }
      format.xml  { head :ok }
    end
  end
 
 
  def get_format(action)

    respond_to do |format|
      format.html
      format.atom {render :template => "pages/#{action}.atom.xml.builder"}
      format.json      
      format.m
      format.rss {render :template => "pages/#{action}.rss.xml.builder"}
      format.yml       
    end    
    
  end
  
end
