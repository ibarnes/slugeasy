# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def getneed(id)
    if id == '1'
      @need = "ride"
    else
      @need = "passenger"
    end

    return @need
  end

  def get_musicpreference(id)
    if id == '1'
      @need = "Prefer"
    elsif id == '2'
      @need = "Prefer Not"
    else
      @need = "Does Not Matter"
    end

    return @need
  end

  def get_noisepreference(id)
    if id == '1'
      @need = "Prefer Silence"
    elsif id == '2'
      @need = "Prefer Conversations"
    else
      @need = "Does Not Matter"
    end

    return @need
  end

  #Returns the message limit for each plancode
  def get_message_limit(plancode)
    if plancode == 'Pro'
      return 1000
    elsif plancode == 'Basic'
      return 30
    elsif plancode == 'Free'
      return 15
    end
  end


  # If not paid remove the ability to post messages after 15 in a month
  def post_limit(limit)
    #if Post.find_all_by_created_at(Date.today-1..Date.today).size < 4
    
    @post_by_month = current_user.posts.find(:all).group_by { |post| post.created_at.strftime("%B-%y") }
    
    @post_by_month.each do |monthname, posts|
      if monthname == Time.now.strftime("%B-%y")
        if posts.size >= limit
          return false #Hides the content
        else
          return true #Show the content
        end
      end
    end
  end

  def last_day_of_the_month yyyy, mm
    d = new yyyy, mm                        # no day means the first one
    d += 42                                 # always the next month
    new(d.year, d.month) - 1
  end

  def all_post
    Post.paginate_all_by_user_id(current_user.followers.map(& :id).push(self.id), :page => params[:page], :per_page => 10, :order=>'created_at desc')
  end

  def gettimes
    
    @times =
      '5:00 AM', '5:30 AM', '6:00 AM', '6:30 AM', '7:00 AM', '7:30 AM',
      '8:00 AM', '8:30 AM', '9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM', '11:00 AM', '11:30 AM',
      '12:00 PM', '12:30 PM', '1:00 PM', '1:30 PM', '2:00 PM', '2:30 PM', '3:00 PM', '3:30 PM',
      '4:00 PM', '4:30 PM', '5:00 PM', '5:30 PM', '6:00 PM', '6:30 PM'
  end

end
