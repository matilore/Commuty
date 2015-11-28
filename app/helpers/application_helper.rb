module ApplicationHelper

	def show_new_line(s)
	  s.gsub!(/\n/, '<br>')
	end
end
