class NodesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :set_node, only: [:show, :edit, :update, :destroy, :facts, :resources, :status_history, :resource_times]

  def index
    @nodes = Node.order(sort_column + " " + sort_direction)

    render_index(@nodes)
  end

  def show
    @reports = @node.reports.order("time DESC").page params[:page]

    respond_to do |format|
      format.html # show.html.erb
      format.js # show.js.erb
      format.json { render json: @node }
      format.yaml { render text: @node.to_yaml, content_type: 'text/yaml' }
    end
  end

  def new
    @node = Node.new
  end

  def edit
  end

  def create
    @node = Node.new(params[:node])

    render_create(@node)
  end

  def update
    render_update(@node, params[:node])
  end

  def destroy
    render_destroy(@node)
  end

  def unresponsive
    @nodes = Node.unresponsive.order(sort_column + " " + sort_direction)
    render 'index'
  end

  def failed
    @nodes = Node.failed.order(sort_column + " " + sort_direction)
    render 'index'
  end

  def pending
    @nodes = Node.pending.order(sort_column + " " + sort_direction)
    render 'index'
  end

  def changed
    @nodes = Node.changed.order(sort_column + " " + sort_direction)
    render 'index'
  end

  def unchanged
    @nodes = Node.unchanged.order(sort_column + " " + sort_direction)
    render 'index'
  end

  def unreported
    @nodes = Node.unreported.order(sort_column + " " + sort_direction)
    render 'index'
  end

  def facts
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @node.facts }
    end
  end

  def resources
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @node.resources }
    end
  end

  def status_history
    render :json => @node.reports.where("time > '#{Time.now - 60*60*24}'").group(:status).count
  end

  def resource_times
    @report = @node.reports.order("time DESC").first
    if @report
      @metrics = @report.metrics.where(:category => "Time")
      @metrics.reject! {|n| n.name == "Total"}
      @metrics = @metrics.collect {|n| [n.name, n.value]}
    else
      @metrics = []
    end
    render :json => @metrics
  end

  private

  def set_node
    @node = Node.find_by_name(params[:id])
  end

  def sort_column
    Node.column_names.include?(params[:sort]) ? params[:sort] : "reported_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
