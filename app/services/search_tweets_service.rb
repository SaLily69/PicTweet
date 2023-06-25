class SearchTweetsService
  def self.search(search)
    if search != ""
      search = "%#{search}%"
      Tweet.find_by_sql(["select * from tweets where text like ? ", search])
      #Tweet.where('text LIKE(?), "%#{search}%') 一旦削除

    else
      Tweet.all
    end
  end
end