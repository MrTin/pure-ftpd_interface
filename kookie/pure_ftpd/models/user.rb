class User < Sequel::Model(:users)

  def self.create(username, password)
    insert(:User => username, :Password => Digest::MD5.hexdigest(password))
  end
end
