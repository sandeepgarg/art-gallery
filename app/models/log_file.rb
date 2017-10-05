class LogFile < ApplicationRecord
  has_many :rooms
  has_many :visitors

  def self.parse_file(file)

    content_type = file.content_type
    #validating file content type
    if content_type == 'text/plain' || content_type == 'text/csv'

      #opening uploaded file
      file_pointer = File.open file.path

      #counting how much line to be parsed
      number_of_lines = file_pointer.readline

      log_hash = {}

      #loop to iterate over the lines
      number_of_lines.to_i.times do

        #reading log file line
        room_log = file_pointer.readline

        #splits log entry by space
        room_log_arr = room_log.split(' ')

        visitor = room_log_arr[0].to_i
        room = room_log_arr[1].to_i
        status = room_log_arr[2]
        timestamp = room_log_arr[3].to_i

        stay = 0

        if log_hash.key?(visitor)
          if log_hash[visitor].key?(room)
            if log_hash[visitor][room][:status] == 'I'
              stay = timestamp - log_hash[visitor][room][:timestamp]
            elsif log_hash[visitor][room][:status] == 'O'
              stay = log_hash[visitor][room][:timestamp] - timestamp
            end
            log_hash[visitor][:room_count] += 1
            log_hash[visitor][:stay] += stay
            log_hash[visitor][:average_stay] = log_hash[visitor][:stay] / log_hash[visitor][:room_count]

          end

          log_hash[visitor][room] = {
              status: status,
              timestamp: timestamp,
              stay: stay
          }
        else
          log_hash[visitor] = {
              room => {
                  status: status,
                  timestamp: timestamp,
                  stay: stay
              },
              average_stay: 0,
              room_count: 0,
              stay: 0
          }
        end
      end
      file_pointer.close
      log_hash

    else
      return false
    end
  end

  def save_parsed_result(log_hash)
    log_hash.each do |visitor_id, visitor_hash|
      Visitor.create_entry(self.id, visitor_id, visitor_hash)
    end
  end

end
