# encoding: utf-8

namespace :send_reminder do
    desc "Users中confirm_atから１週間が経過していれば削除"
    task :send_reminder => :environment do
      Catering.all.each do |h|
        c_time = Time.now
        current_time = c_time.strftime('%Y-%m-%d %H:%M')
        d_time = h.arrived_at - 1.hour
        delivery_time = d_time.strftime('%Y-%m-%d %H:%M')
        if current_time == delivery_time
          @catering = h
          @user = h.user
          NoticeMailer.sendmail_confirm(@user, @catering).deliver
        end
      end
    end
end
