class InterviewsController < ApplicationController
  before_action :set_interview, only: %i[ show edit update destroy ]
  # GET /interviews or /interviews.json
  def index
    @interviews = Interview.all
    @document_submit_interviews = Interview.where(status: "document_submit")
    @first_interviews = Interview.where(status: "first_interview")
    @second_interviews = Interview.where(status: "second_interview")
    @third_interviews = Interview.where(status: "third_interview")
    @get_hired_interviews = Interview.where(status: "get_hired")
    @end_interviews = Interview.where(status: "end_interview")
  end

  # GET /interviews/1 or /interviews/1.json
  def show
    @interviews = Interview.where(title: @interview.title).order(created_at: :asc)
  end

  # GET /interviews/new
  def new
    @interview = Interview.new
  end

  # GET /interviews/1/edit
  def edit
    @interviews = Interview.where(title: @interview.title).order(created_at: :asc)
  end

  # POST /interviews or /interviews.json
  def create
    @interview = Interview.new(interview_params)

    respond_to do |format|
      if @interview.save

        @company = Company.find_or_create_by(title: @interview.title)
        @company.select_status = @interview.status
        @company.save
        format.html { redirect_to @interview, notice: "Interview was successfully created." }
        format.json { render :show, status: :created, location: @interview }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interviews/1 or /interviews/1.json
  def update
    respond_to do |format|
      if @interview.update(interview_params)
        format.html { redirect_to @interview, notice: "Interview was successfully updated." }
        format.json { render :show, status: :ok, location: @interview }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interviews/1 or /interviews/1.json
  def destroy
    title = @interview.title
    @company = Company.where(title: @interview.title).first
    if @interview.destroy!
      @interviews = Interview.where(title: title)
      if @interviews.present?
        @recent_interview = Interview.where(title: title).order(created_at: :desc).first
        @company.select_status = @recent_interview.status
        @company.save
      else
        @company.destroy!
      end
      redirect_to interviews_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interview
      @interview = Interview.find_by(id: params.expect(:id))
      redirect_to interviews_path if @interview.nil?
    end

    # Only allow a list of trusted parameters through.
    def interview_params
      params.expect(interview: [ :title, :status, :content ])
    end
end
