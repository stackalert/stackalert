# frozen_string_literal: true

class Check
  class CreateChart
    def initialize(check)
      @check = check
    end

    def execute
      chart.file
      @check.charts.attach(io: File.open(path), filename: filename, content_type: 'image/png')
    end

    private

    def data
      @data ||= @check.check_pings.pluck(:total_time).last(100)
    end

    def path
      "tmp/#{filename}"
    end

    def filename
      @filename ||= "check_#{@check.id}_#{Time.now.to_i}.png"
    end

    def chart
      @chart ||= Gchart.new(bg: { color: 'efefef', type: 'stripes' }, type: 'line', title: @check.name,
                            theme: :thirty7signals, data: data, line_colors: '1d2c4c', legend: ['Response Time'],
                            size: '700x400', axis_with_labels: 'y', filename: path)
    end
  end
end
