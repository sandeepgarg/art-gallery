class GalleryAnalyticsController < ApplicationController
  def home

  end

  def parse_gallery_log

    #parsing uploaded file
    parsed_result = LogFile.parse_file(params[:file])

    if parsed_result
      name = params[:file].original_filename
      content_type = params[:file].content_type
      log_file = LogFile.create(name: name, content_type: content_type)
      log_file.save_parsed_result(parsed_result)
    else
      flash[:error] =  "Upload text or csv file"
      redirect_to home_path
      return
    end
    redirect_to gallery_analytics_path
=begin
    file = File.open params[:file].path
    number_of_lines = file.readline
    @log_hash = {}
    number_of_lines.to_i.times do
      room_log = file.readline
      room_log_arr = room_log.split(' ')
      room_log_arr[3] = room_log_arr[3].to_i
      stay = 0

      if @log_hash.key?(room_log_arr[1])
        if @log_hash[room_log_arr[1]].key?(room_log_arr[0])
          if @log_hash[room_log_arr[1]][room_log_arr[0]][:status] == 'I'
            stay =  room_log_arr[3] - @log_hash[room_log_arr[1]][room_log_arr[0]][:timestamp]
          elsif @log_hash[room_log_arr[1]][room_log_arr[0]][:status] == 'O'
            stay =  @log_hash[room_log_arr[1]][room_log_arr[0]][:timestamp] - room_log_arr[3]
          end
          @log_hash[room_log_arr[1]][:visitor_count] += 1
          @log_hash[room_log_arr[1]][:stay] += stay
          @log_hash[room_log_arr[1]][:average_stay] = @log_hash[room_log_arr[1]][:stay] / @log_hash[room_log_arr[1]][:visitor_count]

        end

        @log_hash[room_log_arr[1]][room_log_arr[0]] = {
            status: room_log_arr[2],
            timestamp: room_log_arr[3],
            stay: stay
        }
      else
        @log_hash[room_log_arr[1]] = {
            room_log_arr[0] => {
                status: room_log_arr[2],
                timestamp: room_log_arr[3],
                stay: stay
            },
            average_stay: 0,
            visitor_count: 0,
            stay: 0
        }
      end
    end
    file.close
=end

  end

  def index
    @log_files  = LogFile.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @log_file = LogFile.find(params[:id])
  end

end
