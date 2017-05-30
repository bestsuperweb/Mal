require "opentok"
class ClassRoomsController < ApplicationController
  before_filter :authenticate_user!, except: :demo
  before_filter :config_opentok
	layout "application"

  def demo
    session = @opentok.create_session
    @test_user = User.new(first_name: "Test", last_name: "Teacher")
    @teacher = current_user || @test_user
    @student = current_user || @test_user
    @lesson = Lesson.new
    @class_room = ClassRoom.create(sessionId: session.session_id)
    @end_class = 1.hour.from_now.to_s(:long)

    @sessionId = @class_room.sessionId
    @apiKey = @opentok.api_key
    @token = @opentok.generate_token(@sessionId)
    @class_room.sender = @test_user
    @class_room.recipient =  @test_user

    # @messages = @class_room.messages
    # @message = Message.new
    @demo = true
    @subscribe_path = "/demo"
    render :class, layout: false
  end

  # POST create ClassRoom
  def request_class
  	session = @opentok.create_session
  	params[:class_room][:sessionId] = session.session_id
		@class_room = ClassRoom.new(class_room_params)
    @teacher = User.find_by_id(params[:class_room][:teacher_id])

    respond_to do |format|
      if current_user.available_credits_count > 0
        if @class_room.save
          format.json { render json: @class_room, status: :created, location: profile_path(@teacher.id) }
        else
          format.json { render json: @class_room.errors, status: :unprocessable_entity }
        end
      else
        format.json { render json: "Unfortunately, you don't have enough credits to request a class.", status: :unprocessable_entity}
      end
    end
	end

  def class_chat
  	@user ||= current_user
    @class_room = ClassRoom.find(params[:id])
    @end_class = @class_room.availability.end_time.to_s(:long)
    @lesson = @class_room.lesson
    @subscribe_path = class_chat_path(@class_room.id)
  	if @user.teacher?
  		@teacher = @user
    	@student = User.find_by_id(@class_room.student_id)
    else
    	@student = @user
    	@teacher = User.find_by_id(@class_room.teacher_id)
    end
    @sessionId = @class_room.sessionId
    @apiKey = @opentok.api_key
    @token = @opentok.generate_token(@sessionId)

    # @messages = @class_room.messages
    # @message = Message.new

    render :class, layout: false
  end

  private
	  def config_opentok
	    if @opentok.nil?
	      @opentok = OpenTok::OpenTok.new(45523022 , "23ead43bba2b4d3382e73ae346f925320feab727")
	    end
	  end

	  def class_room_params
	  	params.require(:class_room).permit!
	  end
end
