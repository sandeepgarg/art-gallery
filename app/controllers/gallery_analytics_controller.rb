class GalleryAnalyticsController < ApplicationController
  def home

  end

  def parse_gallery_log
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
    render :show
  end

  def show

  end

end
