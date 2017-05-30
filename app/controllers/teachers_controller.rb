class TeachersController < ApplicationController
	before_filter :authenticate_user!, except: [:index, :show]
	layout "application"

	def index
		@user ||= current_user
		@q = User.teachers.verified.ransack(params[:q])
  	@teachers = @q.result(distinct: true)
	end

	def show
		@user = User.find(params[:id])
		@stuff = @user.teacher_stuff
		@lessons = @user.lessons
		@class_room = ClassRoom.new
	end

	def teacher_stuff
    @user ||= current_user
    @stuff = TeacherStuff.new
    @stuff.user_id = @user.id
    render :teacher_stuff
  end

  def create_teacher_stuff
    @user ||= current_user
    @stuff = TeacherStuff.new(stuff_params)
    if @stuff.save
      redirect_to lesson_path
    else
      render :teacher_stuff
    end
  end

  def create_review
		@teacher = User.find_by_id(params[:review][:user_id])
		@review = Review.new(review_params)

		if @review.save
			flash[:notice] = "Your review has been created!"
			redirect_to profile_path(@teacher.id)
		else
			redirect_to profile_path(@teacher.id), notice: "Error"
		end
	end

	def new_lesson
		@user ||= current_user
		@lesson = Lesson.new
		@lesson.user_id = @user.id
	end

	def create_lesson
		@user ||= current_user
		@lesson = current_user.lessons.new(lesson_params)
		if @lesson.save
			redirect_to profile_path
		else
			render :new_lesson
		end
	end

	def check_request
		@class = ClassRoom.find_by_id(params[:id])
		if params[:reject]
			@class.delete
		else
			@class.update_attributes(approve: true)
			current_user.increment(:lesson_count)
			current_user.save
		end
		@requests = current_user.class_rooms.requests.reload
		@class_chats = current_user.class_rooms.class_chats.active
		respond_to do |format|
			format.js
		end
	end

	def add_available
		@user ||= current_user
		@availability = @user.availabilities.new(availability_params)
		@availability.user_id = @user.id
		respond_to do |format|
			if @availability.save
				flash.now[:notice] = "Time was added!"
				format.json { render json: @availability, status: :created, location: profile_path }
			else
				flash.now[:alert] = "Error!"
				format.json { render json: @availability.errors, status: :unprocessable_entity }
			end
		end
	end

	def remove_available
		@user ||= current_user
		@availability = @user.availabilities.where(id: params[:id]).first
		respond_to do |format|
			if @availability && @availability.user == current_user && @availability.destroy
				flash.now[:notice] = "Availability was removed!"
				format.json { render json: {success: true}, status: 200 }
			else
				flash.now[:alert] = "Something went wrong!"
				format.json { render json: @availability.try(:errors), status: :unprocessable_entity }
			end
		end

		#TODO: make sure we notify any users who requested this time that their request was rejected
	end

  # render events.json for calendar
	def events
		@user = User.find_by_id(params[:id]) || current_user
		@avas = @user.availabilities
		@events = @avas.map do |event|
			if event.start_time < DateTime.now
				color = "#D8841B"
				status = "past"
			elsif event.class_rooms.class_chats.present?
				color = "#c70019"
				status = "accepted"
			elsif event.class_rooms.for_student(current_user).present?
				color = "#36B3DB"
				status = "requested"
			else
				color = "#56BF56"
				status = "available"
			end
			{ id: event.id, start: event.start_time, end: event.end_time, color: color, eventBackgroundColor: color, status: status }
		end

		respond_to do |format|
			format.json { render json: @events }
		end
	end

	private
		def lesson_params
			params.require(:lesson).permit!
		end

    def stuff_params
      params.require(:teacher_stuff).permit!
    end

    def review_params
    	params.require(:review).permit!
    end

    def availability_params
    	params.require(:availability).permit(:start_time, :end_time)
    end
end
