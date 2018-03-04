# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# 出力先のログファイルの指定
set :output, 'log/crontab.log'
# ジョブの実行環境の指定
set :environment, :production
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# every 1.minute do
#   rake 'tweet_delete_with_Post_model'
# end

every 30.minutes do
  rake 'twi_bot:random_tweet'
end

every 15.minutes do
  rake 'twi_bot:delete_latest_post'
end

# 重複したPostモデルを削除
every 1.hours, at: 12 do
  rake 'twi_bot:remove_duplicate_posts'
end

# Learn more: http://github.com/javan/whenever
