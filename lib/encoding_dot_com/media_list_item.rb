module EncodingDotCom

  # Represents a video or image in the encoding.com queue
  class MediaListItem
    attr_reader :media_file, :media_id, :media_status, :create_date, :start_date, :finish_date

    # Creates a MediaListItem, given a <media> Nokogiri::XML::Node
    #
    # See the encoding.com documentation for GetMediaList for more details
    def initialize(node)
      @media_file = (node / "mediafile").text
      @media_id = (node / "mediaid").text.to_i
      @media_status = (node / "mediastatus").text
      @create_date = parse_time_node(node / "createdate")
      @start_date = parse_time_node(node / "startdate")
      @finish_date = parse_time_node(node / "finishdate")
    end

    private

    def parse_time_node(node)
      # Isn't there an easier way to return a Time object = date string??
      begin
        dt = DateTime.parse(node.text)
        Time.local dt.year, dt.mon, dt.mday, dt.hour, dt.min, dt.sec
      rescue
        nil
      end
    end
  end
end
