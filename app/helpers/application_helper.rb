module ApplicationHelper

	def show_new_line(s)
	  s.gsub!(/\n/, '<br>')
	end



	def notifies_pending_request_to_answer
  		Request.show_number_pending_requests(current_user.id)
  	end



  	def notifies_revisions_of_own_post
  		counter = 0
  		posts = Post.where(user_id: current_user.id)
  		revisions = posts.map do |post|
  			if Revision.where(post_id: post.id) != nil
  				counter += Revision.where(post_id: post.id).size
  			end	
  		end
  		counter
  	end



  	def show_if_you_request_for_this_post(post_id, current_user)
  		pending_request = Request.editor_pending?(post_id, current_user)
  		if pending_request && pending_request.size == 1
  			("<p class= 'pull-right' style = 'margin-top: -18px;'>
  				<em>You have already request to revision this text</em> <span class='glyphicon glyphicon-question-sign'>
  				</span></p>").html_safe
  		end
  	end



  	def show_if_you_wrote_revision_for_this_post(post_id, current_user)
  		accepted_request = Request.editor_accepted?(post_id, current_user)[0]
  		if accepted_request != nil
  		if accepted_request && accepted_request.revision
  			
  			if accepted_request.revision.written == true
  				("<p class= 'pull-right' style = 'margin-top: -18px;'>
  				<em>You have already written a revision for this text </em><span class='glyphicon glyphicon-check'>
  				</span></p>").html_safe
  			end
  		end
  		end		
  	end



  	def show_req_rev_status(post_id, current_user)
  		if show_if_you_request_for_this_post(post_id, current_user)
  			show_if_you_request_for_this_post(post_id, current_user)
  		elsif show_if_you_wrote_revision_for_this_post(post_id, current_user)
  			show_if_you_wrote_revision_for_this_post(post_id, current_user)
  		else
  			return
  		end		
  	end

    def show_text_preview(text)
      text = text.split(' ')
      text = text[0..80].join(' ')
      text = text + '...'
      return text

      
    end

  end
