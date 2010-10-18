require 'prawn'

module Playfair
  class PDFRenderer < Renderer
    
    attr_reader :margin, :gutter, :font_size, :label_width, :text_color, :stroke_color
    
    COLORS = ["E213A9","F1A637","B55EF0","42D13E", "F50000","DDE93D","7BD2F9","F78A64"]
    
    def initialize(chart, options={})
      @margin = options[:margin] || 15
      @gutter = options[:gutter] || 15
      @font_size = options[:font_size] || 7
      @label_width = options[:label_width] || 20
      @text_color = options[:text_color] || "333333"
      @stroke_color = options[:stroke_color] || "333333"
      super(chart, options)
    end
    
    render :bar_chart do
      doc = Prawn::Document.new(:page_size => [width, height], :margin => 0)
      x_position = left_margin + gutter + ((chart_width - gutter)%values.size)/2
      draw_title(doc) if title
      
      doc.font_size font_size
      doc.line_width 1.2
      
      values.each_with_index do |value, i|
        # Draw bar
        doc.stroke_color stroke_color
        doc.fill_color color(i)
        bar_height = height_for_bar(value, values.max)
        doc.fill_and_stroke_rounded_rectangle [x_position, bar_height + bottom_margin],
                                              bar_width, bar_height, 2
        
        # Draw label
        doc.fill_color text_color
        text_with_shadow  doc,
                          labels[i], 
                          :at => [x_position, margin + font_size], 
                          :width => bar_width, 
                          :align => :center
        
        x_position += bar_width + gutter
      end

      draw_axes(doc)

      doc.render_file "examples/test.pdf"
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
    
    def bar_width
      ((chart_width - gutter)/values.size) - gutter
    end
    
    def draw_title(doc)
      doc.fill_color text_color
      doc.font_size font_size * 1.35
      text_with_shadow  doc, 
                        title, 
                        :at => [left_margin, height - margin], 
                        :width => chart_width, 
                        :align => :center, 
                        :style => :bold, 
                        :single_line => true
    end
    
    def draw_axes(doc)
      doc.stroke_color stroke_color
      doc.stroke_line [left_margin, bottom_margin], [left_margin + chart_width, bottom_margin]
      doc.stroke_line [left_margin, chart_height + bottom_margin], [left_margin, bottom_margin]
      
      # y-axis labels
      doc.font_size font_size
      doc.fill_color text_color
      
      draw_y_axis_label   doc, "0",
                          [margin,bottom_margin+font_size/2]
      draw_y_axis_label   doc, values.max.to_s,
                          [margin, highest_chart_point + bottom_margin + font_size/2]
      halfway_point = values.max / 2
      draw_y_axis_label   doc, halfway_point.to_s,
                          [margin, highest_chart_point/2 + bottom_margin + font_size/2]
    end
    
    def height_for_bar(value, max_value)
      ratio = highest_chart_point/max_value.to_f
      (value * ratio).to_i
    end
    
    def color(index)
      COLORS[index % COLORS.size]
    end
    
    def highest_chart_point
      chart_height - chart_height/15
    end
    
    def draw_y_axis_label(doc, label, point)
      text_with_shadow  doc,  
                        label, 
                        :at => point, 
                        :width => label_width,
                        :height => font_size,
                        :align => :right,
                        :overflow => :shrink_to_fit
    end
    
    def text_with_shadow(doc, text, options={})
      at = options[:at]
      doc.transparent(0.3) do
        doc.text_box text, options.merge(:at => [at.first, at.last + doc.font_size/22.0])
      end     
      doc.text_box text, options
    end
  end
end