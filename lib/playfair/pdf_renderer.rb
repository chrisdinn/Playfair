require 'prawn'

module Playfair
  class PDFRenderer < Renderer
    
    attr_reader :margin, :gutter, :font_size, :label_width, :text_color, :stroke_color, :output_filename
    
    COLORS = ["E213A9","F1A637","B55EF0","42D13E", "F50000","DDE93D","7BD2F9","F78A64"]
    
    def initialize(chart, options={})
      @margin = options[:margin] || 15
      @gutter = options[:gutter] || 15
      @font_size = options[:font_size] || 7
      @label_width = options[:label_width] || 20
      @text_color = options[:text_color] || "333333"
      @stroke_color = options[:stroke_color] || "333333"
      @output_filename = options[:to] || "chart.pdf"
      super(chart, options)
    end
    
    render :bar_chart do
      draw_chart do |pdf|
        x_position = starting_x_position
      
        values.each_with_index do |value, i|
          # Draw bar
          pdf.fill_color color(i)
          bar_height = height_for_value(value, values.max)
          pdf.fill_and_stroke_rounded_rectangle [x_position, bar_height + bottom_margin],
                                                bar_width, bar_height, 2
        
          # Draw label
          pdf.fill_color text_color
          text_with_shadow  pdf, labels[i], 
                            :align => :center,
                            :at => [x_position, margin + font_size], 
                            :width => bar_width, 
                            :overflow => :shrink_to_fit
        
          x_position += bar_width + gutter
        end
      end
    end
    
    render :line_chart do
      draw_chart do |pdf|
        x_position = starting_x_position
        values.each_with_index do |value, i|
          # Draw line
          if values[i + 1]
            pdf.stroke_line   x_position,
                              height_for_value(value, values.max) + bottom_margin,
                              x_position + point_interval,
                              height_for_value(values[i + 1], values.max) + bottom_margin
            x_position += point_interval
          end
        end
        
        # Draw points
        x_position = starting_x_position
        values.each do |value|
          pdf.fill_circle_at [x_position, height_for_value(value, values.max) + bottom_margin], :radius => 3
          x_position += point_interval
        end
        
        # Draw labels
        x_position = starting_x_position
        values.each_with_index do |value, i|
          pdf.fill_color text_color
          text_with_shadow  pdf, labels[i], 
                            :align => :center,
                            :at => [x_position - point_interval/2, margin + font_size], 
                            :width => point_interval, 
                            :overflow => :shrink_to_fit
          x_position += point_interval
        end
      end
    end
    
    private
    
    def chart_width
      right_margin = margin      
    
      width - left_margin - right_margin
    end
    
    def chart_height
      height - top_margin - bottom_margin
    end
    
    def top_margin
      top = margin
      top += font_size + margin if title 
      top
    end
    
    def left_margin
      margin + label_width + 3
    end
    
    def bottom_margin
      margin + font_size + 3
    end
    
    def starting_x_position
      left_margin + gutter + ((chart_width - gutter)%values.size)/2
    end
    
    def bar_width
      ((chart_width - gutter)/values.size) - gutter
    end
    
    def point_interval
      (chart_width - gutter*2)/(values.size - 1)
    end
    
    def draw_chart
      pdf = Prawn::Document.new(:page_size => [width, height], :margin => 0)
      pdf.line_width 1.2
      pdf.stroke_color stroke_color
      
      draw_title(pdf) if title
      draw_y_axis(pdf)
      yield(pdf)
      draw_x_axis(pdf)
      
      pdf.render_file output_filename
    end
    
    def draw_title(pdf)
      pdf.font_size font_size * 1.6
      text_with_shadow  pdf, 
                        title, 
                        :at => [left_margin, height - margin], 
                        :width => chart_width, 
                        :align => :center, 
                        :style => :bold, 
                        :single_line => true
      pdf.font_size font_size
    end
    
    def draw_x_axis(pdf)
      pdf.stroke_line [left_margin, bottom_margin], [left_margin + chart_width, bottom_margin]
    end
    
    def draw_y_axis(pdf)      
      draw_y_axis_label   pdf, "0",
                          [margin,bottom_margin+font_size/2.5]
      
      max_line_height = chart_height + bottom_margin
      draw_y_axis_label   pdf, values.max.to_s,
                          [margin, max_line_height + font_size/2.5]
              
      halfway_line_height = chart_height/2 + bottom_margin
      halfway_point = values.max / 2
      draw_y_axis_label   pdf, halfway_point.to_s,
                          [margin, halfway_line_height + font_size/2.5]
      
      pdf.transparent(0.3) do  
        pdf.dash 2, :space => 1                  
        pdf.stroke_line     [left_margin, max_line_height], [left_margin + chart_width, max_line_height]
        pdf.stroke_line     [left_margin, halfway_line_height], [left_margin + chart_width, halfway_line_height] 
        pdf.undash
      end                   
    end
    
    def height_for_value(value, max_value)
      ratio = chart_height/max_value.to_f
      (value * ratio).to_i
    end
    
    def draw_y_axis_label(pdf, label, point)
      text_with_shadow  pdf,  
                        label, 
                        :at => point, 
                        :width => label_width,
                        :height => font_size,
                        :align => :right,
                        :overflow => :shrink_to_fit
    end
    
    def text_with_shadow(pdf, text, options={})
      at = options[:at]
      pdf.transparent(0.3) do
        pdf.text_box text, options.merge(:at => [at.first, at.last + pdf.font_size/22.0])
      end     
      pdf.text_box text, options
    end
    
    def color(index)
      COLORS[index % COLORS.size]
    end
  end
end