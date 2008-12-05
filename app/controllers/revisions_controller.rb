class RevisionsController < ApplicationController

  # GET /revisions
  # GET /revisions.xml
  def index
    #limit
    #order
    @revisions = Revision.find(:all, :limit => 20, :order => 'created_on DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.atom {render :template => 'revisions/index.atom.xml.builder'}
      format.json      
      format.m
      format.rss {render :template => 'revisions/index.rss.xml.builder'}
      format.yml
    end      
  end

  # GET /revisions/1
  # GET /revisions/1.xml
  def show
    @revision = Revision.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @revision }
    end
  end

  # GET /revisions/new
  # GET /revisions/new.xml
  def new
    @revision = Revision.create(params[:revision])
    redirect_to page_base_url(:page_title => @revision.page.title)
  end

  # GET /revisions/1/edit
  def edit
    @revision = Revision.find(params[:id])
  end

  # POST /revisions
  # POST /revisions.xml
  def create
    @revision = Revision.create(params[:revision])
    redirect_to page_base_url(:page_title => @revision.page.title)
  end

  # PUT /revisions/1
  # PUT /revisions/1.xml
  def update
    @revision = Revision.find(params[:id])

    respond_to do |format|
      if @revision.update_attributes(params[:revision])
        flash[:notice] = 'Revision was successfully updated.'
        format.html { redirect_to(@revision) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @revision.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /revisions/1
  # DELETE /revisions/1.xml
  def destroy
    @revision = Revision.find(params[:id])
    @revision.destroy

    respond_to do |format|
      format.html { redirect_to(revisions_url) }
      format.xml  { head :ok }
    end
  end
end
