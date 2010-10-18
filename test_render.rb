#!/usr/bin/env ruby
require 'rubygems'
require 'playfair'

chart = Playfair::Chart.new do
  value 90, "3am"
  value 77, "6am"
  value 130, "9am"
  value 69, "12pm"
  value 45, "3pm"
  value 74, "6pm"
  value 80, "9pm"
end
chart.renderer = Playfair::PDFRenderer
chart.title = "Internet Users by Time of Day"

chart.render :line_chart